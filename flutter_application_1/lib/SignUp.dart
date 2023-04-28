import 'package:fluid/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Home.dart';
import 'SignIn.dart';

final TextEditingController _fullnameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _tankNumberController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmpasswordController =
    TextEditingController();
final TextEditingController _tankWidthController = TextEditingController();
final TextEditingController _tankHeightController = TextEditingController();
final TextEditingController _tankLengthController = TextEditingController();

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<void> _submitSignUpForm() async {
    final String apiUrl = "http://192.168.78.9:5000/signup";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'full_name': _fullnameController.text,
        'phone_number': _phoneNumberController.text,
        'tank_number': _tankNumberController.text,
        'password': _passwordController.text,
        'confirm_password': _confirmpasswordController.text,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // Navigate to the home page after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("An error occurred!"),
          content: Text(responseData['error']),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

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
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 60.16,
                color: Colors.white,
                height: 1.2,
              ),
            ),
          ),
          Positioned(
            left: 52,
            top: 160,
            child: Container(
              width: 288,
              height: 460,
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
                  top: 30,
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
                              BorderSide(color: Color(0xFF789CD2), width: 2),
                        ),
                        prefixIcon:
                            Icon(Icons.person, color: Color(0xFF989898)),
                        labelStyle: TextStyle(color: Color(0xFF789CD2)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _tankNumberController,
                      decoration: InputDecoration(
                        hintText: 'tank number',
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
                        prefixIcon: Icon(Icons.water, color: Color(0xFF989898)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                    SizedBox(height: 30),
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
                    TextField(
                      controller: _confirmpasswordController,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
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
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 200,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 200),
              painter: WavePainter(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 250,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 250),
              painter: CustomWavePainter(),
            ),
          ),
          Positioned(
            top: 670,
            left: 72,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
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
                      text: 'Sign in',
                      style: TextStyle(
                        color: Color(0xff789CD2),
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
            top: 590,
            child: ElevatedButton(
              onPressed: () {
                _submitSignUpForm();
              },
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
                primary: Color(0xFF789CD2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Color(0xFF789CD2),
              ),
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
      ..color = Color.fromRGBO(120, 156, 210, 0.5)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
          size.width / 5, size.height * 0.9, size.width / 2, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 3 / 4, size.height * 0.3, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;
}

class CustomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(120, 156, 210, 0.69)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width, size.height * 0.7)
      ..quadraticBezierTo(size.width * 3 / 4, size.height * 0.8, size.width / 2,
          size.height * 0.6)
      ..quadraticBezierTo(
          size.width / 4, size.height * 0.4, 0, size.height * 0.6)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomWavePainter oldDelegate) => false;
}

class TankInformation extends StatefulWidget {
  @override
  _TankInformationState createState() => _TankInformationState();
}

class _TankInformationState extends State<TankInformation> {
  final Color primaryColor = const Color(0xFF21457D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xFFBBD0EA),
              child: Stack(
                children: [
                  Positioned(
                    left: 25,
                    top: 50,
                    child: Image.asset(
                      'assets/SmallLogo.png',
                      width: 70, // Set width to 50 pixels
                      height: 70, // Set height to 50 pixels
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.2,
                    top: 100,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Add a tank',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 35.16,
                          color: const Color(0xff1a2a3a),
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 220,
                    left: 40,
                    child: Container(
                      width: 400,
                      height: 300,
                      child: Text(
                        softWrap: true,
                        'Enter the information relative to your tank',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 52,
                    top: 300,
                    child: Container(
                      width: 288,
                      height: 400,
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
                              controller: _tankNumberController,
                              decoration: InputDecoration(
                                hintText: 'Tank number',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xFF9FA5C0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                prefixIcon:
                                    Icon(Icons.water, color: Color(0xFF989898)),
                              ),
                            ),
                            SizedBox(height: 40),
                            TextField(
                              keyboardType: TextInputType.phone,
                              controller: _tankHeightController,
                              decoration: InputDecoration(
                                hintText: 'Tank height',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xFF9FA5C0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                prefixIcon:
                                    Icon(Icons.water, color: Color(0xFF989898)),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _tankWidthController,
                              decoration: InputDecoration(
                                hintText: 'Base width',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xFF9FA5C0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                prefixIcon:
                                    Icon(Icons.water, color: Color(0xFF989898)),
                              ),
                            ),
                            SizedBox(height: 40),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _tankLengthController,
                              decoration: InputDecoration(
                                hintText: 'Base length ',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xFF9FA5C0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF789CD2), width: 1),
                                ),
                                prefixIcon:
                                    Icon(Icons.water, color: Color(0xFF989898)),
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
                    top: 670,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        width: 112,
                        height: 34,
                        alignment: Alignment.center,
                        child: Text(
                          'Add tank',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
