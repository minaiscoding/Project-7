import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {
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
              width: 439.08,
              height: 312,
              top: 68,
              left: -25,
              child: Image.asset('assets/logo (1).png'),
            ),
            Positioned(
              width: 111,
              height: 36,
              top: 244,
              left: 142,
              child: Text('FLUID',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1a2a3a),
                    fontSize: 37,
                  )),
            ),
            Positioned(
              top: 340,
              right: 53,
              width: 275,
              height: 72,
              child: Text(
                'Lorem ipsum dolor sit amet',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              child: Positioned(
                  bottom: 0, left: 0, child: Image.asset('assets/ripple1.png')),
            ),
            Container(
              child: Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset('assets/ripple2.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
