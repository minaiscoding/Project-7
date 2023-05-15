import 'package:flutter/material.dart';
import '../Widgets/graph.dart';
import 'dart:ui';
import '../Widgets/current_water_level.dart';
import '../Widgets/menu.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:influxdb_client/api.dart';
import 'dart:async';
import 'dart:convert';

class LiveHistoryPage extends StatefulWidget {
  final String sensorID;
  LiveHistoryPage(this.sensorID);
  @override
  _LiveHistoryPageState createState() => _LiveHistoryPageState();
}

WaterLevelChart chartWidget = WaterLevelChart(
    rangeStart: const Duration(hours: 1), sensorID: '001', key: UniqueKey());
String dropdownValue = 'Daily';

class _LiveHistoryPageState extends State<LiveHistoryPage> {
  bool _isLiveSelected = true;
  bool _isMenuOpen = false;
  double _waterLevel = 0;
  bool one = true;
  Future<void> getWaterLevelData() async {
    var token =
        '8jtFDtDrQpDKrjceYg8ZKAyRL90Muwa1H0xm1dGsyNKPEbNUnG-Oz4t5XILOJAf2nZAu9lZIxZMfgvUuxOvY1g==';
    var bucket = 'LevelData';
    var org = 'Fluid';
    var client = InfluxDBClient(
        url: 'https://us-east-1-1.aws.cloud2.influxdata.com',
        token: token,
        org: org,
        bucket: bucket);
    var fluxQuery = '''from(bucket: "LevelData")
    |> range(start: -1m)
    |> filter(fn: (r) => r["_measurement"] == "water_level")
    |> filter(fn: (r) => r["_field"] == "value")
    |> filter(fn: (r) => r["sensor"] == "${widget.sensorID}")
    |> aggregateWindow(every: 5s, fn: mean)
    |> yield(name: "mean")''';
    var queryService = client.getQueryService();

    var recordStream = await queryService.query(fluxQuery);
    var data = <double>[];
    await recordStream.forEach((record) {
      var value = record['_value'];
      if (value != null) {
        data.add(value);
      }
    });

    if (mounted && data.isNotEmpty) {
      setState(() {
        _waterLevel = data.isNotEmpty ? data.last : _waterLevel;
      });
    }
    print(_waterLevel);
    if (_waterLevel >= 100 && one) {
      one = false;
      triggerNotification(_waterLevel);
    } else {
      if (_waterLevel < 100) {
        one = true;
      }
    }
  }

  void triggerNotification(double waterLevel) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10, // -1 is replaced by a random number
      channelKey: 'alerts',
      title: 'Your tank is getting empty !',
      body: "Make sure to fill it as soon as possible",
    ));
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      getWaterLevelData();
    });
  }

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    chartWidget = WaterLevelChart(
        rangeStart: const Duration(hours: 1),
        sensorID: "" + widget.sensorID + "",
        key: UniqueKey());
    _startTimer();
  }

  void _selectLive() {
    setState(() {
      _isLiveSelected = true;
      _isMenuOpen = false;
    });
  }

  void _selectHistory() {
    setState(() {
      _isLiveSelected = false;
      _isMenuOpen = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.291,
              decoration: BoxDecoration(
                color: Color(0xFFBBD0EA),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF21457D),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 25,
                    top: 50,
                    child: Image.asset(
                      'assets/SmallLogo.png',
                      width: 70, // Set width to 50 pixels
                      height: 70, // Set height to 50 pixels
                    ),
                  ),
                  Positioned(
                    right: 80,
                    top: 70,
                    child: Icon(Icons.notifications,
                        size: 32, color: Color(0xFF1A2A3A)),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 156,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 97,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: _selectLive,
                          child: Stack(children: [
                            Container(
                              width: 90,
                              height: 36,
                              child: Center(
                                child: Text(
                                  'Live',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: _isLiveSelected
                                        ? Color(0xFF1A2A3A)
                                        : Color(0xFF989898),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Color(0xFF989898),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: _selectHistory,
                          child: Stack(children: [
                            Container(
                              width: 150,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'History',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: !_isLiveSelected
                                        ? Color(0xFF1A2A3A)
                                        : Color(0xFF989898),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: _isLiveSelected ? _buildLive() : _buildHistory(),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 25,
              top: 70,
              child: GestureDetector(
                onTapDown: (details) {
                  _openMenu();
                },
                child: BackdropFilter(
                  child: Icon(Icons.menu, size: 32, color: Color(0xFF1A2A3A)),
                  filter: ImageFilter.blur(
                      sigmaX: _isMenuOpen ? 5.0 : 0,
                      sigmaY: _isMenuOpen ? 5.0 : 0),
                ),
              ),
            ),
            Visibility(
              visible: _isMenuOpen,
              child: Stack(
                children: <Widget>[
                  Menu(),
                  Positioned(
                    top: 150,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 40,
                      color: const Color(0xFF21457D),
                      onPressed: () {
                        setState(() {
                          _closeMenu();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory() {
    return Container(
      child: Stack(
        children: [
          Visibility(
            visible: dropdownValue == 'Weekly' ||
                dropdownValue == 'Monthly' ||
                dropdownValue == 'Daily',
            child: Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 40,
              child: chartWidget,
            ),
          ),
          Positioned(
              top: 10,
              right: 40,
              child: DropdownButton<String>(
                items: <String>['Daily', 'Weekly', 'Monthly']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: dropdownValue,
                icon: const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Icon(Icons.arrow_drop_down),
                ),
                iconSize: 24,
                style: const TextStyle(
                  fontSize: 14.99,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1A2A3A),
                ),
                underline: Container(
                  height: 2,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    style:
                    const TextStyle(
                      fontSize: 14.99,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1A2A3A),
                    );
                    dropdownValue = newValue!;

                    switch (dropdownValue) {
                      case 'Weekly':
                        chartWidget = WaterLevelChart(
                            rangeStart: const Duration(days: 7),
                            sensorID: "" + widget.sensorID + "",
                            key: UniqueKey());
                        break;
                      case 'Monthly':
                        chartWidget = WaterLevelChart(
                            rangeStart: const Duration(days: 30),
                            sensorID: "" + widget.sensorID + "",
                            key: UniqueKey());
                        break;
                      case 'Daily':
                        chartWidget = WaterLevelChart(
                            rangeStart: const Duration(hours: 1),
                            sensorID: "" + widget.sensorID + "",
                            key: UniqueKey());
                        break;
                    }
                  });
                },
              )),
        ],
      ),
    );
  }

  Widget _buildLive() {
    String tank_number = widget.sensorID;

    return Container(
      child: WaterLevelBucket(
        sensorId: tank_number,
      ),
    );
  }
}
