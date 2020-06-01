import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SlotOne with ChangeNotifier {
//  int number;
//  String name;
  bool status = true;

  void updateStatus(bool status) {
    this.status = status;
    notifyListeners();
  }
}
