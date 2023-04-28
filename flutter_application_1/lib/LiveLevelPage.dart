import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'currentWaterLevel.dart';

class LiveLevelPage extends StatefulWidget {
  @override
  _LiveLevelPageState createState() => _LiveLevelPageState();
}

class _LiveLevelPageState extends State<LiveLevelPage> {
  bool _isMenuOpen = false;

  void _openMenu() {
    setState(() {
      _isMenuOpen = true;
    });
  }

  void _closeMenu() {
    setState(() {
      _isMenuOpen = false;
    });
  }

  final Color primaryColor = const Color(0xFF21457D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF21457D),
              Color.fromARGB(255, 105, 169, 247),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 25,
              top: 50,
              child: Image.asset(
                'assets/logo2.png',
                width: 70,
                height: 70,
              ),
            ),
            Positioned(
              right: 80,
              top: 70,
              child: Icon(
                Icons.notifications,
                size: 32,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.709,
                child: _buildLive(),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.309,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: _buildGetDataButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLive() {
    return Container(
      child: WaterLevelBucket(sensorId: '001'),
    );
  }

  Widget _buildGetDataButton() {
    return ElevatedButton(
      onPressed: () {
        // Add your logic here to fetch data
      },
      child: Text('Update'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(
            221, 96, 167, 255), // Transparent with alpha value of 0

        elevation: 4, // Adjust the elevation value as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
