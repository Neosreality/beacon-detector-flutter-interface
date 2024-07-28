import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _logsUrl =
      'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/Logs.json';

  Future<Map<String, Map<String, dynamic>>> _fetchBeaconData() async {
    try {
      final response = await http.get(Uri.parse(_logsUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        final Map<String, Map<String, dynamic>> beaconData = {};

        jsonData.forEach((logId, logInfo) {
          final beaconMac = logInfo['beaconMac'] as String?;
          final eventType = logInfo['eventType'] as String?;
          final timestamp = logInfo['timestamp'] as String?;

          if (beaconMac != null && eventType != null && timestamp != null) {
            if (!beaconData.containsKey(beaconMac) ||
                //timestamp > beaconData[beaconMac]!['timestamp']) {
                timestamp.compareTo(beaconData[beaconMac]!['timestamp']) > 0) {
              beaconData[beaconMac] = {
                'eventType': eventType,
                'timestamp': timestamp,
              };
            }
          }
        });

        return beaconData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beacon MAC Values'),
      ),
      body: FutureBuilder(
        future: _fetchBeaconData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final Map<String, Map<String, dynamic>> beaconData =
            snapshot.data as Map<String, Map<String, dynamic>>;
            List<String> results = [];

            String movementInMac = '';
            String movementOutMac = '';

            beaconData.forEach((beaconMac, data) {
              String eventType = data['eventType'];
              String timestamp = data['timestamp'];

              if (eventType == 'EventType.movementIn') {
                movementInMac = beaconMac;
              } else if (eventType == 'EventType.movementOut') {
                movementOutMac = beaconMac;
              }

              if (movementInMac.isNotEmpty && movementOutMac.isNotEmpty) {
                // Zaman farkını hesapla
                results.add(
                    '$movementInMac (movementIn) - $movementOutMac (movementOut)');
                movementInMac = ''; // Reset for next comparison
                movementOutMac = ''; // Reset for next comparison
              }
            });

            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Result ${index + 1}'),
                  subtitle: Text(results[index]),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
