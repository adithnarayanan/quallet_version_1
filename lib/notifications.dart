import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

// var initializationSettingsAndroid;
// var initializationSettingsIOS;
// var initializationSettings;

void showNotificaiton(String type, String content) async {
  await _demoNotification(type, content);
}

Future<void> _demoNotification(String type, String content) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel ID', 'channel Name', 'channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker');

  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecfics =
      NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(0, type, content, platformChannelSpecfics, payload: 'test payload');
}
