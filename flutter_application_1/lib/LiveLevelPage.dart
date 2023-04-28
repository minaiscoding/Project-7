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
              bottom: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: _buildDateTimeContainer(),
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

  Widget _buildDateTimeContainer() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d').format(now);
    String formattedTime = DateFormat.jm().format(now);

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: Color.fromARGB(218, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 2, 84, 87).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formattedDate,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
