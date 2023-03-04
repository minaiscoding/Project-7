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
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(MediaQuery.of(context).size.width * 2),
                bottomRight:
                    Radius.circular(MediaQuery.of(context).size.width * 2),
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
            left: 95,
            top: 72,
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 61,
                color: Colors.white,
                height: 1,
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
                  top: 60,
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
                          fontSize: 18,
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
                        labelStyle: TextStyle(color: Colors.blue),
                      ),
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
                          fontSize: 18,
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
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '*********',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
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
                    SizedBox(height: 10),
                    TextField(
                      controller: _confirmpasswordController,
                      decoration: InputDecoration(
                        hintText: '*********',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
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
            height: 75,
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
                    fontSize: 28,
                    height: 1.2,
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
        ],
      ),
    );
  }
}
