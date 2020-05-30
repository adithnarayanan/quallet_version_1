import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quallet_scratch_v1/home.dart';
import 'package:quallet_scratch_v1/slot.dart';
import 'bleconnect.dart';
import 'slot_one.dart';
import 'slot_two.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
