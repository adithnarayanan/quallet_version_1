import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SlotOne with ChangeNotifier {
//  int number;
//  String name;
  bool status = true;

  // String getName() {
  //   return name;
  // }

  // int getNumber() {
  //   return number;
  // }

  // bool getStatus() {
  //   return status;
  // }

  void updateStatus(bool status) {
    this.status = status;
    notifyListeners();
  }
}
