import 'package:pub_api_client/pub_api_client.dart';

import '../../infra/datasources/pubdev_datasource.dart';

class RemotePubDevDatasource implements PubDevDatasource {
  final PubClient client;

  RemotePubDevDatasource(this.client);

  @override
  Future<PubDevPackage> packageInfo(String name) async {
    final package = await client.packageInfo(name);
    return (name: package.name, version: package.version, link: package.url);
  }
}
