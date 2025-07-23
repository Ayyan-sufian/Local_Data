import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_project/screen/home%20page.dart';

import 'home-hive-pg.dart';

class welcomePg extends StatefulWidget {
  const welcomePg({super.key});

  @override
  State<welcomePg> createState() => _welcomePgState();
}

class _welcomePgState extends State<welcomePg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome to my App",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "If you want to store your data through Sqflite then click this button:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: "")),
              );
            },
            child: Text("Sqflite"),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "If you want to store your data through Hive then click this button:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeHivePg()),
              );
            },
            child: Text("Hive"),
          ),
        ],
      ),
    );
  }
}
