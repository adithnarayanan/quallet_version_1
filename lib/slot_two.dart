import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'notifications.dart';

class SlotTwo with ChangeNotifier {
//  int number;
//  String name;
  bool status = true;

  void updateStatus(bool status) {
    // print(this.status);
    // print(status);
    if (this.status == true && status == false) {
      //print('hellohellohello');
      showNotificaiton('Recent Activity', 'Card Two Taken Out');
    }
    if (this.status == false && status == true) {
      //print('hasdfasdfhnsfajkfaksasd');
      showNotificaiton('Recent Activity', 'Card Two Replaced');
    }
    this.status = status;
    notifyListeners();
  }
}
