import 'dart:async';
import 'package:flutter/material.dart';
import 'package:influxdb_client/api.dart';

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
      |> range(start: -5m)
      |> filter(fn: (r) => r["_measurement"] == "water_level")
      |> filter(fn: (r) => r["_field"] == "value")
      |> filter(fn: (r) => r["sensor"] == "${widget.sensorId}")
      |> last()
      |> yield(name: "value")''';
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

    if (data.isNotEmpty) {
      setState(() {
        _waterLevel = data[0];
      });
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
