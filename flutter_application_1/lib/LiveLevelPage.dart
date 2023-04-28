import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:http/http.dart' as http;

class LiveLevelPage extends StatefulWidget {
  @override
  _LiveLevelPageState createState() => _LiveLevelPageState();
}

class _LiveLevelPageState extends State<LiveLevelPage> {
  bool _isMenuOpen = false;
  String lastUpdateTime = '';
  late WaterLevelFetcher dataFetcher;

  @override
  void initState() {
    super.initState();
    dataFetcher = WaterLevelFetcher('001');
  }

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

  void fetchDataAndUpdate() async {
    await dataFetcher.fetchData();
    updateLastUpdateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 41, 99),
              Color.fromARGB(255, 84, 133, 194),
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
                'assets/logo_white.png',
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
                '${dataFetcher.waterLevel} L',
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
      child: WaterLevelBucket(
        dataFetcher: dataFetcher,
      ),
    );
  }

  Widget _buildGetDataButton() {
    return ElevatedButton(
      onPressed: () {
        fetchDataAndUpdate();
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
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}

class WaterLevelFetcher {
  final String sensorId;
  double waterLevel = 4.0;

  WaterLevelFetcher(this.sensorId);

  Future<void> fetchData() async {
    var url =
        'http://192.168.167.102:5000'; // Replace with your API endpoint URL

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var value = double.tryParse(response.body);
        if (value != null) {
          waterLevel = value;
        } else {
          print('Failed to parse the response body as a double.');
        }
      } else {
        print('HTTP request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred during the HTTP request: $e');
    }
  }
}

class WaterLevelBucket extends StatefulWidget {
  final WaterLevelFetcher dataFetcher;

  const WaterLevelBucket({Key? key, required this.dataFetcher})
      : super(key: key);

  @override
  _WaterLevelBucketState createState() => _WaterLevelBucketState();
}

class _WaterLevelBucketState extends State<WaterLevelBucket> {
  @override
  void initState() {
    super.initState();
    widget.dataFetcher.fetchData();
    Timer.periodic(
        Duration(seconds: 5), (Timer t) => widget.dataFetcher.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.7,
        child: LiquidCircularProgressIndicator(
          value: widget.dataFetcher.waterLevel / 100,
          valueColor: AlwaysStoppedAnimation(Color.fromARGB(123, 96, 167, 255)),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          borderColor: Colors.white,
          borderWidth: 1,
          direction: Axis.vertical,
          center: Text(
            '${widget.dataFetcher.waterLevel.toStringAsFixed(1)} %',
            style: TextStyle(
              fontSize: 56,
              fontFamily: "Aquire",
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
    );
  }
}
