import 'pubdev_datasource.dart';

abstract class DBDatasource {
  Future<void> savePackage(PubDevPackage package);
  Future<PubDevPackage?> getPackageByName(String name);
}
