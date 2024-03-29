import 'package:dart_backend/infra/datasources/pubdev_datasource.dart';
import 'package:realm/realm.dart';

import '../../infra/datasources/db_datasource.dart';
import 'models/realm_package.dart';

class RealmDBDatasource implements DBDatasource {
  late final Configuration config;
  late final Realm realm;

  RealmDBDatasource() {
    config = Configuration.local([RealmPackage.schema]);
    realm = Realm(config);
  }

  @override
  Future<PubDevPackage?> getPackageByName(String name) async {
    var pack = realm.find<RealmPackage>(name);
    if (pack == null) {
      return null;
    }
    return (name: pack.name, version: pack.version, link: pack.link);
  }

  @override
  Future<void> savePackage(PubDevPackage package) {
    // TODO: implement savePackage
    throw UnimplementedError();
  }
}
