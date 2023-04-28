import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:http/http.dart' as http;

class WaterLevelBucket extends StatefulWidget {
  final String sensorId;

  const WaterLevelBucket({Key? key, required this.sensorId}) : super(key: key);

  @override
  _WaterLevelBucketState createState() => _WaterLevelBucketState();
}

class _WaterLevelBucketState extends State<WaterLevelBucket> {
  double _waterLevel = 4.0;

  @override
  void initState() {
    super.initState();
    _fetchData();
    Timer.periodic(Duration(seconds: 5), (Timer t) => _fetchData());
  }

  Future<void> _fetchData() async {
    var url =
        'http://192.168.167.102:5000'; // Replace with your API endpoint URL

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var value = double.tryParse(response.body);
        if (value != null) {
          setState(() {
            _waterLevel = value;
          });
        } else {
          print('Failed to parse the response body as a double.');
        }
      } else {
        print('HTTP request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred during the HTTP request: $e');
    }
  }

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        child: LiquidCircularProgressIndicator(
          value: _waterLevel /
              100, // Specify the progress value between 0.0 and 1.0
          valueColor: AlwaysStoppedAnimation(
              Colors.blue), // Color of the progress indicator
          backgroundColor: Colors.grey[200], // Color of the background
          borderColor: Colors.blue, // Color of the border
          borderWidth: 5.0, // Width of the border
          direction: Axis
              .vertical, // Progress direction (Axis.vertical or Axis.horizontal)
          center: Text(
            '${_waterLevel.toStringAsFixed(1)} cm',
            style: TextStyle(fontSize: 16),
          ), // Text displayed at the center of the indicator
        ),
      ),
    );
  }
}
