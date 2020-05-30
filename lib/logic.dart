import 'package:flutter/material.dart';
import 'slot_one.dart';

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

void cardStatus(inputValues) {
  //print(inputValues)
  int slot1 = inputValues[1];
  int slot2 = inputValues[5];

  // for slot 1
  if (slot1 == 49) {
    print('Card is in Slot 1');
  } else if (slot1 == 48) {
    print('Card is NOT in Slot 1');
  } else {
    print('ERROR: Indetermined');
  }

  // for slot 2
  if (slot2 == 49) {
    print('Card is in Slot 2');
  } else if (slot2 == 48) {
    print('Card is NOT in Slot 2');
  } else {
    print('ERROR: Indetermined');
  }
}
