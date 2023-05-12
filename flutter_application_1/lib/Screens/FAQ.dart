import 'package:fluid/Screens/main.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'sign_up.dart';
import '../Widgets/page_view_demo.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffBBD0EA), //Color(0xFF789CD2),
      body: Stack(
        children: [
          Positioned(
            //left: MediaQuery.of(context).size.width * 0.0709,
            right: MediaQuery.of(context).size.width * 0.86,
            top: MediaQuery.of(context).size.height * 0.05,
            // bottom: MediaQuery.of(context).size.height * 0.90,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageViewDemo()));
              },
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xff1A2A3A),
                size: 40,
              ),
            ),
          ),
          Positioned(
            top: 103,
            right: 31,
            child: Container(
              width: 328,
              height: 715,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
