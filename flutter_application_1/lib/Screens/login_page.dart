import 'package:fluid/Screens/live_history_page.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'dart:convert';
import 'package:influxdb_client/api.dart';
import 'package:http/http.dart' as http;
import '../Widgets/page_view_demo.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<String?> getTankNumber(String phoneNumber) async {
  var client = InfluxDBClient(
      url: 'https://us-east-1-1.aws.cloud2.influxdata.com',
      token:
          '8jtFDtDrQpDKrjceYg8ZKAyRL90Muwa1H0xm1dGsyNKPEbNUnG-Oz4t5XILOJAf2nZAu9lZIxZMfgvUuxOvY1g==',
      org: 'Fluid',
      bucket: 'UserData');

  // Construct the Flux query
  var fluxQuery = '''
    from(bucket: "UserData")
    |> range(start: -999999h)
    |> filter(fn: (r) => r["_measurement"] == "users1")
    |> filter(fn: (r) => r["phone_number"] == "$phoneNumber")
    |> last()
    |> yield(name: "mean")
  ''';

  // Execute the query and extract the tank_number field from the last record
  var result = await client.getQueryService().query(fluxQuery);

  await for (var record in result) {
    if (record.containsKey('_field') &&
        record.containsKey('_value') &&
        record['_field'] == 'tank_number') {
      return record['_value'] as String?;
    }
  }
  return null;
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<Map<String, dynamic>> _signIn(BuildContext context) async {
    const String apiUrl = "https://featherlessbird.pythonanywhere.com/signin";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone_number': _phoneNumberController.text,
        'password': _passwordController.text,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      String phoneNumber = _phoneNumberController.text;
      String? tankNumber = await getTankNumber(phoneNumber);
      storePhoneNumberAndSignInStatus(_phoneNumberController.text, true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LiveHistoryPage(tankNumber!)),
      );
      return {
        'signedIn': true,
        'tankNumber': tankNumber,
      };
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
      return {
        'signedIn': false,
        'tankNumber': '',
      };
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
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
              'Sign In',
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
              height: MediaQuery.of(context).size.width * 0.71,
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
                  top: MediaQuery.of(context).size.height * 0.07,
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.07,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        height: MediaQuery.of(context).size.height * 0.044),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 0.37,
            height: 60,
            left: MediaQuery.of(context).size.width * 0.315,
            top: MediaQuery.of(context).size.height * 0.47,
            child: ElevatedButton(
              onPressed: () async {
                final result = await _signIn(context);
                final bool signedIn = result['signedIn'];
                //final String tankNumber = result['tank_number'];
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
            top: MediaQuery.of(context).size.height * 0.65,
            left: MediaQuery.of(context).size.width * 0.19,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text.rich(
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
      ..color = const Color.fromRGBO(120, 156, 210, 0.5)
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
      ..color = const Color.fromRGBO(120, 156, 210, 0.69)
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
