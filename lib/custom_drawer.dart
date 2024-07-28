import 'package:flutter/material.dart';


import 'configurationsPage.dart'; // Ensure this file defines a Page1 class

import 'main.dart';
import 'room_page.dart';
import 'logvis.dart';


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menü',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ESP32Finder()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.one_k),
            title: Text('Konfigürasyon Sayfası'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Page1()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.two_k),
            title: Text('Raporlama Sayfası'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.room),
            title: Text('Room Page'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RoomPage()),
              );
            },
          ),

        ],
      ),
    );
  }
}




