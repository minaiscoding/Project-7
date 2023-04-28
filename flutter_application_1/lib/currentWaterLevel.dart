import 'dart:async';
import 'package:flutter/material.dart';
import 'package:influxdb_client/api.dart';
import 'package:http/http.dart' as http;

class WaterLevelBucket extends StatefulWidget {
  final String sensorId;

  const WaterLevelBucket({Key? key, required this.sensorId}) : super(key: key);

  @override
  _WaterLevelBucketState createState() => _WaterLevelBucketState();
}

class _WaterLevelBucketState extends State<WaterLevelBucket> {
  double _waterLevel = 0.0;

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
        width: 100,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: (_waterLevel / 100) * 180,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '${_waterLevel.toStringAsFixed(1)} cm',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
