import 'package:flutter/material.dart'; //imports dart

import 'live_level.dart';

import 'add_tank.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Tank tank = Tank();
  await tank.loadFromSharedPreferences();
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: tank.height == "0" ? TankShapePage() : LiveLevelPage(),
      // home: TankPage(),
    ),
  );
}
