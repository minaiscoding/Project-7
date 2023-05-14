import 'dart:async';
import 'dart:math';
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
  late double _waterLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _waterLevel = 0.0;
    lastUpdateTime = getLastUpdatedTime();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getWaterLevelData();
  }

  late String tank_shape = "";
  late double tank_width, tank_height, tank_length, tank_baseDiameter = 0;
  Future<void> tankInformation() async {
    var token =
        '8jtFDtDrQpDKrjceYg8ZKAyRL90Muwa1H0xm1dGsyNKPEbNUnG-Oz4t5XILOJAf2nZAu9lZIxZMfgvUuxOvY1g==';
    var bucket = 'UserData';
    var org = 'Fluid';
    var client = InfluxDBClient(
        url: 'https://us-east-1-1.aws.cloud2.influxdata.com',
        token: token,
        org: org,
        bucket: bucket);
    var fluxQuery = '''from(bucket: "UserData")
    |> range(start: -1m)
    |> filter(fn: (r) => r["_measurement"] == "tanks")
    |> filter(fn: (r) => r["tank_number"] == "${widget.sensorId}")
    |> last()
    |> yield(name: "mean")''';
    var queryService = client.getQueryService();
    var result = await queryService.query(fluxQuery);
    await for (var record in result) {
      if (record.containsKey('_field') &&
          record.containsKey('_value') &&
          record['_field'] == 'tank_shape') {
        tank_shape = record['_value'] as String;
      }
      if (record.containsKey('_field') &&
          record.containsKey('_value') &&
          record['_field'] == 'tank_width') {
        tank_width = record['_value'] as double;
      }
      if (record.containsKey('_field') &&
          record.containsKey('_value') &&
          record['_field'] == 'tank_height') {
        tank_height = record['_value'] as double;
      }
      if (record.containsKey('_field') &&
          record.containsKey('_value') &&
          record['_field'] == 'tank_length') {
        tank_length = record['_value'] as double;
      }
      if (record.containsKey('_field') &&
          record.containsKey('_value') &&
          record['_field'] == 'tank_baseDiameter') {
        tank_baseDiameter = record['_value'] as double;
      }
    }
  }

  Future<void> getWaterLevelData() async {
    var token =
        '8jtFDtDrQpDKrjceYg8ZKAyRL90Muwa1H0xm1dGsyNKPEbNUnG-Oz4t5XILOJAf2nZAu9lZIxZMfgvUuxOvY1g==';
    var bucket = 'LevelData';
    var org = 'Fluid';
    var client = InfluxDBClient(
        url: 'https://us-east-1-1.aws.cloud2.influxdata.com',
        token: token,
        org: org,
        bucket: bucket);
    var fluxQuery = '''from(bucket: "LevelData")
    |> range(start: -1m)
    |> filter(fn: (r) => r["_measurement"] == "water_level")
    |> filter(fn: (r) => r["_field"] == "value")
    |> filter(fn: (r) => r["sensor"] == "${widget.sensorId}")
    |> aggregateWindow(every: 5s, fn: mean)
    |> yield(name: "mean")''';
    var queryService = client.getQueryService();

    var recordStream = await queryService.query(fluxQuery);
    var data = <double>[];
    await recordStream.forEach((record) {
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
    updateVolume(_waterLevel);
    updateLastUpdateTime();
  }

  late _WaterLevelBucketState dataFetcher;
  String getLastUpdatedTime() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }

  late String lastUpdateTime;
  late double waterVolumeLeft = 0.0;

  void updateLastUpdateTime() {
    setState(() {
      lastUpdateTime = getLastUpdatedTime();
    });
  }

  void updateVolume(double waterLevel) {
    setState(() {
      if (tank_shape == "Cuboid") {
        waterVolumeLeft = tank_height * tank_width * tank_length -
            tank_width * tank_length * waterLevel;
      } else {
        waterVolumeLeft =
            pi * tank_baseDiameter * tank_baseDiameter * (1 / 4) * tank_height;
      }
    });
  }

  Widget _buildGetDataButton() {
    return ElevatedButton(
      onPressed: () {
        tankInformation();
        getWaterLevelData();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 2, 40, 78),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text(
        'Update',
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            child: LiquidCircularProgressIndicator(
              value: _waterLevel / 100,
              valueColor: const AlwaysStoppedAnimation(
                  Color.fromARGB(123, 96, 167, 255)),
              backgroundColor: const Color.fromARGB(0, 255, 255, 255),
              borderColor: Colors.white,
              borderWidth: 1,
              direction: Axis.vertical,
              center: Text(
                '${_waterLevel.toStringAsFixed(1)} %',
                style: const TextStyle(
                  fontSize: 56,
                  fontFamily: "Aquire",
                  color: Color.fromARGB(255, 2, 40, 78),
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Last update: $lastUpdateTime',
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            'Water volume left: $waterVolumeLeft',
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          _buildGetDataButton(),
        ],
      ),
    );
  }
}
