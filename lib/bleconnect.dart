import 'package:flutter/rendering.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quallet_scratch_v1/home.dart';
import 'HexColor.dart';
import 'slot_one.dart';
import 'slot_two.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'logic.dart';

class BleConnect extends StatefulWidget {
  @override
  _BleConnectState createState() => _BleConnectState();

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
}

class _BleConnectState extends State<BleConnect> {
  TextStyle optionStyle =
      TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);

  final String send_uuid = '0000ffe0-0000-1000-8000-00805f9b34fb';
  final String recieve_uuid = '0000ffe1-0000-1000-8000-00805f9b34fb';
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;
  String deviceId;
  SharedPreferences prefs;

  Future<String> getBleDeviceID() async {
    String keyName = 'bleDeviceId';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstAlert = (prefs.getString(keyName));
    return firstAlert;
  }

  Future<String> setBleDeviceId(String value) async {
    String keyName = 'bleDeviceId';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyName, value);
    return 'lol';
  }
  // void setBleDeviceId() async {
  //   String keyName = 'bleDeviceId';
  // }

  void beginNotification(BuildContext context) async {
    final slotOne = Provider.of<SlotOne>(context, listen: false);
    final slotTwo = Provider.of<SlotTwo>(context, listen: false);

    print("begin Notification started");
    BluetoothCharacteristic characteristic_real;

    for (BluetoothService service in _services) {
      print(service.uuid.toString() == send_uuid);
      if (service.uuid.toString() == send_uuid) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == recieve_uuid) {
            characteristic_real = characteristic;
          }
        }
      }
    }
    characteristic_real.value.listen((value) {
      widget.readValues[characteristic_real.uuid] = value;

      int slot1 = value[1];
      int slot2 = value[5];

      if (slot1 == 49) {
        slotOne.updateStatus(true);
        print('Card is in Slot 1');
      } else if (slot1 == 48) {
        slotOne.updateStatus(false);
        print('Card is NOT in Slot 1');
      } else {
        print('ERROR: Indetermined');
      }

      if (slot2 == 49) {
        slotTwo.updateStatus(true);
        print('Card is in Slot 2');
      } else if (slot2 == 48) {
        slotTwo.updateStatus(false);
        print('Card is NOT in Slot 2');
      } else {
        print('ERROR: Indetermined');
      }
      print(value);
    });
    await characteristic_real.setNotifyValue(true);
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  void gotoHomePage(BuildContext context, BluetoothDevice device) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Home(
                device: device,
              )),
    );
  }

  void initAlerts() async {
    //deviceId = await getBleDeviceID();
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    } finally {
      deviceId = prefs.getString('bleDeviceId');
      print(deviceId);
      widget.flutterBlue.connectedDevices
          .asStream()
          .listen((List<BluetoothDevice> devices) async {
        for (BluetoothDevice device in devices) {
          print(device.id.id);
          if (device.id.id == deviceId) {
            print('equal');
            widget.flutterBlue.stopScan();
            try {
              print(device.id);
              await device.connect();
            } catch (e) {
              if (e.code != 'already_connected ') {
                beginNotification(context);
                gotoHomePage(context, device);
              }
            } finally {
              _services = await device.discoverServices();
              beginNotification(context);
              gotoHomePage(context, device);
              //
            }
          }
          if (device.name.contains('Quallet')) {
            _addDeviceTolist(device);
          }
        }
      });
      widget.flutterBlue.scanResults.listen((List<ScanResult> results) async {
        for (ScanResult result in results) {
          if (result.device.id.id == deviceId) {
            print('equal');
            widget.flutterBlue.stopScan();
            try {
              //print(device.id);
              await result.device.connect();
            } catch (e) {
              if (e.code != 'already_connected ') {
                beginNotification(context);
                gotoHomePage(context, result.device);
              }
            } finally {
              _services = await result.device.discoverServices();
              beginNotification(context);
              gotoHomePage(context, result.device);
              //
            }
          }
          if (result.device.name.contains('Quallet')) {
            _addDeviceTolist(result.device);
          }
        }
      });
      widget.flutterBlue.startScan();
    }
  }

  @override
  void initState() {
    super.initState();
    initAlerts();
    // deviceId = prefs.getString('bleDeviceId');
    // print(deviceId);
    // deviceId = null;
    // widget.flutterBlue.connectedDevices
    //     .asStream()
    //     .listen((List<BluetoothDevice> devices) async {
    //   for (BluetoothDevice device in devices) {
    //     if (device.id.id == deviceId) {
    //       widget.flutterBlue.stopScan();
    //       try {
    //         print(device.id);
    //         await device.connect();
    //       } catch (e) {
    //         if (e.code != 'already_connected ') {
    //           beginNotification(context);
    //           gotoHomePage(context);
    //         }
    //       } finally {
    //         _services = await device.discoverServices();
    //         beginNotification(context);
    //         gotoHomePage(context);
    //         //
    //       }
    //     }
    //     if (device.name.contains('Quallet')) {
    //       _addDeviceTolist(device);
    //     }
    //   }
    // });
    // widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
    //   for (ScanResult result in results) {
    //     if (result.device.name.contains('Quallet')) {
    //       _addDeviceTolist(result.device);
    //     }
    //   }
    // });
    // widget.flutterBlue.startScan();
  }

  ListView _buildListViewOfDevices(BuildContext context) {
    List<Container> containers = new List<Container>();
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Card(
                    //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        // Icons.fiber_manual_record,
                        // color: Colors.blue.shade900,
                        Icons.bluetooth_connected,
                        color: Colors.blue.shade900,
                      ),
                      // trailing: Icon(
                      //  Icons.bluetooth_connected,
                      //  color: Colors.white,
                      // ),
                      title: Text(
                        device.name == '' ? '(unknown device)' : device.name,
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
                  onPressed: () async {
                    widget.flutterBlue.stopScan();
                    try {
                      //print(device.id);
                      await device.connect();
                      prefs.setString('bleDeviceId', device.id.id);
                      //await setBleDeviceId(device.id.id);
                      print('connecting');
                      print(device.id.id);
                    } catch (e) {
                      if (e.code != 'already_connected ') {
                        beginNotification(context);
                        gotoHomePage(context, device);
                      }
                    } finally {
                      _services = await device.discoverServices();
                      beginNotification(context);
                      gotoHomePage(context, device);
                      //
                    }
                    setState(() {
                      _connectedDevice = device;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: HexColor('#00A8F3'),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 16, 10),
                child: Text(
                  'Pair Quallet',
                  style: optionStyle,
                ),
              ),
              _buildListViewOfDevices(context),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  30,
                  0,
                  0,
                ),
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                )),
              )
            ],
          ),
        ),
      );
}
