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
  final Key key;

  WaterLevelChart(
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
        'MRYbOmaiLDqsc2yCPN39KUxmnSdhQGzQ_X4-hn3PVOd-us1QlkeOCQYw_0ROCt34Y5D-IhOGRXkO4PGS7MEK-Q==';
    var bucket = 'tanks';
    var org = 'Esi';
    var client = InfluxDBClient(
        url: 'http://192.168.139.102:8086',
        token: token,
        org: org,
        bucket: bucket);
    var fluxQuery = '''from(bucket: "tanks")
  |> range(start: -${widget.rangeStart.inHours}h)
  |> filter(fn: (r) => r["_measurement"] == "water_level")
  |> filter(fn: (r) => r["_field"] == "value")
  |> filter(fn: (r) => r["sensor"] == "${widget.sensorID}")
  |> aggregateWindow(every: 1400s, fn: mean, createEmpty: false)
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 6,
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
                      title: AxisTitle(
                        text: 'Level (cm)',
                        textStyle: TextStyle(fontSize: 8),
                      ),
                    ),
                    series: <ChartSeries>[
                      SplineSeries<WaterLevelData, DateTime>(
                        dataSource: snapshot.data!,
                        xValueMapper: (datum, _) => datum.time,
                        yValueMapper: (datum, _) => datum.value,
                        cardinalSplineTension: 0.2,
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
      ),
    );
  }
}
