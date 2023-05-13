import 'package:fluid/Screens/login_page.dart';
import 'package:flutter/material.dart'; //imports dart
import 'sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        body: Stack(
          children: <Widget>[
            Positioned(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.5,
              top: MediaQuery.of(context).size.height * 0.07,
              left: MediaQuery.of(context).size.width * 0.057,
              child: Image.asset('assets/WelcomeLogo.png'),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.47,
              left: MediaQuery.of(context).size.width * 0.27,
              child: const Text(
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
                width: MediaQuery.of(context).size.width * 0.61,
                height: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.width * 0.19,
                top: MediaQuery.of(context).size.height * 0.7,
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
                        )))),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              top: MediaQuery.of(context).size.height * 0.8,
              left: MediaQuery.of(context).size.width * 0.23,
              child: const Text("Don't have an account ?",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Color(0xff1A2A3A),
                  )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.84,
              left: MediaQuery.of(context).size.width * 0.4,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Positioned(
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
