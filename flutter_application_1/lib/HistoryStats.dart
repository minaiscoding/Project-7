import 'package:flutter/material.dart';
import 'Graph.dart';
import 'Home.dart';
import 'dart:ui';
import 'currentWaterLevel.dart';

class HistoryStats extends StatefulWidget {
  @override
  _HistoryStatsState createState() => _HistoryStatsState();
}

WaterLevelChart chartWidget = new WaterLevelChart(
    rangeStart: Duration(days: 1), sensor_ID: "'001'", key: UniqueKey());
String dropdownValue = 'Daily';

class _HistoryStatsState extends State<HistoryStats> {
  bool _isLiveSelected = true;
  bool _isMenuOpen = false;

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
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Color(0xFF989898),
                        ),
                        SizedBox(width: 5),
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(59, 142, 0, 0),
                    width: 273,
                    height: 434,
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
                        menuItem('Home', true),
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
              bottom: 90,
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
                icon: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: const Icon(Icons.arrow_drop_down),
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
                            rangeStart: Duration(days: 7),
                            sensor_ID: "'001'",
                            key: UniqueKey());
                        break;
                      case 'Monthly':
                        chartWidget = WaterLevelChart(
                            rangeStart: Duration(days: 30),
                            sensor_ID: "'001'",
                            key: UniqueKey());
                        break;
                      case 'Daily':
                        chartWidget = WaterLevelChart(
                            rangeStart: Duration(hours: 24),
                            sensor_ID: "'001'",
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
    return Container(
      child: WaterLevelBucket(sensorId: '001'),
    );
  }
}
