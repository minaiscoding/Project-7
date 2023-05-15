import 'package:fluid/add_tank.dart';
import 'package:fluid/my_tank.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:http/http.dart' as http;
//import 'Menu.dart';

Tank tank = Tank();
bool _isMenuOpen = false;

class LiveLevelPage extends StatefulWidget {
  const LiveLevelPage({super.key});

  @override
  _LiveLevelPageState createState() => _LiveLevelPageState();
}

class _LiveLevelPageState extends State<LiveLevelPage> {
  String lastUpdateTime = '';
  late WaterLevelFetcher dataFetcher;

  @override
  void initState() {
    super.initState();
    dataFetcher = WaterLevelFetcher('001');
    _initializeData();
  }

  Future<void> _initializeData() async {
    Tank tanko = Tank();
    await tanko.loadFromSharedPreferences();

    setState(() {
      tank = tanko;
    });
  }

  void _openMenu() {
    setState(() {
      _isMenuOpen = true;
    });
  }

  void _closeMenu() {
    setState(() {
      _isMenuOpen = false;
    });
  }

  final Color primaryColor = const Color(0xFF21457D);

  String getLastUpdatedTime() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }

  void updateLastUpdateTime() {
    setState(() {
      lastUpdateTime = getLastUpdatedTime();
    });
  }

  void fetchDataAndUpdate() async {
    await dataFetcher.fetchData();
    updateLastUpdateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 41, 99),
              Color.fromARGB(255, 84, 133, 194),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
            Positioned(
              left: 25,
              top: 60,
              child: Image.asset(
                'assets/logo_white.png',
                width: 70,
                height: 70,
              ),
            ),
            Positioned(
              right: 25,
              top: 70,
              child: GestureDetector(
                onTapDown: (details) {
                  _openMenu();
                },
                child: const Icon(Icons.menu, size: 32, color: Colors.white),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.709,
                child: _buildLive(),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: _buildGetDataButton(),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.37,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                tank.isCylinder
                    ? '${((double.parse(tank.height) - dataFetcher.waterLevel * 0.1) * double.parse(tank.baseD) * double.parse(tank.baseD) / 4 * 0.00314).toStringAsFixed(2)} L'
                    : '${((double.parse(tank.height) - dataFetcher.waterLevel * 0.1) * double.parse(tank.length) * double.parse(tank.width) * 0.001).toStringAsFixed(2)} L',
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Aquire', fontSize: 35),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.19,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                'Last updated: $lastUpdateTime',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            Visibility(
              visible: _isMenuOpen,
              child: Stack(
                children: <Widget>[
                  const Menu(),
                  Positioned(
                    top: 150,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 40,
                      color: const Color(0xFF21457D),
                      onPressed: () {
                        setState(() {
                          _closeMenu();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLive() {
    return WaterLevelBucket(
      dataFetcher: dataFetcher,
    );
  }

  Widget _buildGetDataButton() {
    return ElevatedButton(
      onPressed: () {
        fetchDataAndUpdate();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(
          221,
          96,
          167,
          255,
        ),
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
}

class WaterLevelFetcher {
  final String sensorId;
  double waterLevel = 0.0;

  WaterLevelFetcher(this.sensorId);

  Future<void> fetchData() async {
    var url =
        'https://minaree.pythonanywhere.com/'; // Replace with your API endpoint URL

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var value = double.tryParse(response.body);
        if (value != null) {
          waterLevel = value;
        }
      }
    } catch (e) {
      //
    }
  }
}

class WaterLevelBucket extends StatefulWidget {
  final WaterLevelFetcher dataFetcher;

  const WaterLevelBucket({Key? key, required this.dataFetcher})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WaterLevelBucketState createState() => _WaterLevelBucketState();
}

class _WaterLevelBucketState extends State<WaterLevelBucket> {
  @override
  void initState() {
    super.initState();
    widget.dataFetcher.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.7,
        child: LiquidCircularProgressIndicator(
          value: ((double.parse(tank.height) -
                  widget.dataFetcher.waterLevel * 0.1) /
              double.parse(tank.height)),
          valueColor:
              const AlwaysStoppedAnimation(Color.fromARGB(123, 96, 167, 255)),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          borderColor: Colors.white,
          borderWidth: 1,
          direction: Axis.vertical,
          center: Text(
            '${((double.parse(tank.height) - widget.dataFetcher.waterLevel * 0.1) * 100 / double.parse(tank.height)).toStringAsFixed(2)} %',
            style: const TextStyle(
              fontSize: 56,
              fontFamily: "Aquire",
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 24,
      height: 1,
      color: Colors.white,
    );
    const elevation = 8.0;
    const backgroundColor = Color(0xFF21457D);
    final boxShadow = [
      const BoxShadow(
        color: Color.fromRGBO(101, 160, 255, 0.5),
        offset: Offset(0, 8),
        blurRadius: 30,
      ),
    ];
    final borderRadius = BorderRadius.circular(30);

    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(59, 142, 0, 0),
          width: 273,
          height: 334,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromRGBO(26, 42, 58, 0.25),
              width: 1,
            ),
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(33),
          ),
          child: Column(
            children: [
              const SizedBox(height: 90),
              ElevatedButton(
                onPressed: () {
                  _isMenuOpen = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LiveLevelPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  elevation: elevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  shadowColor: const Color(0xFF21457D),
                ),
                child: Container(
                  width: 121,
                  height: 56,
                  alignment: Alignment.center,
                  child: const Text(
                    'Home',
                    style: textStyle,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  _isMenuOpen = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TankPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  shadowColor: const Color(0xFF21457D),
                ),
                child: Container(
                  width: 121,
                  height: 56,
                  alignment: Alignment.center,
                  child: Text(
                    'My tank',
                    style: textStyle.copyWith(
                      color: const Color(0xFF21457D),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ],
    );
  }
}
