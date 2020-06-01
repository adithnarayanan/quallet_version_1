import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quallet_scratch_v1/slot.dart';
import 'HexColor.dart';
import 'slot_one.dart';
import 'slot_two.dart';
import 'transitions.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
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
                          '69%',
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
                          '6 hrs 9 mins ago',
                          style: TextStyle(
                            color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
