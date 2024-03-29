import 'package:dart_backend/domain/entities/package_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../errors/errors.dart';

abstract class PackageRepository {
  AsyncResult<PackageEntity, PackageError> getPackageByName(String name);
  AsyncResult<PackageEntity, PackageError> createPackageRegister(String name);
  AsyncResult<Unit, BackendError> notifyToDiscord({
    required String title,
    required String description,
    required String link,
  });
}
