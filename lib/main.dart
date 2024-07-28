import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'custom_drawer.dart'; // Ensure this file defines a CustomDrawer class
import 'firebase_options.dart';

class Device {
  final String name;
  final String mac;
  final DateTime lastResponseTime;
  final String ip;

  Device({
    required this.name,
    required this.mac,
    required this.lastResponseTime,
    required this.ip,
  });
}

class DeviceDetailWidget extends StatelessWidget {
  final Device device;
  final VoidCallback onSelect;

  const DeviceDetailWidget({Key? key, required this.device, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(device.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MAC: ${device.mac}'),
            Text('Son Cevap: ${device.lastResponseTime}'),
            Text('IP: ${device.ip}'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onSelect,
          child: Text('Seç'),
        ),
      ),
    );
  }
}

class ESP32Finder extends StatefulWidget {
  @override
  _ESP32FinderState createState() => _ESP32FinderState();
}

class _ESP32FinderState extends State<ESP32Finder> {
  final TextEditingController startIPController = TextEditingController(text: '10.34.82.1');
  final TextEditingController endIPController = TextEditingController(text: '10.34.82.255');
  double progress = 0.0;
  Map<String, List<Device>> devices = {};
  int totalIpsToScan = 0;
  int scannedIpsCount = 0;

  Future<void> startScanning() async {
    String startIP = startIPController.text;
    String endIP = endIPController.text;

    setState(() {
      progress = 0.0;
      devices = {};
      scannedIpsCount = 0;
    });

    totalIpsToScan = calculateTotalIPs(startIP, endIP);

    devices = await fetchAllData(startIP, endIP);

    setState(() {
      progress = 1.0;
    });
  }

  int calculateTotalIPs(String startIP, String endIP) {
    int start = int.parse(startIP.split('.').last);
    int end = int.parse(endIP.split('.').last);
    return (end - start + 1);
  }

  Future<Map<String, List<Device>>> fetchAllData(String startIP, String endIP) async {
    Map<String, List<Device>> allData = {};
    List<Future<void>> futures = [];

    int start = int.parse(startIP.split('.').last);
    int end = int.parse(endIP.split('.').last);
    String baseIP = startIP.substring(0, startIP.lastIndexOf('.'));

    for (int i = start; i <= end; i++) {
      String ip = '$baseIP.$i';
      futures.add(scanAndFetchData(ip, allData));
    }

    await Future.wait(futures);

    return allData;
  }

  Future<void> scanAndFetchData(String ip, Map<String, List<Device>> allData) async {
    try {
      String apiUrl = 'http://$ip/getDeviceInfo';
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic>? jsonData = jsonDecode(response.body);

        if (jsonData != null && jsonData['mac'] != null && jsonData['deviceType'] != null) {
          String macAddress = jsonData['mac'];
          String deviceType = jsonData['deviceType'];
          DateTime lastResponseTime = DateTime.now();

          Device device = Device(
            name: deviceType,
            mac: macAddress,
            lastResponseTime: lastResponseTime,
            ip: ip,
          );

          if (!allData.containsKey(macAddress)) {
            allData[macAddress] = [];
          }
          allData[macAddress]!.add(device);
        } else {
          print('Missing data in response from $ip');
        }
      } else {
        print('Failed to fetch data from $ip: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception when fetching data from $ip: $e');
    }

    setState(() {
      scannedIpsCount++;
      progress = scannedIpsCount / totalIpsToScan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Tarayıcı',
      home: Scaffold(
        appBar: AppBar(
          //title and selected ip
          title: Text('ESP32 Tarayıcı'),


        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            //text that dsiplays no ip selected or selected ip
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Seçili IP: ${GlobalData().selectedIP ?? 'Henüz Seçilmedi'}'),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                //controller with default text
                controller: startIPController,
                decoration: InputDecoration(
                  //default text
                  labelText: 'Başlangıç IP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: endIPController,
                decoration: InputDecoration(
                  labelText: 'Bitiş IP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: startScanning,
              child: Text('Tarayıcıyı Başlat'),
            ),

            LinearProgressIndicator(value: progress),
            Expanded(
              child: devices.isEmpty
                  ? Center(child: Text('Cihaz Bulunamadı'))
                  : ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  var deviceList = devices.values.toList()[index];
                  var macAddress = devices.keys.toList()[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ESP32 MAC Adres: $macAddress',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: deviceList.length,
                        itemBuilder: (context, index) {
                          return DeviceDetailWidget(
                            device: deviceList[index],
                            onSelect: () {
                              setState(() {
                                GlobalData().selectedIP = deviceList[index].ip;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Seçili IP: ${deviceList[index].ip}')),

                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();
  String? selectedIP;

  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'beacon-detector',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ESP32Finder());
}
