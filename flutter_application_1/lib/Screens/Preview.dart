import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class Preview extends StatelessWidget {
  const Preview({Key? key}) : super(key: key);
  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFF5FDFF),
            Color(0xFF4675C0),
          ],
          stops: [0.0185, 1.3432],
          transform: GradientRotation(180 * 3.14151617 / 180),
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 48,
              top: 73,
              child: Container(
                width: 294,
                height: 215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.923),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFDFECFF),
                      Color(0xFFC3DBFF),
                      Color(0x00C3DBFF).withOpacity(0.8),
                    ],
                    stops: [0.0561, 0.2843, 0.8113, 1.4206],
                    transform: GradientRotation(139.58 * 3.141516 / 180),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(101, 160, 255, 0.8),
                      blurRadius: 27.5785,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10,
                      ),
                    ),
                    SizedBox(height: 5.8),
                    Image(
                      image: AssetImage('assets/percent.png'),
                      width: 24, // set the width of the image
                      height: 24, // set the height of the image
                    ),
                    SizedBox(height: 10.68),
                    Text('Water level',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.64,
                        left: 16,
                        bottom: 16,
                        right: 16,
                      ),
                      child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          'provides the user with their tank’s water level through a visual representation with great precision any time.'),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 48,
              top: 315,
              child: Container(
                width: 294,
                height: 215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.923),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFDFECFF),
                      Color(0xFFC3DBFF),
                      Color(0x00C3DBFF).withOpacity(0.8),
                    ],
                    stops: [0.0561, 0.2843, 0.8113, 1.4206],
                    transform: GradientRotation(139.58 * 3.141516 / 180),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(101, 160, 255, 0.8),
                      blurRadius: 27.5785,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10,
                      ),
                    ),
                    SizedBox(height: 5.8),
                    Image(
                      image: AssetImage('assets/history.png'),
                      width: 30, // set the width of the image
                      height: 30, // set the height of the image
                    ),
                    SizedBox(height: 10.68),
                    Text('History',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.64,
                        left: 16,
                        bottom: 16,
                        right: 16,
                      ),
                      child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          'keeps track of the water level by time and displays it through a graph either monthly, weekly or daily.'),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 48,
              top: 557,
              child: Container(
                width: 294,
                height: 215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.923),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFDFECFF),
                      Color(0xFFC3DBFF),
                      Color(0x00C3DBFF).withOpacity(0.8),
                    ],
                    stops: [0.0561, 0.2843, 0.8113, 1.4206],
                    transform: GradientRotation(139.58 * 3.141516 / 180),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(101, 160, 255, 0.8),
                      blurRadius: 27.5785,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10,
                      ),
                    ),
                    SizedBox(height: 5.8),
                    Image(
                      image: AssetImage('assets/mail.png'),
                      width: 24, // set the width of the image
                      height: 24, // set the height of the image
                    ),
                    SizedBox(height: 10.68),
                    Text('SMS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.64,
                        left: 16,
                        bottom: 16,
                        right: 16,
                      ),
                      child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          'offers the possibility of checking water level via SMS by sending a specific code and sends sms messages in dangerous situations.'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
