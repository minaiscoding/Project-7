import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';
import 'Home.dart';
import 'SignIn.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false, //removes debugger banner from App
    title: 'Fluid',
    theme: ThemeData(
        fontFamily: 'Montserrat'), //set the font for the app to Aquire
    home: LoginPage()));
