import 'package:flutter/material.dart';
 void main() => runApp(MaterialApp(
   home: Home()) );

 class Home extends StatelessWidget {
   @override
   Widget build(BuildContext buildContext){
     return Scaffold(
     appBar: AppBar(
     title: const Text(
      'cyrin',
            ),
centerTitle: true,
backgroundColor: Colors.blue,
),
body: Center(
child: Text("one is two"),

)
);


   }
 }