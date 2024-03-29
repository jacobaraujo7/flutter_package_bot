import 'dart:io';

import 'package:auto_injector/auto_injector.dart';
import 'package:dart_backend/domain/entities/package_entity.dart';
import 'package:dart_backend/domain/usecases/read_package_names.dart';
import 'package:dart_backend/infra/remote_package_repository.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uno/uno.dart';

import 'domain/repositories/package_repository.dart';
import 'domain/usecases/get_package_by_name.dart';
import 'domain/usecases/notify_new_version_package.dart';
import 'external/datasources/realm_db_datasource.dart';
import 'external/datasources/remote_discord_notification.dart';
import 'external/datasources/remote_pubdev_package.dart';
import 'infra/datasources/db_datasource.dart';
import 'infra/datasources/discord_notification.dart';
import 'infra/datasources/pubdev_datasource.dart';

final _injector = AutoInjector(
  on: (i) {
    // lib
    i.add<Uno>(Uno.new);
    i.add<PubClient>(PubClient.new);

    // external
    i.add<DiscordNotificationDatasource>(RemoteDiscordNotification.new);
    i.add<DBDatasource>(RealmDBDatasource.new);
    i.add<PubDevDatasource>(RemotePubDevDatasource.new);

    // infra
    i.add<PackageRepository>(RemotePackageRepository.new);

    //domain
    i.add<GetPackageByName>(DBGetPackageByName.new);
    i.add<NotifyNewVersionPackage>(DiscordNotifyNewVersionPackage.new);
    i.add<ReadPackageName>(IOReadPackageName.new);

    //main
    i.addSingleton<FlutterPackageBot>(_FlutterPackageBot.new);

    i.commit();
  },
);

abstract class FlutterPackageBot {
  FlutterPackageBot._();

  static FlutterPackageBot instance() {
    return _injector.get<FlutterPackageBot>();
  }

  Stream<String> run(String txtPath);
}

class _FlutterPackageBot implements FlutterPackageBot {
  final NotifyNewVersionPackage _notifyNewVersionPackage;
  final GetPackageByName _getPackageByName;
  final ReadPackageName _readPackageName;

  _FlutterPackageBot(
    this._notifyNewVersionPackage,
    this._getPackageByName,
    this._readPackageName,
  );

  @override
  Stream<String> run(String txtPath) async* {
    final file = File(txtPath);

    final names = await _readPackageName(file);

    for (final name in names) {
      yield await _getPackageByName(name) //
          .flatMap<PackageEntity>((s) {
            if (s.hasNewVersion) {
              return _notifyNewVersionPackage(s);
            }
            return s.toSuccess();
          })
          .map((success) => 'Package ${success.name}: Updated(${success.hasNewVersion})')
          .mapError((error) => error.toString())
          .fold(id, id);

      await Future.delayed(Duration(seconds: 5));
    }
  }
}
