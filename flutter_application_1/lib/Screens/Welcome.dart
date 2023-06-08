import 'package:flutter/material.dart'; //imports dart
import 'sign_up.dart';
import 'login_page.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Image.asset(
                  'assets/WelcomeLogo.png',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'WELCOME',
                  style: TextStyle(
                    color: Color(0xff1A2A3A),
                    fontFamily: 'aquire',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffFFFFFF),
                              Color(0xffC7DEFF),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Color(0xff65A0FF), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor:
                                Colors.transparent.withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.transparent.withOpacity(0.12),
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
                          child: const Padding(
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
                          ))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                const Text("Don't have an account ?",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: Color(0xff1A2A3A),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text("Sign up",
                      style: TextStyle(
                        color: Color(0xff1A2A3A),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
