import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quallet_scratch_v1/home.dart';
import 'package:quallet_scratch_v1/slot.dart';
import 'bleconnect.dart';
import 'slot_one.dart';
import 'slot_two.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  @override
  void initState() {
    super.initState();
    initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new SecondRoute()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondRoute()));
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SlotOne>(create: (context) => SlotOne()),
        ChangeNotifierProvider<SlotTwo>(create: (context) => SlotTwo()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BleConnect(),
      ),
    );
  }
}
