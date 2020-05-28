import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:quallet_scratch_v1/home.dart';
import 'HexColor.dart';
import 'slot.dart';
import 'dart:convert';
import 'logic.dart';

class BleConnect extends StatefulWidget {
  @override
  _BleConnectState createState() => _BleConnectState();

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
}

class _BleConnectState extends State<BleConnect> {
  final String send_uuid = '0000ffe0-0000-1000-8000-00805f9b34fb';
  final String recieve_uuid = '0000ffe1-0000-1000-8000-00805f9b34fb';
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;

  void beginNotification() async {
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
      cardStatus(value);
      //Home();
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

  void gotoHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        if (device.name.contains('Quallet')) {
          _addDeviceTolist(device);
        }
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (result.device.name.contains('Quallet')) {
          _addDeviceTolist(result.device);
        }
      }
    });
    widget.flutterBlue.startScan();
  }

  ListView _buildListViewOfDevices() {
    //TODO Update UI to match home and slot
    List<Container> containers = new List<Container>();
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e.code != 'already_connected ') {
                      throw e;
                    }
                  } finally {
                    _services = await device.discoverServices();
                    beginNotification();
                    gotoHomePage(context);
                    //
                  }
                  setState(() {
                    _connectedDevice = device;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = new List<ButtonTheme>();
    if (characteristic.properties.notify) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                characteristic.value.listen((value) {
                  widget.readValues[characteristic.uuid] = value;
                  cardStatus(value);
                  print(value);
                });
                await characteristic.setNotifyValue(true);
              },
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  ListView _buildConnectDeviceView() {
    List<Container> containers = new List<Container>();

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = new List<Widget>();
      print(service.uuid.toString() == send_uuid);
      if (service.uuid.toString() == send_uuid) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == recieve_uuid) {
            characteristicsWidget.add(
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(characteristic.uuid.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ..._buildReadWriteNotifyButton(characteristic),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Value: ' +
                            widget.readValues[characteristic.uuid].toString()),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            );
          }
        }
      }
      containers.add(
        Container(
          child: ExpansionTile(
              title: Text(service.uuid.toString()),
              children: characteristicsWidget),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _buildView(),
      );
}
