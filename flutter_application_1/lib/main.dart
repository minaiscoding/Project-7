import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';
import 'Home.dart';
import 'SignIn.dart';
import 'SignUp.dart';
import 'Preview.dart';
import 'Welcome.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false, //removes debugger banner from App
    title: 'Fluid',
    theme: ThemeData(fontFamily: 'Montserrat'),
    home: Home()));
