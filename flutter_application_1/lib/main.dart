import 'package:flutter/material.dart'; //imports dart

//import 'package:flutter_svg/flutter_svg.dart';
void main() => runApp(MaterialApp(
    title: 'Fluid', theme: ThemeData(fontFamily: 'Montserrat'), home: Home()));

class Home extends StatelessWidget {
  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          alignment: Alignment.topLeft,
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("logo.png"), fit: BoxFit.cover),
          ),
        ),
        title: Image.asset(
          'assets/logo2.png',
          height: 100,
          width: 100,
        ),
        backgroundColor: Color(0xffddecf6),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/hex.jpg"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              top: 100,
              child: Text(
                'LOREM IPSUM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  //  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
            ),
            Positioned.fill(
                top: 190,
                child: Text(
                  'Lorem ipsum dolor sic mundus creatus est',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
