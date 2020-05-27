import 'package:flutter/material.dart';
import 'package:quallet_scratch_v1/home.dart';
import 'HexColor.dart';

class SlotScreen extends StatefulWidget {
  @override
  _SlotScreenState createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  @override
  Widget build(BuildContext context) {
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
                'Slot 1',
                style: optionStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              color: HexColor('#3a91d4'), //TODO Change Background Color
              child: Center(
                child: Text(
                  'Card is in.',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.green.shade300,
                    fontWeight: FontWeight.bold,
                  ),
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
                        trailing: Text(
                          // TODO: Implement battery level of Quallet
                          '6 hours and 9 mins ago',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        title: Text(
                          'Last Removed',
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
                        trailing: Text(
                          // TODO: Implement battery level of Quallet
                          '4 hrs and 20 mins ago',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        title: Text(
                          'Last Replaced',
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
              padding: const EdgeInsets.fromLTRB(22, 10, 16, 0),
              child: Text(
                'SETTINGS',
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
                      trailing: Text(
                        // TODO: Implement Number Picker
                        '6 mins',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      title: Text(
                        'Time Before Notification',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    color: Color.fromARGB(35000, 0, 168, 243),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 6.0),
                    child: Text(
                      'Set the amount of time that Quallet will wait before reminding you to put your card back.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: HexColor('#90D9FA'),
                      ),
                    ),
                  ),
                  Card(
                    //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      trailing: Text(
                        // TODO: Implement Second Notification Number Picker
                        '9 mins',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      title: Text(
                        'Time Second Before Notification',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    color: Color.fromARGB(35000, 0, 168, 243),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 6.0),
                    child: Text(
                      'Set the amount of time that Quallet will wait after a first notification before reminding you again to put your card back.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: HexColor('#90D9FA'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: double.infinity,
            // ),
            Align(
              alignment: Alignment.bottomCenter, //TODO Keep at Bottom
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Card(
                  //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    title: Text(
                      'Back to Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  color: Color.fromARGB(35000, 0, 168, 243),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
