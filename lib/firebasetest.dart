import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  sendDataToFirebase('BeaconName');
  readDataFromFirebase('BeaconName');
}

void sendDataToFirebase(String id) async {
  // Firebase Realtime Database URL
  String databaseURL = 'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/';

  // Data to be sent
  Map<String, dynamic> data = {
    '9c:d5:6d:2a:bc:48': 'miraç',
    '7d:96:47:34:ad:58': 'yiğit'
  };

  // Convert data to JSON format
  String jsonBody = json.encode(data);
  print('Data to be sent: $jsonBody');

  try {
    // Create HTTP PUT request
    var response = await http.put(
      Uri.parse(databaseURL + 'Saved/$id.json'), // Include ID in the path
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

void readDataFromFirebase(String id) async {
  // Firebase Realtime Database URL
  String databaseURL = 'https://beacon-detector-fb-568ab-default-rtdb.europe-west1.firebasedatabase.app/';

  try {
    // Create HTTP GET request
    var response = await http.get(
      Uri.parse(databaseURL + 'Saved/$id.json'), // Include ID in the path
    );

    // If successfully received data
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print('Data retrieved successfully: $data');
    } else {
      print('Error occurred while retrieving data. Error code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  } catch (e) {
    print('Error occurred during HTTP request: $e');
  }
}
