import 'package:scoped_model/scoped_model.dart';

class SlotModel extends Model {
  int number;
  String name;
  bool status;

  SlotModel(
    int number,
    String name,
  ) {
    this.number = number;
    this.name = name;
  }

  String getName() {
    return name;
  }

  int getNumber() {
    return number;
  }

  bool getStatus() {
    return status;
  }

  void updateStatus(bool status) {
    this.status = status;
    notifyListeners();
  }
}
