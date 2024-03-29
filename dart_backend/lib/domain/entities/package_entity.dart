class PackageEntity {
  final String name;
  final String url;
  final String version;
  final bool hasNewVersion;

  PackageEntity({
    required this.name,
    required this.url,
    required this.version,
    this.hasNewVersion = false,
  });
}
