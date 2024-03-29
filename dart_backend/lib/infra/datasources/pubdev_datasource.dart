typedef PubDevPackage = ({
  String name,
  String version,
  String link,
});

abstract class PubDevDatasource {
  Future<PubDevPackage> packageInfo(String name);
}
