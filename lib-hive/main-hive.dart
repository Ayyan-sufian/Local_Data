import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screen/home-hive-pg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screen/welcome-pg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  await Hive.openBox('image');

  runApp(const MyAppHive());
}

class MyAppHive extends StatelessWidget {
  const MyAppHive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "local storage",
      debugShowCheckedModeBanner: false,
      home: welcomePg(),
    );
  }
}
