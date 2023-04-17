import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Home.dart';
import 'currentWaterLevel.dart';
import 'dart:ui';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLevelSelected = true;
  bool _isMenuOpen = false;
  double _waterLevel = 0;

  Future<double> _getWaterLevel() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.4:5000/water-level'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final waterLevel = data['water_level'];
      return waterLevel;
    } else {
      throw Exception('Failed to load water level');
    }
  }

  void triggerNotification(double waterLevel) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10, // -1 is replaced by a random number
      channelKey: 'alerts',
      title: 'Your tank is getting empty !',
      body: "You only have ${waterLevel}% left in your tank",
    ));
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        final waterLevel = await _getWaterLevel();
        setState(() {
          _waterLevel = waterLevel;
        });
        print('Water level: $_waterLevel');
        triggerNotification(_waterLevel);
      } catch (e) {
        print(e);
      }
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
    _startTimer();
  }

  void _selectLevel() {
    setState(() {
      _isLevelSelected = true;
      _isMenuOpen = false;
    });
  }

  void _selectTemperature() {
    setState(() {
      _isLevelSelected = false;
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

  Widget menuItem(String title, bool isSelected) {
    final textStyle = TextStyle(
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 24,
      height: 1,
      color: isSelected ? Colors.white : Color(0xFF21457D),
    );
    final elevation = isSelected ? 8.0 : 0.0;
    final backgroundColor = isSelected ? Color(0xFF21457D) : Colors.white;
    final boxShadow = isSelected
        ? [
            BoxShadow(
              color: Color.fromRGBO(101, 160, 255, 0.5),
              offset: Offset(0, 8),
              blurRadius: 30,
            ),
          ]
        : null;
    final borderRadius = BorderRadius.circular(30);

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        shadowColor: Color(0xFF21457D),
      ),
      child: Container(
        width: 121,
        height: 56,
        alignment: Alignment.center,
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }

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
              height: MediaQuery.of(context).size.height *
                  0.291, // 277/926 (iPhone 14 height)
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
                      'assets/logo2.png',
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
              // left: 100,
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
                          onTap: _selectLevel,
                          child: Stack(children: [
                            Container(
                              width: 90,
                              height: 36,
                              child: Center(
                                child: Text(
                                  'Level',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: _isLevelSelected
                                        ? Color(0xFF1A2A3A)
                                        : Color(0xFF989898),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Color(0xFF989898),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: _selectTemperature,
                          child: Container(
                            width: 150,
                            height: 50,
                            child: Center(
                              child: Text(
                                'Temperature',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: !_isLevelSelected
                                      ? Color(0xFF1A2A3A)
                                      : Color(0xFF989898),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 459,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: _isLevelSelected
                        ? _buildLevel(_waterLevel)
                        : _buildTemperature(),
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(59, 142, 0, 0),
                    width: 273,
                    height: 490,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(26, 42, 58, 0.25),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(101, 160, 255, 0.5),
                          offset: Offset(0, 8),
                          blurRadius: 30,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(33),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        menuItem('Home', false),
                        SizedBox(height: 28),
                        menuItem('History', true),
                        SizedBox(height: 28),
                        menuItem('Settings', false),
                        SizedBox(height: 28),
                        menuItem('FAQ', false),
                        SizedBox(height: 28),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Log out',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF21457D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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

  Widget _buildLevel(double waterLevel) {
    return Container(
      child: WaterLevelBucket(sensorId: "'001'"),

    );
  }

  Widget _buildTemperature() {
    return Container(
      child: Center(
        child: Text(
          'Temperature',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
