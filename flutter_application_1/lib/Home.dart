import 'package:flutter/material.dart'; //imports dart
import 'package:hexcolor/hexcolor.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class Home extends StatelessWidget {
  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff5fdff), Color(0xff4675C0)])),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        body: Stack(
          children: <Widget>[
            Positioned(
              width: 439.08,
              height: 312,
              top: 104,
              left: -25,
              child: DropShadowImage(
                image: Image.asset('assets/logo (1).png'),
                borderRadius: 15,
                //@blurRadius if not defined default value is
                blurRadius: 25,
                //@offset default value is Offset(8,8)
                //offset: Offset(5, 5),
                //@scale if not defined default value is 1
                // scale: 1.05,
              ),
            ),
            Positioned(
              width: 111,
              height: 36,
              top: 280,
              left: 142,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Color(0xff21457DBF).withOpacity(1),
                          // offset: const Offset(15, 15),
                          blurRadius: 40)
                    ],
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1a2a3a),
                    fontSize: 37,
                    fontFamily: 'aquire',
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'FL'),
                    TextSpan(
                        text: 'U', style: TextStyle(color: Color(0xff1D9FC9))),
                    TextSpan(text: 'ID'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 376,
              right: 53,
              width: 275,
              height: 72,
              child: Text(
                'Lorem ipsum dolor sit amet',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            WaveWidget(
              //user Stack() widget to overlap content and waves
              config: CustomConfig(
                colors: [
                  Color(0xfff5fdff).withOpacity(0.43),
                  Color(0xff1D9FC9).withOpacity(0.4),
                  // Color.fromARGB(255, 60, 87, 207).withOpacity(0.2),
                  Color.fromARGB(255, 9, 41, 105).withOpacity(0.5),
                ],
                durations: [4000, 5000, 7000],
                //durations of animations for each colors,
                // make numbers equal to numbers of colors
                heightPercentages: [0.75, 0.77, 0.85],
                //height percentage for each colors.
                blur: MaskFilter.blur(BlurStyle.solid, 5),
                //blur intensity for waves
              ),
              waveAmplitude: 35.00, //depth of curves
              waveFrequency: 1.25, //number of curves in waves
              size: Size(
                double.infinity,
                double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
