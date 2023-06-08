import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'login_page.dart';
import '../Widgets/page_view_demo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'live_history_page.dart';

Future<void> storePhoneNumberAndSignInStatus(
    String phoneNumber, bool isSignedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('phone_number', phoneNumber);
  await prefs.setBool('is_signed_in', isSignedIn);
}

Future<Map<String, dynamic>> retrievePhoneNumberAndSignInStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String phoneNumber = prefs.getString('phone_number') ?? "0";
  bool isSignedIn = prefs.getBool('is_signed_in') ?? false;
  return {'phone_number': phoneNumber, 'is_signed_in': isSignedIn};
}

final TextEditingController _fullnameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _tankNumberController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmpasswordController =
    TextEditingController();
final TextEditingController _tankWidthController = TextEditingController();
final TextEditingController _tankHeightController = TextEditingController();
final TextEditingController _tankLengthController = TextEditingController();
bool isCylinder = false;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<void> _submitSignUpForm() async {
    const String apiUrl = "https://featherlessbird.pythonanywhere.com/signup";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'full_name': _fullnameController.text,
        'phone_number': _phoneNumberController.text,
        'tank_number': "'${_tankNumberController.text.padLeft(3, '0')}'",
        'password': _passwordController.text,
        'confirm_password': _confirmpasswordController.text,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // save  the user on phone
      storePhoneNumberAndSignInStatus(_phoneNumberController.text, true);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TankShapePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("An error occurred!"),
          content: Text(responseData['error']),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Okay"),
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
            height: MediaQuery.of(context).size.height * 0.6,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: const Color(0xFF789CD2),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.86,
            top: MediaQuery.of(context).size.height * 0.1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageViewDemo()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.2,
            top: MediaQuery.of(context).size.width * 0.15,
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 50.16,
                color: Colors.white,
                height: 1.2,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.13,
            top: MediaQuery.of(context).size.height * 0.19,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.74,
              height: MediaQuery.of(context).size.height * 0.525,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
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
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _fullnameController,
                      decoration: const InputDecoration(
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
                      height: MediaQuery.of(context).size.width * 0.053,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _tankNumberController,
                      decoration: const InputDecoration(
                        hintText: 'Tank number',
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
                      height: MediaQuery.of(context).size.width * 0.053,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.053,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
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
            left: MediaQuery.of(context).size.width * 0.18,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text.rich(
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
            width: MediaQuery.of(context).size.width * 0.38,
            height: 60,
            left: MediaQuery.of(context).size.width * 0.3,
            top: MediaQuery.of(context).size.height * 0.68,
            child: ElevatedButton(
              onPressed: () {
                _submitSignUpForm();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF789CD2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Color(0xFF789CD2),
              ),
              child: const Text(
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
  const TankInformation({super.key});

  @override
  _TankInformationState createState() => _TankInformationState();
}

class _TankInformationState extends State<TankInformation> {
  final Color primaryColor = const Color(0xFF21457D);
  Future<void> _submitTankCuboidForm() async {
    final String apiUrl =
        "https://featherlessbird.pythonanywhere.com/add_tank_cuboid";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tank_number': "'${_tankNumberController.text.padLeft(3, '0')}'",
        'tank_height': _tankHeightController.text,
        'base_width': _tankWidthController.text,
        'base_length': _tankLengthController.text,
      }),
    );
    String tankNumber = "'${_tankNumberController.text.padLeft(3, '0')}'";
    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // Tank information submission successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LiveHistoryPage(tankNumber)),
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
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xFFBBD0EA),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Text(
                    'Add a tank',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 35.16,
                      color: const Color(0xff1a2a3a),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 20,
                    child: const Center(
                      child: Text(
                        softWrap: true,
                        'Enter the information relative to your tank',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
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
                        top: MediaQuery.of(context).size.height * 0.04,
                        left: MediaQuery.of(context).size.width * 0.08,
                        right: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            keyboardType: TextInputType.phone,
                            controller: _tankNumberController,
                            decoration: const InputDecoration(
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.08),
                          TextField(
                            keyboardType: TextInputType.phone,
                            controller: _tankHeightController,
                            decoration: const InputDecoration(
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.08),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: _tankWidthController,
                            decoration: const InputDecoration(
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.08),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: _tankLengthController,
                            decoration: const InputDecoration(
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
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              right: MediaQuery.of(context).size.width * 0.295,
              width: MediaQuery.of(context).size.width * 0.41,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _submitTankCuboidForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF789CD2),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: const Color(0xFF789CD2),
                ),
                child: const Text(
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
            ),
          ],
        ),
      ),
    );
  }
}

class TankInformationCylinder extends StatefulWidget {
  const TankInformationCylinder({super.key});

  @override
  _TankInformationCylinderState createState() =>
      _TankInformationCylinderState();
}

class _TankInformationCylinderState extends State<TankInformationCylinder> {
  final Color primaryColor = const Color(0xFF21457D);

  Future<void> _submitTankCylinderForm() async {
    final String apiUrl =
        "https://featherlessbird.pythonanywhere.com/add_tank_cylinder";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tank_number': "'${_tankNumberController.text.padLeft(3, '0')}'",
        'tank_height': _tankHeightController.text,
        'tank_width': _tankWidthController.text,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // Navigate to the home page after successful signup
      String tankNumber = "'${_tankNumberController.text.padLeft(3, '0')}'";
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LiveHistoryPage(tankNumber)),
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
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xFFBBD0EA),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  const Text(
                    'Add a tank',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 35.16,
                      color: const Color(0xff1a2a3a),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 20,
                    child: const Center(
                      child: Text(
                        softWrap: true,
                        'Enter the information relative to your tank',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
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
                        top: MediaQuery.of(context).size.height * 0.04,
                        left: MediaQuery.of(context).size.width * 0.08,
                        right: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            keyboardType: TextInputType.phone,
                            controller: _tankNumberController,
                            decoration: const InputDecoration(
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.08),
                          TextField(
                            keyboardType: TextInputType.phone,
                            controller: _tankHeightController,
                            decoration: const InputDecoration(
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.08),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: _tankWidthController,
                            decoration: const InputDecoration(
                              hintText: 'Base diameter',
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.08),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.62,
              right: MediaQuery.of(context).size.width * 0.295,
              width: MediaQuery.of(context).size.width * 0.41,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _submitTankCylinderForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF789CD2),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: const Color(0xFF789CD2),
                ),
                child: const Text(
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
            ),
          ],
        ),
      ),
    );
  }
}

class TankShapePage extends StatefulWidget {
  const TankShapePage({super.key});

  @override
  _TankShapePageState createState() => _TankShapePageState();
}

class _TankShapePageState extends State<TankShapePage> {
  final Color primaryColor = const Color(0xFF21457D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFBBD0EA),
            child: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.2,
                  top: MediaQuery.of(context).size.height * 0.11,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Add a tank',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 35.16,
                        color: Color(0xff1a2a3a),
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Select the shape of the tank',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                    GestureDetector(
                      onTap: () {
                        isCylinder = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TankInformationCylinder()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.53,
                        height: MediaQuery.of(context).size.width * 0.53,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF789CD2),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.07,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Image(
                                image: AssetImage('assets/cylinder.png'),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            const Text("Cylinder"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        isCylinder = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TankInformation()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.53,
                        height: MediaQuery.of(context).size.width * 0.53,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF789CD2),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.07,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Image(
                                image: AssetImage('assets/cuboidshape.png'),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            const Text("Cuboid"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
