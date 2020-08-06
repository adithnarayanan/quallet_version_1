import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quallet_scratch_v1/home.dart';
import 'package:quallet_scratch_v1/slot_two.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HexColor.dart';
import 'slot_one.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

class SlotScreen extends StatefulWidget {
  int cardNumber;
  SlotScreen({Key key, this.cardNumber}) : super(key: key);

  @override
  _SlotScreenState createState() => _SlotScreenState(cardNumber);
}

class _SlotScreenState extends State<SlotScreen> {
  int cardNumber;
  _SlotScreenState(this.cardNumber);

  void updateCardStatus(List inputValues) {
    if (inputValues[0] == true) {}
  }

  Future<int> getFirstAlert(int cardNumber) async {
    String keyName = 'card' + cardNumber.toString() + 'FirstAlert';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int firstAlert = (prefs.getInt(keyName) ?? 5);
    return firstAlert;
  }

  Future<int> getSecondAlert(int cardNumber) async {
    String keyName = 'card' + cardNumber.toString() + 'SecondAlert';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int secondAlert = (prefs.getInt(keyName) ?? 5);
    return secondAlert;
  }

  Future<String> getCardName(int cardNumber) async {
    String keyName = 'card' + cardNumber.toString() + 'Name';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cardName =
        (prefs.getString(keyName) ?? 'Card ' + cardNumber.toString());
    return cardName;
  }

  setFirstAlert(int cardNumber, int value) async {
    String keyName = 'card' + cardNumber.toString() + 'FirstAlert';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyName, value);
  }

  setSecondAlert(int cardNumber, int value) async {
    String keyName = 'card' + cardNumber.toString() + 'SecondAlert';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyName, value);
  }

  setCardName(int cardNumber, String name) async {
    String keyName = 'card' + cardNumber.toString() + 'Name';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyName, name);
  }

  // number picker
  //int firstAlert;
  int firstAlert = 5;
  int secondAlert = 5;
  String cardName = 'Card';

  void initAlerts() async {
    firstAlert = await getFirstAlert(cardNumber);
    secondAlert = await getSecondAlert(cardNumber);
    cardName = await getCardName(cardNumber);
  }

  Future _showDialog1() async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          //TODO: Implement consistent Theme
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 60,
            title: new Text("Set time for First Alert"),
            initialIntegerValue: firstAlert,
            infiniteLoop: true,
          );
        }).then((int value) {
      if (value != null) {
        setFirstAlert(cardNumber, value);
        setState(() => firstAlert = value);
      }
    });
  }

  Future _showDialog2() async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          //TODO: Implement consistent Theme
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 60,
            title: new Text("Set time for Second Alert"),
            initialIntegerValue: secondAlert,
            infiniteLoop: true,
          );
        }).then((int value) {
      if (value != null) {
        setSecondAlert(cardNumber, value);
        setState(() => secondAlert = value);
      }
    });
  }

  Text statusText(bool status) {
    //card1Name = myController.text;
    if (status) {
      return Text(
        '$cardName is In',
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.green.shade300,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        '$cardName is Out',
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.red.shade400,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Cleans up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initAlerts();
  }

  @override
  Widget build(BuildContext context) {
    dynamic slot;
    if (cardNumber == 1) {
      slot = Provider.of<SlotOne>(context);
    } else {
      slot = Provider.of<SlotTwo>(context);
    }

    const TextStyle optionStyle = TextStyle(
        fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);

    return Scaffold(
      backgroundColor: HexColor('#00A8F3'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 16, 10),
                child: Text(
                  'Slot $cardNumber',
                  style: optionStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: HexColor('#3a91d4'), //TODO Change Background Color
                child: Center(child: statusText(slot.status)),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: myController,
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        String card1Name = myController.text;
                        setCardName(cardNumber, card1Name);
                        setState(() {
                          cardName = card1Name;
                        });
                      },
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                ],
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
                        trailing: FlatButton(
                          child: Text(
                            '$firstAlert mins',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                          color: HexColor('#00A8F3'),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: _showDialog1,
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
                        trailing: FlatButton(
                          child: Text(
                            '$secondAlert mins',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                          color: HexColor('#00A8F3'),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: _showDialog2,
                        ),
                        title: Text(
                          'Time Before Second Notification',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
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
                    Navigator.pop(context);
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
      ),
    );
  }
}
