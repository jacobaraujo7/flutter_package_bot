abstract class DiscordNotificationDatasource {
  Future<void> notify({
    required String title,
    required String description,
    required String link,
  });
}
