import 'package:flutter/material.dart'; //imports dart

//import 'package:flutter_svg/flutter_svg.dart';
void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png'),
        backgroundColor: Color(0xffddecf6),
      ),
      body: Container(
          decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/hex.jpg"),
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
