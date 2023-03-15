import 'package:fluid/SignIn.dart';

import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

import 'SignUp.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF5FDFF),
            Color(0xFF4675C0),
          ],
          stops: [
            0.0185,
            1.3432,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        body: Stack(
          children: <Widget>[
            Positioned(
              width: 656,
              height: 426.36,
              top: 34,
              left: -135,
              child: Image.asset('assets/logo (2).png'),
            ),
            Positioned(
              top: 427,
              left: 101,
              child: Text(
                textAlign: TextAlign.center,
                'WELCOME',
                style: TextStyle(
                  color: Color(0xff1A2A3A),
                  fontFamily: 'aquire',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
                width: 246,
                height: 52,
                left: 72,
                top: 592,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffFFFFFF),
                            Color(0xffC7DEFF),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xff65A0FF), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.88,
                              color: Color(0xff1A2A3A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )))),
            Positioned(
              width: 219,
              height: 22,
              top: 697,
              left: 92,
              child: Text("Don't have an account ?",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Color(0xff1A2A3A),
                  )),
            ),
            Positioned(
              top: 733,
              left: 155,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Positioned(
                  child: Text("Sign up",
                      style: TextStyle(
                        color: Color(0xff1A2A3A),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
