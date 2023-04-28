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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.7,
        child: LiquidCircularProgressIndicator(
          value: _waterLevel / 100,
          valueColor: AlwaysStoppedAnimation(Color.fromARGB(123, 96, 167, 255)),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          borderColor: Colors.white,
          borderWidth: 1,
          direction: Axis.vertical,
          center: Text(
            '${_waterLevel.toStringAsFixed(1)} %',
            style: TextStyle(
              fontSize: 56,
              fontFamily: "Monsstserrat",
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
    );
  }
}
