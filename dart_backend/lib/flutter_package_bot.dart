import 'dart:io';

import 'package:auto_injector/auto_injector.dart';
import 'package:dart_backend/domain/usecases/read_package_names.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import 'domain/usecases/get_package_by_name.dart';
import 'domain/usecases/notify_new_version_package.dart';

final _injector = AutoInjector(
  on: (i) {
    //domain
    i.add<GetPackageByName>(DBGetPackageByName.new);
    i.add<NotifyNewVersionPackage>(DiscordNotifyNewVersionPackage.new);
    i.add<ReadPackageName>(IOReadPackageName.new);

    //main
    i.addSingleton<FlutterPackageBot>(_FlutterPackageBot.new);
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
          .flatMap(_notifyNewVersionPackage.call)
          .map((success) => 'Package ${success.name}: Updated(${success.hasNewVersion})')
          .mapError((error) => error.toString())
          .fold(id, id);

      await Future.delayed(Duration(seconds: 5));
    }
  }
}
