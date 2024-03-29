// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:influxdb_client/api.dart';
import 'dart:async';

class WaterLevelData {
  final DateTime time;
  final double value;

  WaterLevelData(this.time, this.value);
}

class WaterLevelChart extends StatefulWidget {
  final Duration rangeStart;
  final String sensorID;
  @override
  final Key key;

  const WaterLevelChart(
      {required this.rangeStart, required this.sensorID, required this.key})
      : super(key: key);

  @override
  _WaterLevelChartState createState() => _WaterLevelChartState();
}

class _WaterLevelChartState extends State<WaterLevelChart> {
  late Stream<List<WaterLevelData>> _dataStream;
  List<WaterLevelData> _waterLevelData = [];

  @override
  void initState() {
    super.initState();
    _dataStream = _fetchData();
  }

  Stream<List<WaterLevelData>> _fetchData() async* {
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
  |> range(start: -${widget.rangeStart.inHours}h)
  |> filter(fn: (r) => r["_measurement"] == "water_level")
  |> filter(fn: (r) => r["_field"] == "value")
  |> filter(fn: (r) => r["sensor"] == "${widget.sensorID}")
  |> aggregateWindow(every: 5s, fn: mean, createEmpty: false)
  |> yield(name: "mean")''';
    var queryService = client.getQueryService();

    while (true) {
      var recordStream = await queryService.query(fluxQuery);
      var data = <WaterLevelData>[];
      await recordStream.forEach((record) {
        var value = record['_value'];
        if (value != null) {
          var waterLevelData = WaterLevelData(
            DateTime.parse(record['_time']),
            value,
          );
          data.add(waterLevelData);
        }
      });

      if (data.isNotEmpty) {
        _waterLevelData = data;
        yield data;
      }

      await Future.delayed(const Duration(seconds: 5));
      yield data;
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<WaterLevelData>>(
            stream: _dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value} cm',
                    labelStyle: const TextStyle(fontSize: 8),
                    title: AxisTitle(
                      text: 'Level (cm)',
                      textStyle: const TextStyle(fontSize: 8),
                    ),
                  ),
                  series: <ChartSeries>[
                    SplineSeries<WaterLevelData, DateTime>(
                      dataSource: snapshot.data!,
                      xValueMapper: (datum, _) => datum.time,
                      yValueMapper: (datum, _) => datum.value,
                      splineType: SplineType.clamped,
                      color: const Color.fromARGB(255, 2, 40, 78),
                      width: 1,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        color: Color.fromARGB(255, 34, 97, 160),
                        shape: DataMarkerType.circle,
                        borderWidth: 0,
                        height: 3,
                        width: 3,
                      ),
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: false,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(
                  child: Positioned(
                    child: Text(
                      'Loading graph',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
