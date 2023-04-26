import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CircleWaveWidget extends StatelessWidget {
  final double waveAmplitude;
  final double waveFrequency;
  final double circleSize;
  final Color waveColor;

  const CircleWaveWidget({
    Key? key,
    this.waveAmplitude = 10.0,
    this.waveFrequency = 1.25,
    this.circleSize = 200,
    this.waveColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipOval(
        child: WaveWidget(
          config: CustomConfig(
            colors: [waveColor.withOpacity(0.7)],
            durations: [5000],
            heightPercentages: [0.7],
            blur: MaskFilter.blur(BlurStyle.solid, 10),
          ),
          waveAmplitude: waveAmplitude,
          waveFrequency: waveFrequency,
          size: Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}
