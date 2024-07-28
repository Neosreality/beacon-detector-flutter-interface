import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'custom_drawer.dart';
import 'log_entry.dart';
import 'main.dart';


class BeaconName {
  final String name;
  final String mac;

  BeaconName({
    required this.name,
    required this.mac,
  });
}

Future<void> sendAddRequest(String mac) async {
  String? selectedIP = GlobalData().selectedIP;
  mac = '0x' + mac + '0x';
  final macJson = jsonEncode({'macAddresses': mac});
  print(macJson.toString());

  final response = await http.post(
    Uri.parse('http://$selectedIP/addMac'),
    headers: {'Content-Type': 'application/json'},
    body: macJson,
  );

  if (response.statusCode == 200) {
    print('Device added successfully');
    LogEntry log = LogEntry(DateTime.now(), EventType.update, 'Room', 'Device $mac added',mac);
    if (Firebase.apps.isNotEmpty) {
      sendLogToFirebase(log);
    }
  } else {
    print('Failed to add device');
  }
}

Future<void> sendRemoveRequest(String mac) async {
  String? selectedIP = GlobalData().selectedIP;
  mac = '0x' + mac + '0x';
  final macJson = jsonEncode({'macAddresses': mac});
  print(macJson.toString());

  final response = await http.post(
    Uri.parse('http://$selectedIP/removeMac'),
    headers: {'Content-Type': 'application/json'},
    body: macJson,
  );

  if (response.statusCode == 200) {
    print('Device removed successfully');
    LogEntry log = LogEntry(DateTime.now(), EventType.update, 'Room', 'Device $mac removed',mac);
    if (Firebase.apps.isNotEmpty) {
      sendLogToFirebase(log);
    }
  } else {
    print('Failed to remove device');
  }
}

void sendDataToFirebase(String id, Map<String, dynamic> data) async {
  String databaseURL = 'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/';
  String jsonBody = json.encode(data);
  print('Data to be sent: $jsonBody');

  try {
    var response = await http.put(
      Uri.parse(databaseURL + 'Saved/$id.json'),
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Error occurred while sending data. Error code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  } catch (e) {
    print('Error occurred during HTTP request: $e');
  }
}

Future<Map<String, dynamic>> readDataFromFirebase(String id) async {
  String databaseURL = 'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/';

  try {
    var response = await http.get(
      Uri.parse(databaseURL + 'Saved/$id.json'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print('Data retrieved successfully: $data');
      return data;
    } else {
      print('Error occurred while retrieving data. Error code: ${response.statusCode}');
      print('Error message: ${response.body}');
      return {};
    }
  } catch (e) {
    print('Error occurred during HTTP request: $e');
    return {};
  }
}

class Device {
  final String mac;
  int rssi;
  String? name;
  String? advData;
  double distance;
  DateTime lastResponseTime;
  DateTime? firstDetectionTime;

  Device({
    required this.mac,
    required this.rssi,
    this.name,
    this.advData,
    required this.distance,
    required this.lastResponseTime,
    this.firstDetectionTime,
  });



  // Method to calculate the duration in seconds since the first detection
  int calculateDetectionDuration() {
    if (firstDetectionTime == null) {
      return 0;
    }
    return DateTime.now().difference(firstDetectionTime!).inSeconds;
  }

// Existing toJson method and others...


  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      mac: json['mac'],
      rssi: json['rssi'],
      name: json['name'],
      advData: json['advData'],
      distance: json['distance'].toDouble(),
      lastResponseTime: DateTime.now(),
      firstDetectionTime: null, // Initialize as null
    );
  }

  void updateName(String newName) {
    name = newName;
  }

  void updateDetectionTime() {
    if (firstDetectionTime == null) {
      firstDetectionTime = DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'mac': mac,
      'rssi': rssi,
      'name': name,
      'advData': advData,
      'distance': distance,
      'lastResponseTime': lastResponseTime.toIso8601String(),
      'firstDetectionTime': firstDetectionTime?.toIso8601String(), // Serialize as nullable
    };
  }
}

class DeviceDetailWidget extends StatelessWidget {
  final Device device;

  const DeviceDetailWidget({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/profile.png'),
                    alignment: Alignment.center,
                    //fill the image
                    fit: BoxFit.fill,

                  ),
                  Spacer(),

                ],
              ),

            ),

            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('İsim: ${device.name ?? 'Unknown'}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.0),
                  Text('MAC: ${device.mac}'),
                  SizedBox(height: 4.0),
                  Text('RSSI: ${device.rssi}'),
                  SizedBox(height: 4.0),
                  Text('Uzaklık: ${device.distance.toStringAsFixed(2)}m'),
                  SizedBox(height: 4.0),
                  Text('Son Cevap: ${device.lastResponseTime}'),
                  SizedBox(height: 4.0),
                  Text('İlk bulunma: ${device.firstDetectionTime ?? 'Bulunamadı'}'),
                  SizedBox(height: 4.0),
                  Text('Odada bulunma süresi: ${device.calculateDetectionDuration()} Saniye'),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: device.mac));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('MAC adresi kopyalandı: ${device.mac}')),
                      );
                    },
                    child: Text('MAC adresi Kopyala', textAlign: TextAlign.center),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sendAddRequest(device.mac);
                    },
                    child: Text('Cihazı Listeye ekle'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sendRemoveRequest(device.mac);
                    },
                    child: Text('Cihazı Listedan Çıkart'),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}


class DevicesResponse {
  final List<Device> devices;


  DevicesResponse({required this.devices});

  factory DevicesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['devices'] as List;
    List<Device> devicesList = list.map((i) => Device.fromJson(i)).toList();
    return DevicesResponse(devices: devicesList);
  }
}

DevicesResponse parseDevicesResponse(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return DevicesResponse.fromJson(parsed);
}

String cleanJsonString(String jsonString) {
  return jsonString.replaceAll(RegExp(r'[\x00-\x1F\x7F-\x9F]'), '');
}

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}



class _RoomPageState extends State<RoomPage> {
  var beaconNames = readDataFromFirebase('BeaconName');
  String? selectedIP = GlobalData().selectedIP;
  String selectedSort = 'name';
  Map<String, Device> devices = {};
  Timer? _timer;
  late TextEditingController _macController;
  late TextEditingController _nameController;
  late TextEditingController _refreshRateController;
  late TextEditingController _deviceTimeoutController;
  //refresh interval int standard value is 3
  int refreshInterval = 3;
  int deviceTimeout = 60;






  @override
  void initState() {
    super.initState();
    _macController = TextEditingController();
    _nameController = TextEditingController();
    _refreshRateController = TextEditingController(text: '3');
    _deviceTimeoutController = TextEditingController(text: '60');
    fetchDevicesPeriodically();
    checkBeaconNames(beaconNames);
  }

  void handleSaveDeviceName(String macAddress, String deviceName) {
    if (macAddress.isNotEmpty && deviceName.isNotEmpty) {
      beaconNames.then((value) {
        value[macAddress] = deviceName;
        sendDataToFirebase('BeaconName', value);
      });
      checkBeaconNames(readDataFromFirebase('BeaconName'));
      _macController.clear();
      _nameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both MAC address and device name')),
      );
    }
  }

  void fetchDevicesPeriodically() {
    final interval = Duration(seconds: refreshInterval);
    _timer?.cancel(); // Ensure any existing timer is cancelled before creating a new one
    _timer = Timer.periodic(interval, (Timer timer) async {
      await fetchDevices();
      checkBeaconNames(readDataFromFirebase('BeaconName'));

      var currentTime = DateTime.now();
      devices.removeWhere((key, device) {
        bool shouldRemove = currentTime.difference(device.lastResponseTime).inSeconds > deviceTimeout;
        if (shouldRemove) {
          LogEntry log = LogEntry(DateTime.now(), EventType.movementOut, selectedIP!, 'Device $key with name ${device.name} is out of range',key,device.calculateDetectionDuration());
          if (Firebase.apps.isNotEmpty) {
            sendLogToFirebase(log);
          }
        }
        return shouldRemove;
      });

      setState(() {});
    });
  }

  Future<void> fetchDevices() async {
    String? selectedIP = GlobalData().selectedIP;
    try {
      final String apiUrl = 'http://$selectedIP/getDevices';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        DevicesResponse devicesResponse = parseDevicesResponse(cleanJsonString(response.body));
        var currentTime = DateTime.now();
        devicesResponse.devices.forEach((device) {
          if (devices.containsKey(device.mac)) {
            devices[device.mac]!.rssi = device.rssi;
            devices[device.mac]!.advData = device.advData;
            devices[device.mac]!.distance = device.distance;
            devices[device.mac]!.lastResponseTime = currentTime;
          } else {
            device.firstDetectionTime = currentTime; // Set first detection time for new device
            devices[device.mac] = device;
            LogEntry log = LogEntry(DateTime.now(), EventType.movementIn, selectedIP!, 'Device ${device.mac} with name ${device.name} is in range', device.mac);
            if (Firebase.apps.isNotEmpty) {
              sendLogToFirebase(log);
            }
          }
        });
        setState(() {});
      } else {
        print('Failed to fetch devices: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch devices: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Failed to fetch devices: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch devices: $e')),
      );
    }
  }

  void checkBeaconNames(Future<Map<String, dynamic>> beaconNames) {
    beaconNames.then((value) {
      value.forEach((key, value) {
        if (devices.containsKey(key)) {
          devices[key]!.name = value;
        }
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _macController.dispose();
    _nameController.dispose();
    _refreshRateController.dispose();
    _deviceTimeoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oda Sayfası'),
        //selected ip
        actions: [
          Text('Seçili IP: $selectedIP'),
        ],
      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshDevices,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: selectedSort,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSort = newValue!;
                      sortDevices(selectedSort);
                    });
                  },
                  items: <String>['name', 'rssi', 'distance']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                //int input to change refresh interval


                //display the number of detected devices
                Text('Odadaki Cihaz Sayısı: ${devices.length}'),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Number of items per row
                  mainAxisSpacing: 10.0, // Space between items in the main axis (vertical)
                  crossAxisSpacing: 10.0, // Space between items in the cross axis (horizontal)
                  childAspectRatio: 2.7, // Ratio between the cross axis and the main axis
                ),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  Device device = devices.values.elementAt(index);
                  return DeviceDetailWidget(device: device);
                },
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _refreshRateController,
                        decoration: InputDecoration(
                          hintText: 'Yenileme Sıklığını Girin(Saniye)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        int newRate = int.tryParse(_refreshRateController.text) ?? 3; // Default to 3 seconds if parsing fails
                        refreshInterval = newRate;
                        _timer?.cancel(); // Cancel the existing timer
                        fetchDevicesPeriodically(); // Start a new timer with the updated interval
                      },
                      child: Text('Yenileme Sıklığı Kaydet'),
                    ),


                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _deviceTimeoutController,
                        decoration: InputDecoration(
                          hintText: 'Zamanaşımı Süresi Girin',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        int newTimeout = int.tryParse(_deviceTimeoutController.text) ?? 60; // Default to 60 seconds if parsing fails
                        setState(() {
                          deviceTimeout = newTimeout;
                        });
                      },
                      child: Text('Zamanaşımını Kaydet'),
                    ),
                  ],
                ),
                TextField(
                  controller: _macController,
                  decoration: InputDecoration(
                    hintText: 'MAC Adresi Girin',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Cihaz İsmi Girin',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String macAddress = _macController.text.trim();
                    String deviceName = _nameController.text.trim();
                    handleSaveDeviceName(macAddress, deviceName);
                  },
                  child: Text('Cihaz İsmi Kaydet'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new room functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _refreshDevices() async {
    await fetchDevices();
    checkBeaconNames(readDataFromFirebase('BeaconName'));
  }

  void sortDevices(String criteria) {
    setState(() {
      if (criteria == 'name') {
        devices = Map.fromEntries(
          devices.entries.toList()..sort((e1, e2) => (e1.value.name ?? '').compareTo(e2.value.name ?? '')),
        );
      } else if (criteria == 'rssi') {
        devices = Map.fromEntries(
          devices.entries.toList()..sort((e1, e2) => e2.value.rssi.compareTo(e1.value.rssi)),
        );
      } else if (criteria == 'distance') {
        devices = Map.fromEntries(
          devices.entries.toList()..sort((e1, e2) => e1.value.distance.compareTo(e2.value.distance)),
        );
      }
    });
  }

  String getAllDevicesAsJson() {
    List<Map<String, dynamic>> devicesJson = devices.values.map((device) => device.toJson()).toList();
    return jsonEncode(devicesJson);
  }
}



void sendLogToFirebase(LogEntry log) async {
  String databaseURL = 'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/';
  String jsonBody = json.encode(log.toJson());
  print('Log to be sent: $jsonBody');
  String logmac = log.beaconMac;

  try {
    var response = await http.post(
      Uri.parse(databaseURL + 'Logs/$logmac.json'),
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print('Log sent successfully');
    } else {
      print('Error occurred while sending log. Error code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  } catch (e) {
    print('Error occurred during HTTP request: $e');
  }
}
