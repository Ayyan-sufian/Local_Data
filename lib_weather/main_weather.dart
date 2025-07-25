import 'package:flutter/material.dart';

import 'screens/MyAppWeather.dart';

void main() async {
  runApp(const MyAppWeather());
}

class MyAppWeather extends StatelessWidget {
  const MyAppWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: MyAppHome(),
    );
  }
}
