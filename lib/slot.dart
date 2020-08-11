import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:quallet_scratch_v1/slot_two.dart';
import 'package:quallet_scratch_v1/transitions.dart';
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
  var slot;
  bool _validate = false;

  void updateCardStatus(List inputValues) {
    if (inputValues[0] == true) {}
  }

  Future<int> getFirstAlert(int cardNumber) async {
    String keyName = 'card' + cardNumber.toString() + 'FirstAlert';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int firstAlert = (prefs.getInt(keyName) ?? 1);
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
    //myController.text = cardName;
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
        slot.setFirstAlert(value);
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
        slot.setSecondAlert(value);
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

  String errorText(bool valid) {
    if (valid) {
      return 'Card Name Can\'t be empty';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  String getTimeDifference(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    int days = difference.inDays;
    int hours = difference.inHours;
    int min = difference.inMinutes - hours * 60;

    return '$hours hours and $min mins ago';
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle = TextStyle(
        fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);

    if (cardNumber == 1) {
      slot = Provider.of<SlotOne>(context);
    } else {
      slot = Provider.of<SlotTwo>(context);
    }

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
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  color: HexColor('#3a91d4'),
                  //TODO Change Background Color
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FittedBox(
                        fit: BoxFit.contain, child: statusText(slot.status)),
                  )),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Rename Slot $cardNumber'),
                      content: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: myController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Card Name Can\'t be Empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Card Name',
                            // errorText: errorText(
                            //     _validate) //_validate ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Submit"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              String card1Name = myController.text;
                              slot.setCardName(card1Name);
                              setCardName(cardNumber, card1Name);
                              setState(() {
                                cardName = card1Name;
                              });
                              myController.clear();
                              Navigator.of(context).pop();
                            }
                            if (!_validate) {}
                          },
                        ),
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    barrierDismissible: true,
                  );
                },
              ),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       flex: 4,
              //       child: TextField(
              //         controller: myController,
              //       ),
              //     ),
              //     Expanded(
              //       child: FlatButton(
              //         onPressed: () {
              //           String card1Name = myController.text;
              //           slot.setCardName(card1Name);
              //           setCardName(cardNumber, card1Name);
              //           setState(() {
              //             cardName = card1Name;
              //           });
              //         },
              //         child: Icon(Icons.arrow_forward_ios),
              //       ),
              //     )
              //   ],
              // ),

              Container(
                child: Column(
                    // TODO: Fix padding issue between info cards
                    children: <Widget>[
                      Card(
                        //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          trailing: Text(
                            getTimeDifference(slot.lastRemoved),
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
                            getTimeDifference(slot.lastReplaced),
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
