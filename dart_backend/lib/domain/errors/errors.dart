abstract class BackendError implements Exception {
  final String message;
  final StackTrace? stackTrace;
  const BackendError(this.message, [this.stackTrace]);

  @override
  String toString() {
    return '$runtimeType: $message${stackTrace == null ? '' : '\n$stackTrace'}';
  }
}

class PackageError extends BackendError {
  final String packageName;
  const PackageError(this.packageName, super.message, [super.stackTrace]);

  @override
  String toString() {
    return '$runtimeType: $message ($packageName) ${stackTrace == null ? '' : '\n$stackTrace'}';
  }
}

class PackageNotRegisteredError extends PackageError {
  const PackageNotRegisteredError(String packageName)
      : super(
          packageName,
          'Package not registered',
        );
}
