import 'package:fluid/main.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Color(0xFF789CD2),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
          ),
          Container(
            height: 350,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: Color(0xFF789CD2),
              ),
            ),
          ),
          Positioned(
            //left: MediaQuery.of(context).size.width * 0.0709,
            right: MediaQuery.of(context).size.width * 0.86,
            top: MediaQuery.of(context).size.height * 0.1,
            // bottom: MediaQuery.of(context).size.height * 0.90,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PageViewDemo()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.2,
            top: 72,
            child: Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 45,
                color: Colors.white,
                height: 1.2,
              ),
            ),
          ),
          Positioned(
            left: 52,
            bottom: 320,
            child: Container(
              width: 288,
              height: 288,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF789CD2),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF789CD2), width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF789CD2), width: 1),
                        ),
                        prefixIcon: Icon(Icons.phone, color: Color(0xFF989898)),
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF789CD2), width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF789CD2), width: 1),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF989898)),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            width: 157,
            height: 60,
            left: 117,
            top: 470,
            child: ElevatedButton(
              onPressed: () {},
              child: Container(
                width: 112,
                height: 34,
                alignment: Alignment.center,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF789CD2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Color(0xFF789CD2),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 300,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 300),
              painter: WavePainter(),
            ),
          ),
          Positioned(
            top: 570,
            left: 46,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.2,
                    color: Color(0xFF989898),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: Color(0xff789CD2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height,
        size.width,
        size.height * 0.5,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF789CD2)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(
          size.width / 4, size.height * 0.8, size.width / 2, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 3 / 4, size.height * 0.4, size.width, size.height * 0.6)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;
}
