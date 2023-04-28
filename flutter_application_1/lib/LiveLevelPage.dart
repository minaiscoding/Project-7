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
  String lastUpdateTime = '';

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

  String getLastUpdatedTime() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }

  void updateLastUpdateTime() {
    setState(() {
      lastUpdateTime = getLastUpdatedTime();
    });
  }

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
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: _buildGetDataButton(),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.37,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                '100 L',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Aquire', fontSize: 35),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.19,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                'Last updated: $lastUpdateTime',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
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
        updateLastUpdateTime();
      },
      child: Text(
        'Update',
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(
          221,
          96,
          167,
          255,
        ), // Transparent with alpha value of 0

        elevation: 4, // Adjust the elevation value as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
