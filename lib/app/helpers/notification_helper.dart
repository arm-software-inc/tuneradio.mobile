import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:radiao/app/models/station.dart';

class NotificationHelper {
  static const platform = MethodChannel("com.radiao/not");

  static void notifyPlayState(bool isPlaying) async {
    await platform.invokeMethod("notifyPlayState", [isPlaying]);
  }

  static void notifyStationChange(Station station) async {
    final response = await http.get(Uri.parse(station.favicon));
    await platform.invokeMethod("notifyStationChange", [station.name, station.formattedTags, response.bodyBytes]);
  }

  static void notifyStopNotification() async {
    await platform.invokeMethod("notifyStop");
  }
}