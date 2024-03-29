import 'package:uno/uno.dart';

import '../../core/constants/constants.dart';
import '../../infra/datasources/discord_notification.dart';

class RemoteDiscordNotification implements DiscordNotificationDatasource {
  final Uno uno;

  RemoteDiscordNotification(this.uno);

  @override
  Future<void> notify({required String title, required String description, required String link}) async {
    final response = await uno.post(
      discordWebhookUrl,
      responseType: ResponseType.plain,
      data: {
        "embeds": [
          {
            "title": title,
            "description": description,
            "url": link,
            "fields": [
              {
                "name": "Package",
                "value": "[Link do package]($link)",
                "inline": true,
              },
              {
                "name": "Changelog",
                "value": "[Changlog]($link/changelog)",
                "inline": true,
              },
            ]
          }
        ]
      },
    );

    print(response);
  }
}
