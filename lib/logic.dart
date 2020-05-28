import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped_model/slot_model.dart';

class Logic extends StatefulWidget {
  @override
  _LogicState createState() => _LogicState();
}

class _LogicState extends State<Logic> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

SlotModel cardOne = SlotModel(1, 'Debit Card');
SlotModel cardTwo = SlotModel(2, 'Pornhub Premium Card');

final bool slot1 = null;
final bool slot2 = null;

void cardStatus(inputValues) {
  //print(inputValues)
  int slot1 = inputValues[1];
  int slot2 = inputValues[5];

  // for slot 1
  if (slot1 == 49) {
    print('$cardOne.getName() in Slot 1');
  } else if (slot1 == 48) {
    print('$cardOne.getName() i is NOT in Slot 1');
  } else {
    print('ERROR: Indetermined');
  }

  // for slot 2
  if (slot2 == 49) {
    print('$cardTwo.getName() i is in Slot 2');
  } else if (slot2 == 48) {
    print('$cardTwo.getName() i is NOT in Slot 2');
  } else {
    print('ERROR: Indetermined');
  }
}
