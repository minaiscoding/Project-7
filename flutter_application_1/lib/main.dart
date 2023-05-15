import 'package:flutter/material.dart'; //imports dart
import 'live_level.dart';
import 'add_tank.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Tank tank = Tank();
  await tank.loadFromSharedPreferences();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: tank.height == "0" ? const TankShapePage() : const LiveLevelPage(),
      // home: TankPage(),
    ),
  );
}
