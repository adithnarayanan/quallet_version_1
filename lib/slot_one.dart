import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notifications.dart';

class SlotOne with ChangeNotifier {
//  int number;
//  String name;
  bool status = true;
  int firstAlert = 1;
  int secondAlert = 5;
  String cardName = "Card 1";
  DateTime lastRemoved = DateTime.now();
  DateTime lastReplaced = DateTime.now();

  void setValues(int firstAlert, int secondAlert, String cardName,
      DateTime lastRemoved, DateTime lastReplaced) {
    this.firstAlert = firstAlert;
    this.secondAlert = secondAlert;
    if (cardName != null) {
      this.cardName = cardName;
    }
    this.lastRemoved = lastRemoved;
    this.lastReplaced = lastReplaced;
  }

  void setFirstAlert(int firstAlert) {
    this.firstAlert = firstAlert;
  }

  void setSecondAlert(int secondAlert) {
    this.secondAlert = secondAlert;
  }

  void setCardName(String cardName) {
    this.cardName = cardName;
  }

  void setLastRemoved(int cardNumber) async {
    this.lastRemoved = DateTime.now();
    String timestamp = DateTime.now().toIso8601String();
    String keyName = 'card' + cardNumber.toString() + 'LastRemoved';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyName, timestamp);
  }

  void setLastReplaced(int cardNumber) async {
    this.lastReplaced = DateTime.now();
    String timestamp = DateTime.now().toIso8601String();
    String keyName = 'card' + cardNumber.toString() + 'LastReplaced';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyName, timestamp);
  }

  void updateStatus(bool status) {
    // print(this.status);
    // print(status);
    if (this.status == true && status == false) {
      //print('hellohellohello');
      setLastRemoved(1);
      showImmediateNotification('Recent Activity', '$cardName Taken Out');
      showScheduledNotification(
          "Reminder",
          "$cardName not Replaced for $firstAlert minutes",
          DateTime.now().add(Duration(minutes: firstAlert)),
          1);
      showScheduledNotification(
          "Reminder",
          "$cardName not Replaced for $secondAlert minutes",
          DateTime.now().add(Duration(minutes: secondAlert)),
          2);
    }
    if (this.status == false && status == true) {
      //print('hasdfasdfhnsfajkfaksasd');
      setLastReplaced(1);
      showImmediateNotification('Recent Activity', '$cardName Replaced');
      cancelScheduleNotification(1);
      cancelScheduleNotification(2);
    }
    this.status = status;
    notifyListeners();
  }
}
