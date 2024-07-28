import 'package:beacon_detector_futter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'custom_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class ConfigResponse {
  final List<String> macAddresses;
  final int rssiThreshold;
  final int rssiAlarmThreshold;
  final bool thresholdEnabled;
  final bool isWhiteList;
  final int scanInterval;
  final int scanDuration;

  ConfigResponse({
    required this.macAddresses,
    required this.rssiThreshold,
    required this.rssiAlarmThreshold,
    required this.thresholdEnabled,
    required this.isWhiteList,
    required this.scanInterval,
    required this.scanDuration,
  });

  factory ConfigResponse.fromJson(Map<String, dynamic> json) {
    return ConfigResponse(
      macAddresses: List<String>.from(json['macAddresses']),
      rssiThreshold: json['rssiThreshold'],
      rssiAlarmThreshold: json['rssiAlarmThreshold'], // Corrected key name
      thresholdEnabled: json['thresholdEnabled'],
      isWhiteList: json['isWhiteList'],
      scanInterval: json['scanInterval'],
      scanDuration: json['scanDuration'],
    );
  }
}

ConfigResponse parseConfigResponse(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return ConfigResponse.fromJson(parsed);
}

class DeviceInfo {
  String rssi;
  String deviceName;
  String macAddress;
  String approxDistance;
  String advertisementData;
  bool isSelected;

  DeviceInfo({
    required this.rssi,
    required this.deviceName,
    required this.macAddress,
    required this.approxDistance,
    required this.advertisementData,
    this.isSelected = false,
  });
}

var configResponse = ConfigResponse(
  macAddresses: [],
  rssiThreshold: 0,
  rssiAlarmThreshold: 0,
  thresholdEnabled: true,
  isWhiteList: false,
  scanInterval: 5000,
  scanDuration: 5000,
);

Future<ConfigResponse> httpGetConfig() async {
  String? selectedIP = GlobalData().selectedIP;
  try {
    final response = await http.get(Uri.parse('http://$selectedIP/getConfig'));
    if (response.statusCode == 200) {
      print('Success!');
      print(response.body);
      return parseConfigResponse(response.body);
    } else {
      print('Failed with status code: ${response.statusCode}');
      return ConfigResponse(
        macAddresses: ["Failed to get config"],
        rssiThreshold: 0,
        rssiAlarmThreshold: 0,
        thresholdEnabled: true,
        isWhiteList: false,
        scanInterval: 5000,
        scanDuration: 5000,
      );
    }
  } catch (e) {
    print('Error: $e');
    return ConfigResponse(
      macAddresses: ["Error getting config"],
      rssiThreshold: 0,
      rssiAlarmThreshold: 0,
      thresholdEnabled: true,
      isWhiteList: false,
      scanInterval: 5000,
      scanDuration: 5000,
    );
  }
}

class _Page1State extends State<Page1> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _scanIntervalController = TextEditingController();
  TextEditingController _scanDurationController = TextEditingController();
  TextEditingController _alarmThresholdController = TextEditingController();
  String dropdownValue = 'One';
  bool isWhitelistMode = false;
  bool isThresholdEnabled = true;
  String rssi = '0';
  List<String> selectableItems = []; // Initialize as an empty growable list
  List<bool> selectedItemStatus = []; // Initialize as an empty growable list
  int scanInterval = 5000; // Default value for scan interval
  int scanDuration = 5000; // Default value for scan duration

  @override
  void initState() {
    super.initState();
    // Initialize selectedItemStatus with the correct length
    selectedItemStatus = List<bool>.filled(selectableItems.length, false, growable: true);
  }

  String buildJson() {
    Map<String, dynamic> data = {
      "macAddresses": selectableItems,
      "thresholdEnabled": isThresholdEnabled,
      "rssiThreshold": int.tryParse(_controller2.text) ?? 0,
      "rssiAlarmThreshold": int.tryParse(_alarmThresholdController.text) ?? 0,
      "isWhiteList": isWhitelistMode,
      "scanInterval": scanInterval,
      "scanDuration": scanDuration,
    };

    return jsonEncode(data);
  }

  void addItem(String item) {
    //check if item is already in the list
    if (selectableItems.contains(item)) {
      return;
    }
    //check if the item is a valid MAC address
    RegExp regExp = RegExp(
      r"([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExp.hasMatch(item)) {
      //pop up an alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Geçersiz MAC adresi"),
            content: Text("Lütfen geçerli bir MAC adresi girin"),
            actions: <Widget>[
              TextButton(
                child: Text("Tamam"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      selectableItems.add(item);
      selectedItemStatus.add(false); // Ensure selectedItemStatus is updated accordingly
    });
  }

  void removeItem(int index) {
    setState(() {
      if (index >= 0 && index < selectableItems.length) {
        selectableItems.removeAt(index);
        selectedItemStatus.removeAt(index); // Ensure selectedItemStatus is updated accordingly
      }
    });
  }

  void removeSelectedItems() {
    setState(() {
      for (int i = selectedItemStatus.length - 1; i >= 0; i--) {
        if (selectedItemStatus[i]) {
          selectableItems.removeAt(i);
          selectedItemStatus.removeAt(i);
        }
      }
    });
  }

  void clearList() {
    setState(() {
      selectableItems.clear();
      selectedItemStatus.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfigürasyon Sayfası'),
        //selected ip text
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Secili IP: ${GlobalData().selectedIP ?? 'Seçilmedi'}'),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Color of the border
                  width: 2.0, // Width of the border
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: selectableItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectableItems[index]),
                    leading: Checkbox(
                      value: selectedItemStatus[index],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedItemStatus[index] = value!;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        selectedItemStatus[index] = !selectedItemStatus[index];
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Mod: '),
                      Switch(
                        value: isWhitelistMode,
                        onChanged: (value) {
                          setState(() {
                            isWhitelistMode = value;
                          });
                        },
                      ),
                      Text(isWhitelistMode ? 'Whitelist' : 'Blacklist'),
                      Spacer(),
                      const Text('Eşikdeğeri: '),
                      Switch(
                        value: isThresholdEnabled,
                        onChanged: (value) {
                          setState(() {
                            isThresholdEnabled = value;
                          });
                        },
                      ),
                      Text(isThresholdEnabled ? 'Açık' : 'Kapalı'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _scanIntervalController,
                          decoration: InputDecoration(
                            hintText: 'Tarama aralığını girin(ms)',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            scanInterval = int.tryParse(value) ?? 5000;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _scanDurationController,
                          decoration: InputDecoration(
                            hintText: 'Tarama süresini girin (ms)',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            scanDuration = int.tryParse(value) ?? 5000;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Handle the button press
                      clearList();
                    },
                    child: Text('Liste Temizle'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      removeSelectedItems();
                    },
                    child: Text('Listeden Sil'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller1,
                          decoration: const InputDecoration(
                            hintText: 'Eklenecek Mac adresi girin',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          addItem(_controller1.text);
                        },
                        child: const Text('Listeye Ekle'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller2,
                          decoration: const InputDecoration(
                            hintText: 'RSSI Eşikdeğerini girin',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(child: TextFormField(
                        controller: _alarmThresholdController,
                        decoration: const InputDecoration(
                          hintText: 'RSSI Alarm Eşikdeğerini Girin',
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      //build and print json data to pop up
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("JSON Data"),
                            content: Text(buildJson()),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Tamam"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Json Yazdır'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          ConfigResponse response = await httpGetConfig();
                          setState(() {
                            configResponse = response;
                            selectableItems.addAll(response.macAddresses);
                            selectedItemStatus =
                            List<bool>.filled(selectableItems.length, false, growable: true);
                            isThresholdEnabled = response.thresholdEnabled;
                            _controller2.text = response.rssiThreshold.toString();
                            _alarmThresholdController.text = response.rssiAlarmThreshold.toString();
                            isWhitelistMode = response.isWhiteList;
                            _scanIntervalController.text = response.scanInterval.toString();
                            _scanDurationController.text = response.scanDuration.toString();
                          });
                        },
                        child: const Text('Konfigürasyonu Al'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      String? selectedIP = GlobalData().selectedIP;
                      try {
                        http.post(
                          Uri.parse('http://$selectedIP/sendConfig'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: buildJson(),
                        );
                      } catch (e) {
                        print('Error sending configuration: $e');
                        // Handle the error gracefully (e.g., show a dialog to the user)
                      }
                    },
                    child: const Text('Konfigürasyonu Yükle'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
