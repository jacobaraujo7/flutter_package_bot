import 'package:dart_backend/domain/entities/package_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../errors/errors.dart';
import '../repositories/package_repository.dart';

abstract class GetPackageByName {
  AsyncResult<PackageEntity, BackendError> call(String name);
}

class DBGetPackageByName implements GetPackageByName {
  final PackageRepository repository;

  DBGetPackageByName(this.repository);

  @override
  AsyncResult<PackageEntity, BackendError> call(String name) {
    return repository
        .getPackageByName(name) //
        .recover(_createNewPackageRegister);
  }

  AsyncResult<PackageEntity, PackageError> _createNewPackageRegister(
    PackageError failure,
  ) async {
    if (failure is PackageNotRegisteredError) {
      return repository.createPackageRegister(failure.packageName);
    }
    return Result.failure(failure);
  }
}
