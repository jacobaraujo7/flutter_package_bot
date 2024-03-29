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
          title: 'New version of ${package.name} is out! 🚀',
          description: 'The new version of ${package.name} is ${package.version}',
          link: package.url,
        )
        .pure(package);
  }
}
