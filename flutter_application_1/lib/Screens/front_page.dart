import 'package:flutter/material.dart'; //imports dart
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff5fdff), Color(0xff4675C0)])),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        //
        body: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.19,
              left: MediaQuery.of(context).size.width * 0.39,
              child: DropShadowImage(
                image: Image.asset('assets/HomeLogo.png'),
                borderRadius: 15,
                offset: Offset(0, 4.10895),
                blurRadius: 13.655,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.32,
              left: MediaQuery.of(context).size.width * 0.36,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          color: const Color(0xff21457DBF).withOpacity(1),
                          // offset: const Offset(15, 15),
                          blurRadius: 40)
                    ],
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff1a2a3a),
                    fontSize: 37,
                    fontFamily: 'aquire',
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: 'FL'),
                    TextSpan(
                        text: 'U', style: TextStyle(color: Color(0xff1D9FC9))),
                    TextSpan(text: 'ID'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              right: MediaQuery.of(context).size.width * 0.12,
              width: MediaQuery.of(context).size.width * 0.75,
              child: const Text(
                'Don’t let a low water level catch you by surprise.',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  color: Color(0xff1a2a3a),
                  fontSize: 18,
                ),
              ),
            ),
            WaveWidget(
              //user Stack() widget to overlap content and waves
              config: CustomConfig(
                colors: [
                  const Color(0xfff5fdff).withOpacity(0.43),
                  const Color(0xff1D9FC9).withOpacity(0.4),
                  const Color.fromARGB(255, 9, 41, 105).withOpacity(0.5),
                ],
                durations: [7000, 8000, 10000],
                //durations of animations for each colors,
                // make numbers equal to numbers of colors
                heightPercentages: [0.75, 0.77, 0.85],
                //height percentage for each colors.
                blur: const MaskFilter.blur(BlurStyle.solid, 5),
                //blur intensity for waves
              ),
              waveAmplitude:
                  MediaQuery.of(context).size.height * 0.04, //depth of curves
              waveFrequency: 1.25, //number of curves in waves
              size: const Size(
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
