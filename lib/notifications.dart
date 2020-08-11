import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

// var initializationSettingsAndroid;
// var initializationSettingsIOS;
// var initializationSettings;

void showImmediateNotification(String type, String content) async {
  await _immediateNotification(type, content);
}

Future<void> _immediateNotification(String type, String content) async {
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

void showScheduledNotification(
    String type, String content, DateTime scheduledTime, int channelId) async {
  await _scheduledNotification(type, content, scheduledTime, channelId);
}

Future<void> _scheduledNotification(
    String type, String content, DateTime scheduledTime, int channelId) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel $channelId ID',
      'channel $channelId Name',
      'channel $channelId description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker');

  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecfics =
      NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);

  await flutterLocalNotificationsPlugin.schedule(
      channelId, type, content, scheduledTime, platformChannelSpecfics);
}

void cancelScheduleNotification(int channelId) async {
  await flutterLocalNotificationsPlugin.cancel(channelId);
}

// void showFirstScheduledNotification(
//     String type, String content, DateTime scheduledTime) async {
//   await _firstScheduledNotification(type, content, scheduledTime);
// }

// Future<void> _firstScheduledNotification(
//     String type, String content, DateTime scheduledTime) async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'second channel ID', 'second channel Name', 'second channel description',
//       importance: Importance.Max,
//       priority: Priority.High,
//       ticker: 'test ticker');

//   var iOSChannelSpecifics = IOSNotificationDetails();
//   var platformChannelSpecfics =
//       NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);

//   await flutterLocalNotificationsPlugin.schedule(
//       1, type, content, scheduledTime, platformChannelSpecfics);
// }

// void cancelFirstScheduleNotification() async {
//   await flutterLocalNotificationsPlugin.cancel(1);
// }

// void showSecondScheduledNotification(
//     String type, String content, DateTime scheduledTime) async {
//   await _secondscheduledNotification(type, content, scheduledTime);
// }

// Future<void> _secondScheduledNotification(
//     String type, String content, DateTime scheduledTime) async {
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'third channel ID', 'third channel Name', 'third channel description',
//       importance: Importance.Max,
//       priority: Priority.High,
//       ticker: 'test ticker');

//   var iOSChannelSpecifics = IOSNotificationDetails();
//   var platformChannelSpecfics =
//       NotificationDetails(androidPlatformChannelSpecifics, iOSChannelSpecifics);

//   await flutterLocalNotificationsPlugin.schedule(
//       2, type, content, scheduledTime, platformChannelSpecfics);
// }

// void cancelSecondScheduleNotification() async {
//   await flutterLocalNotificationsPlugin.cancel(2);
// }
