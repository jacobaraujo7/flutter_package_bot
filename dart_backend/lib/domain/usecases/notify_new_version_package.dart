import 'package:dart_backend/domain/entities/package_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../errors/errors.dart';
import '../repositories/package_repository.dart';

abstract class NotifyNewVersionPackage {
  AsyncResult<PackageEntity, BackendError> call(PackageEntity package);
}

class DiscordNotifyNewVersionPackage implements NotifyNewVersionPackage {
  final PackageRepository repository;

  DiscordNotifyNewVersionPackage(this.repository);

  @override
  AsyncResult<PackageEntity, BackendError> call(PackageEntity package) {
    return repository
        .notifyToDiscord(
          title: '${package.name} tem uma nova versão! 🚀',
          description: '${package.name} atualizado para a ${package.version}',
          link: package.url,
        )
        .pure(package);
  }
}
