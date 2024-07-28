import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'custom_drawer.dart';


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
  final String _firebaseUrl =
      'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/Saved/BeaconName.json';

  Future<Map<String, String>> _fetchBeaconMacAddresses() async {
    try {
      final response = await http.get(Uri.parse(_firebaseUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        final Map<String, String> beaconMacAddresses = {};

        jsonData.forEach((key, value) {
          beaconMacAddresses[key] = value as String;
        });

        return beaconMacAddresses;
      } else {
        throw Exception('Veri yüklenemedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Veri yüklenemedi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Kayıtlı Beacon MAC Adresleri'),
      ),
      body: FutureBuilder(
        future: _fetchBeaconMacAddresses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final Map<String, String> beaconMacAddresses =
            snapshot.data as Map<String, String>;

            if (beaconMacAddresses.isEmpty) {
              return Center(child: Text('Hiç beacon MAC adresi yok'));
            }

            return ListView.builder(
              itemCount: beaconMacAddresses.length,
              itemBuilder: (context, index) {
                final beaconMac = beaconMacAddresses.keys.elementAt(index);
                final beaconName =
                    beaconMacAddresses[beaconMac] ?? 'Bilinmiyor';

                return ListTile(
                  title: Text(beaconName),
                  subtitle: Text('MAC Adresi: $beaconMac'),
                  trailing: Icon(Icons.timeline),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogsScreen(
                          beaconMac: beaconMac,
                          beaconName: beaconName,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Veri bekleniyor...'));
          }
        },
      ),
    );
  }
}

class LogsScreen extends StatefulWidget {
  final String beaconMac;
  final String beaconName;

  LogsScreen({required this.beaconMac, required this.beaconName});

  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  late List<Map<String, dynamic>> _logs;
  late StreamController<List<Map<String, dynamic>>> _streamController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _logs = [];
    _streamController = StreamController<List<Map<String, dynamic>>>();
    _fetchAndStreamLogs();

    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      _fetchAndStreamLogs();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamController.close();
    super.dispose();
  }

  Future<void> _fetchAndStreamLogs() async {
    try {
      final logs = await _fetchLogs(widget.beaconMac);
      setState(() {
        _logs = logs;
        _streamController.add(_logs);
      });
    } catch (e) {
      debugPrint('Günlükler alınamadı: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchLogs(String beaconMac) async {
    final String _logsUrl =
        'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/Logs.json';
    try {
      final response = await http.get(Uri.parse(_logsUrl));
      if (response.statusCode == 200) {
        final jsonData =
        json.decode(response.body) as Map<String, dynamic>;
        final List<Map<String, dynamic>> logs = [];

        jsonData.forEach((key, value) {
          value.forEach((innerKey, innerValue) {
            if (innerValue['beaconMac'] == beaconMac) {
              logs.add(innerValue);
            }
          });
        });

        final int startIndex = logs.length > 15 ? logs.length - 15 : 0;
        final List<Map<String, dynamic>> latestLogs =
        logs.sublist(startIndex, logs.length);

        return latestLogs.reversed.toList();
      } else {
        throw Exception('Veri yüklenemedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Veri yüklenemedi');
    }
  }

  List<Map<String, dynamic>> _processLogs(List<Map<String, dynamic>> logs) {
    List<Map<String, dynamic>> results = [];

    for (var log in logs) {
      final eventType = log['eventType'];
      final timestamp = DateTime.parse(log['timestamp']);
      final timeInRoomInSeconds = log['timeInRoom'] as int;

      if (timeInRoomInSeconds > 0) {
        // TimeInRoom'u dakikaya çevir
        final timeInRoomInMinutes = (timeInRoomInSeconds / 60).round();

        // Odada bulunduğu saat aralığını hesapla
        final inTime =
        timestamp.subtract(Duration(seconds: timeInRoomInSeconds));
        final outTime = timestamp;

        results.add({
          'inTime': inTime,
          'outTime': outTime,
          'duration': timeInRoomInMinutes,
        });
      }
    }

    // Son 15 kaydı alıyoruz, eğer veri 15'ten azsa tüm veriyi alırız
    int startIndex = results.length > 15 ? results.length - 15 : 0;
    results = results.sublist(startIndex, results.length);

    return results.reversed.toList(); // Son kayıtları en sona getiriyoruz
  }

  int _calculateTotalDuration(List<Map<String, dynamic>> logs) {
    int totalDuration = 0;

    for (var log in logs) {
      totalDuration += log['duration'] as int;
    }

    return totalDuration;
  }

  List<BarChartGroupData> _buildBarChartData(
      List<Map<String, dynamic>> results) {
    List<BarChartGroupData> barGroups = [];
    int index = 0;

    for (var result in results) {
      final duration = result['duration'] as int;
      final barChartGroupData = BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: duration.toDouble(),
            color: Colors.green,
            width: 15,
          ),
        ],
        showingTooltipIndicators: [0],
      );

      barGroups.add(barChartGroupData);
      index++;
    }

    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(

        title: Text('${widget.beaconName} Günlükleri'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final List<Map<String, dynamic>> results =
            _processLogs(snapshot.data!);

            final totalDuration = _calculateTotalDuration(results);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final inTime = results[index]['inTime'] as DateTime;
                      final outTime = results[index]['outTime'] as DateTime;
                      final duration = results[index]['duration'] as int;

                      return ListTile(
                        title: Text('İçeride Kalma Süresi: $duration dakika'),
                        subtitle: Row(
                          children: [
                            Text(
                                'Giriş: ${DateFormat('dd/MM/yyyy HH:mm').format(inTime)}'),
                            SizedBox(width: 10),
                            Text(
                                'Çıkış: ${DateFormat('dd/MM/yyyy HH:mm').format(outTime)}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      barGroups: _buildBarChartData(results),
                      titlesData: FlTitlesData(
                        // Başlık verilerinizin yapılandırması
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Toplam Süre: $totalDuration dakika',
                    style: TextStyle(fontSize: 18)),
              ],
            );
          } else {
            return Center(child: Text('Günlük bulunamadı'));
          }
        },
      ),
    );
  }
}
