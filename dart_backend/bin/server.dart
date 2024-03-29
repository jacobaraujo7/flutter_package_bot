import 'dart:async';

import 'package:dart_backend/flutter_package_bot.dart';

void main(List<String> args) async {
  final bot = FlutterPackageBot.instance();
  await for (var log in bot.run('packages.txt')) {
    print(log);
  }

  Timer.periodic(Duration(minutes: 30), (timer) async {
    await for (var log in bot.run('packages.txt')) {
      print(log);
    }
  });
}
