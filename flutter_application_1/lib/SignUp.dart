import 'package:flutter/material.dart';

import 'Home.dart';
import 'SignIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey, //Color(0xFF4675C0),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          Container(
            height: 350,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: Color(0xFF4675C0),
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
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
              'Sign Up',
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
            top: 167,
            child: Container(
              width: 288,
              height: 407,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF4675C0),
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
                      controller: _fullnameController,
                      decoration: InputDecoration(
                        hintText: 'Full name',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 77, 129, 211),
                              width: 2),
                        ),
                        prefixIcon:
                            Icon(Icons.person, color: Color(0xFF989898)),
                        // Set the color of the text entered in the TextField
                        // to blue (you can replace blue with any color of your choice)
                        labelStyle: TextStyle(color: Color(0xFF4675C0)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: '0000000000',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 1),
                        ),
                        prefixIcon: Icon(Icons.phone, color: Color(0xFF989898)),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '*********',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 1),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF989898)),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _confirmpasswordController,
                      decoration: InputDecoration(
                        hintText: '*********',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 1),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF989898)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            width: 157,
            height: 60,
            left: 117,
            top: 537,
            child: ElevatedButton(
              onPressed: () {},
              child: Container(
                width: 112,
                height: 34,
                alignment: Alignment.center,
                child: Text(
                  'Sign Up',
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
                primary: Color(0xFF4675C0),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Color(0xFF4675C0),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 300),
              painter: WavePainter(),
            ),
          ),
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
      ..color = Color(0xFF4675C0)
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
