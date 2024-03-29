import 'package:realm_dart/realm.dart';

part 'realm_package.realm.dart'; // declare a part file.

@RealmModel()
class _RealmPackage {
  @PrimaryKey()
  late String name;
  late String version;
  late String link;
}
