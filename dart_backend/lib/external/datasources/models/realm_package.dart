import 'package:realm/realm.dart'; // import realm package

part 'realm_package.realm.dart'; // declare a part file.

@RealmModel()
class _RealmPackage {
  @PrimaryKey()
  late String name;
  late String version;
  late String link;
}
