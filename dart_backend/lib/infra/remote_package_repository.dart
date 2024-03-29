import 'package:dart_backend/domain/entities/package_entity.dart';
import 'package:dart_backend/domain/errors/errors.dart';
import 'package:dart_backend/domain/repositories/package_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'datasources/db_datasource.dart';
import 'datasources/discord_notification.dart';
import 'datasources/pubdev_datasource.dart';

class RemotePackageRepository extends PackageRepository {
  final DBDatasource _datasource;
  final DiscordNotificationDatasource _discordDatasource;
  final PubDevDatasource _pubDevDatasource;

  RemotePackageRepository(
    this._datasource,
    this._discordDatasource,
    this._pubDevDatasource,
  );

  @override
  AsyncResult<PackageEntity, PackageError> getPackageByName(String name) async {
    try {
      final pack = await _datasource.getPackageByName(name);

      if (pack == null) {
        return Result.failure(PackageNotRegisteredError(name));
      }

      final pubDevPack = await _pubDevDatasource.packageInfo(name);
      final hasNewVersion = pack.version != pubDevPack.version;

      if (hasNewVersion) {
        await _datasource.savePackage(pubDevPack);
      }

      return PackageEntity(
        name: pack.name,
        url: pack.link,
        version: pubDevPack.version,
        hasNewVersion: hasNewVersion,
      ).toSuccess();
    } on PackageError catch (e) {
      return Result.failure(e);
    }
  }

  @override
  AsyncResult<PackageEntity, PackageError> createPackageRegister(String name) async {
    try {
      final pubDevPack = await _pubDevDatasource.packageInfo(name);
      await _datasource.savePackage(pubDevPack);
      return PackageEntity(
        name: pubDevPack.name,
        url: pubDevPack.link,
        version: pubDevPack.version,
      ).toSuccess();
    } on PackageError catch (e) {
      return Result.failure(e);
    }
  }

  @override
  AsyncResult<Unit, BackendError> notifyToDiscord({
    required String title,
    required String description,
    required String link,
  }) async {
    await _discordDatasource.notify(title: title, description: description, link: link);
    return Success.unit();
  }
}
