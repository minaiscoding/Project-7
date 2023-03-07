import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class Preview extends StatelessWidget {
  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff5fdff), Color(0xff4675C0)])),
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
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffffffff), Color(0xffDFECFF)]),
                  borderRadius: BorderRadius.circular(19.923),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff65A0FFCC).withOpacity(0.8),
                      blurRadius: 5,
                      spreadRadius: 0,
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
                    Text('include icon'),
                    SizedBox(height: 13.68),
                    Text('LOREM IPSUM',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10.64),
                    Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        'lorem ipsum dolor sit amet consecteur adipiscing elit duis dectum tortor velit ,at commodo nunc suscipicit pulvinar odio  '),
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
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffffffff), Color(0xffDFECFF)]),
                  borderRadius: BorderRadius.circular(19.923),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff65A0FFCC).withOpacity(0.8),
                      blurRadius: 5,
                      spreadRadius: 0,
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
                    Text('include icon'),
                    SizedBox(height: 13.68),
                    Text('LOREM IPSUM',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10.64),
                    Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        'lorem ipsum dolor sit amet consecteur adipiscing elit duis dectum tortor velit ,at commodo nunc suscipicit pulvinar odio  '),
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
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffffffff), Color(0xffDFECFF)]),
                  borderRadius: BorderRadius.circular(19.998),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff65A0FFCC).withOpacity(0.8),
                      blurRadius: 5,
                      spreadRadius: 0,
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
                    Text('include icon'),
                    SizedBox(height: 13.68),
                    Text('LOREM IPSUM',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10.64),
                    Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        'lorem ipsum dolor sit amet consecteur adipiscing elit duis dectum tortor velit ,at commodo nunc suscipicit pulvinar odio  '),
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
