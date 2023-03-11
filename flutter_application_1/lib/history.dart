import 'package:flutter/material.dart';
import 'Home.dart';
import 'dart:ui';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isLevelSelected = true;
  bool _isMenuOpen = false;

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
              left: 49,
              top: 156,
              child: Column(
                children: [
                  Container(
                    width: 293,
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
                        GestureDetector(
                          onTap: _selectLevel,
                          child: Container(
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
                        ),
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Color(0xFF989898),
                        ),
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
                      ],
                    ),
                  ),
                  Container(
                    width: 293,
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
                    child:
                        _isLevelSelected ? _buildLevel() : _buildTemperature(),
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
              visible:
                  _isMenuOpen, // Show the stack if showStack is true, hide it if false
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(59, 142, 0, 0),
                    width: 273,
                    height: 490,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromRGBO(26, 42, 58, 0.25),
                        width: 1,
                      ),
                      boxShadow: [
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
                        ElevatedButton(
                          onPressed: () {},
                          child: Container(
                            width: 121,
                            height: 56,
                            alignment: Alignment.center,
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                height: 1,
                                color: Color(0XFF21457D),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {},
                          child: Container(
                            width: 121,
                            height: 56,
                            alignment: Alignment.center,
                            child: Text(
                              'History',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0XFF21457D),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            shadowColor: Color(0XFF21457D),
                          ),
                        ),
                        SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {},
                          child: Container(
                            width: 121,
                            height: 56,
                            alignment: Alignment.center,
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                height: 1,
                                color: Color(0XFF21457D),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {},
                          child: Container(
                            width: 121,
                            height: 56,
                            alignment: Alignment.center,
                            child: Text(
                              'FAQ',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                height: 1,
                                color: Color(0XFF21457D),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {},
                          child: Container(
                            width: 70,
                            height: 33,
                            alignment: Alignment.center,
                            child: Text(
                              'Log out',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 17.33333,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0XFF21457D),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            shadowColor: Color(0XFF21457D),
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
                      color: Color(0XFF21457D),
                      onPressed: () {
                        setState(() {
                          _isMenuOpen =
                              false; // Set showStack to false to hide the stack
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

  Widget _buildLevel() {
    return Container(
      child: Center(
        child: Text(
          'Level Graph',
          style: TextStyle(fontSize: 24),
        ),
      ),
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
