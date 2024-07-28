import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
enum EventType {
  warning,
  error,
  update,
  movementIn,
  movementOut,

}


Future<void> sendLogToFirebase(LogEntry log) async {
  // Firebase Realtime Database URL
  String databaseURL = 'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/';



  // Convert data to JSON format
  String jsonBody = json.encode(log.toJson());
  print('Data to be sent: $jsonBody');

  try {
    // Create HTTP POST request
    var response = await http.post(
      Uri.parse(databaseURL + 'Logs.json'), // Include ID in the path
      body: jsonBody, // Send JSON data
    );

    // If successfully sent
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



class LogEntry {
  //timestamp, event type, source, message
   late DateTime timestamp;
   late EventType eventType;
   late String source;
   late String message;
   late String beaconMac;
   late int timeInRoom;


   //constructor
    LogEntry(this.timestamp, this.eventType, this.source, this.message, this.beaconMac, [this.timeInRoom = 0]);

    //factory method
    factory LogEntry.fromJson(Map<String, dynamic> json) {
      return LogEntry(
        DateTime.parse(json['timestamp']),
        EventType.values.firstWhere((e) => e.toString() == 'EventType.${json['eventType']}'),
        json['source'],
        json['message'],
        json['beaconMac'],
        json['timeInRoom'],
      );
    }

   Map<String, dynamic> toJson() {
     return {
       'timestamp': timestamp.toIso8601String(),
       'eventType': eventType.toString(), // Ensure EventType is serializable
        'source': source,
       'message': message,
       'beaconMac': beaconMac,
        'timeInRoom': timeInRoom,
     };
   }
}


