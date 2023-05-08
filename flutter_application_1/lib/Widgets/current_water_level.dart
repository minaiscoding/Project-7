import 'dart:async';
import 'package:flutter/material.dart';
import 'package:influxdb_client/api.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class WaterLevelBucket extends StatefulWidget {
  final String sensorId;

  const WaterLevelBucket({Key? key, required this.sensorId}) : super(key: key);

  @override
  _WaterLevelBucketState createState() => _WaterLevelBucketState();
}

class _WaterLevelBucketState extends State<WaterLevelBucket> {
  late double _waterLevel = 4.0;

  @override
  void initState() {
    super.initState();
    _waterLevel = 4.0;
    lastUpdateTime = getLastUpdatedTime();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getWaterLevelData();
  }

  Future<void> getWaterLevelData() async {
    var token =
        'K8W7GQZR35OoD79-WpovZGtTxMJSvPkS-D0PjbbeFDUjsVwlPWxTtzQIatc0GkTe21ZXLtsgd8fD2P8ACH4Www==';
    var bucket = 'tanks';
    var org = 'esi';
    var client = InfluxDBClient(
        url: 'http://192.168.167.102:8086',
        token: token,
        org: org,
        bucket: bucket);
    var fluxQuery = '''from(bucket: "tanks")
    |> range(start: -1m)
    |> filter(fn: (r) => r["_measurement"] == "water_level")
    |> filter(fn: (r) => r["_field"] == "value")
    |> filter(fn: (r) => r["sensor"] == "'001'")
    |> aggregateWindow(every: 5s, fn: mean)
    |> yield(name: "mean")''';
    var queryService = client.getQueryService();

    var recordStream = await queryService.query(fluxQuery);
    var data = <double>[];
    await recordStream.forEach((record) {
      print(
          'record: ${record['_time']}: water level: ${record['_value']} ${record['sensor']}');
      var value = record['_value'];
      if (value != null) {
        data.add(value);
      }
    });

    if (mounted && data.isNotEmpty) {
      setState(() {
        _waterLevel = data.isNotEmpty ? data.last : _waterLevel;
      });
    }
    updateLastUpdateTime();
  }

  late _WaterLevelBucketState dataFetcher;
  String getLastUpdatedTime() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }

  late String lastUpdateTime;

  void updateLastUpdateTime() {
    setState(() {
      lastUpdateTime = getLastUpdatedTime();
    });
  }

  Widget _buildGetDataButton() {
    return ElevatedButton(
      onPressed: () {
        getWaterLevelData();
      },
      child: Text(
        'Update',
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 2, 40, 78),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            child: LiquidCircularProgressIndicator(
              value: _waterLevel / 100,
              valueColor:
                  AlwaysStoppedAnimation(Color.fromARGB(123, 96, 167, 255)),
              backgroundColor: Color.fromARGB(0, 255, 255, 255),
              borderColor: Colors.white,
              borderWidth: 1,
              direction: Axis.vertical,
              center: Text(
                '${_waterLevel.toStringAsFixed(1)} %',
                style: TextStyle(
                  fontSize: 56,
                  fontFamily: "Aquire",
                  color: Color.fromARGB(255, 2, 40, 78),
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Last update: $lastUpdateTime',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 50),
          _buildGetDataButton(),
        ],
      ),
    );
  }
}
