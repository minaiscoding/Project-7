import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21457D),
      body: Stack(
        children: [
          Positioned(
            left: 103,
            top: 179,
            child: Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 52,
                color: Colors.white,
                height: 1.2,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 342,
            child: Container(
              width: 390,
              height: 502,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 100,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Phone number',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1.2,
                        color: Color(0xFF4675C0),
                      ),
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: '0000000000',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 2),
                        ),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1.2,
                        color: Color(0xFF4675C0),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '* * * * * ',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xFF9FA5C0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF4675C0), width: 2),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF21457D),
                        shadowColor: Color(0xFF1A2A3A),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
