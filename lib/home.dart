import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:quallet_scratch_v1/slot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HexColor.dart';
import 'bleconnect.dart';
import 'slot_one.dart';
import 'slot_two.dart';
import 'transitions.dart';
//import 'package:flutter/scheduler.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  BluetoothDevice device;
  Home({Key key, this.device}) : super(key: key);

  @override
  _Home createState() => _Home(device);

  // final FlutterBlue flutterBlue = FlutterBlue.instance;
}

Icon statusIcon(bool status) {
  if (status) {
    return Icon(
      Icons.fiber_manual_record,
      color: Colors.green,
    );
  } else {
    return Icon(
      Icons.fiber_manual_record,
      color: Colors.red,
    );
  }
}

class _Home extends State<Home> {
  BluetoothDevice device;
  _Home(this.device);

  void initCardValues() async {
    SharedPreferences prefs;
    final slotOne = Provider.of<SlotOne>(context, listen: false);
    final slotTwo = Provider.of<SlotTwo>(context, listen: false);

    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    } finally {
      print('setting values');
      slotOne.setValues(
          (prefs.getInt('card1FirstAlert') ?? 15),
          (prefs.getInt('card1SecondAlert') ?? 25),
          prefs.getString('card1Name'),
          DateTime.parse((prefs.getString('card1LastRemoved') ??
              DateTime.now().toIso8601String())),
          DateTime.parse((prefs.getString('card1LastReplaced') ??
              DateTime.now().toIso8601String())));
      slotTwo.setValues(
          (prefs.getInt('card2FirstAlert') ?? 1),
          (prefs.getInt('card2SecondAlert') ?? 5),
          prefs.getString('card2Name'),
          DateTime.parse((prefs.getString('card2LastRemoved') ??
              DateTime.now().toIso8601String())),
          DateTime.parse((prefs.getString('card2LastReplaced') ??
              DateTime.now().toIso8601String())));
    }
  }

  @override
  void initState() {
    initCardValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final slotOne = Provider.of<SlotOne>(context);
    final slotTwo = Provider.of<SlotTwo>(context);

    const TextStyle optionStyle = TextStyle(
        fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);

    return Scaffold(
      backgroundColor: HexColor('#00A8F3'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 16, 10),
              child: Text(
                'My Quallet',
                style: optionStyle,
              ),
            ),
            // SizedBox(
            //   height: 20.0,
            //   width: double.infinity,
            //   child: Divider(
            //     color: Colors.white,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 10, 16, 0),
              child: Text(
                'CARD SLOTS',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              child: Column(
                // TODO: Fix padding issue between Slot widgets
                children: <Widget>[
                  FlatButton(
                    child: Card(
                      //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: statusIcon(slotOne.status),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Slot 1',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: Color.fromARGB(35000, 0, 168, 243),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => SlotScreen(cardNumber: 1)),
                      // );
                      Navigator.of(context).push(slotScreenTransOne());
                    },
                  ),
                  FlatButton(
                    child: Card(
                      child: ListTile(
                        leading: statusIcon(slotTwo.status),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Slot 2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: Color.fromARGB(35000, 0, 168, 243),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SlotScreen(cardNumber: 2)),
                        //Navigator.of(context).push(slotScreenTrans());
                      );
                    },
                  ),
                ],
              ),
            ),
            // Center(
            //   child: SizedBox(
            //     height: 20.0,
            //     width: 300.0,
            //     child: Divider(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 0, 0),
              child: Text(
                'INFORMATION',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              child: Column(
                  // TODO: Fix padding issue between info cards
                  children: <Widget>[
                    Card(
                      //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.battery_std,
                          color: Colors.white,
                        ),
                        trailing: Text(
                          // TODO: Implement battery level of Quallet
                          '50%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        title: Text(
                          'Battery',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: Color.fromARGB(35000, 0, 168, 243),
                    ),
                    Card(
                      //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.wifi_tethering,
                          color: Colors.white,
                        ),
                        trailing: Text(
                          // TODO: Implement battery level of Quallet
                          'Now',
                          style: TextStyle(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        title: Text(
                          'Last Connected',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: Color.fromARGB(35000, 0, 168, 243),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Unpair Quallet'),
                      content: Text(
                          'This action will unpair your Quallet from this device and clear all your preferences. Are you sure you want to proceed'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            device.disconnect();
                            try {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                            } catch (e) {
                              print(e);
                            } finally {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BleConnect()),
                              );
                            }
                          },
                        ),
                        FlatButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    barrierDismissible: true,
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(
                      'Unpair Your Quallet',
                      style:
                          TextStyle(color: Colors.red.shade900, fontSize: 16.0),
                    ),
                  ),
                  color: Color.fromARGB(35000, 0, 168, 243),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//for notifications
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertPage'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('go back...'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
