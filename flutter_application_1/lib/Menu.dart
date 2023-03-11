import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class Menu extends StatelessWidget {
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
                      width: 69,
                      height: 33,
                      alignment: Alignment.center,
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.33333,
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
          ],
        ),
      ),
    );
  }
}
