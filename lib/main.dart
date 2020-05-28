import 'package:flutter/material.dart';
import 'package:quallet_scratch_v1/home.dart';
import 'package:quallet_scratch_v1/slot.dart';
import 'bleconnect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BleConnect(),
    );
  }
}
