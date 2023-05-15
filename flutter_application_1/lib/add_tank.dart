import 'package:fluid/live_level.dart';
import 'package:flutter/material.dart'; //imports dart

import 'package:shared_preferences/shared_preferences.dart';

bool isCylinder = false;
final TextEditingController _tankNumberController = TextEditingController();
final TextEditingController _tankWidthController = TextEditingController();
final TextEditingController _tankHeightController = TextEditingController();
final TextEditingController _tankLengthController = TextEditingController();

class Tank {
  String tankId = "001";
  bool isCylinder = false;
  String width = "0";
  String height = "0";
  String length = "0";
  String baseD = "0";

  // Method to save the tank data to shared preferences
  Future<void> saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('_isCylinder', isCylinder);
    await prefs.setString('_width', width);
    await prefs.setString('_height', height);
    await prefs.setString('_length', length);
    await prefs.setString('_baseD', baseD);
  }

  // Method to load the tank data from shared preferences
  Future<void> loadFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isCylinder = prefs.getBool('_isCylinder') ?? false;
    width = prefs.getString('_width') ?? width;
    height = prefs.getString('_height') ?? height;
    length = prefs.getString('_length') ?? length;
    baseD = prefs.getString('_baseD') ?? baseD;
  }
}

class TankInformation extends StatefulWidget {
  const TankInformation({super.key});

  @override
  _TankInformationState createState() => _TankInformationState();
}

class _TankInformationState extends State<TankInformation> {
  final Color primaryColor = const Color(0xFF21457D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFBBD0EA),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Tank Information',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 35.16,
                    color: Color(0xff1a2a3a),
                  ),
                ),
                const SizedBox(height: 40),
                const SizedBox(
                  width: 400,
                  height: 20,
                  child: Center(
                    child: Text(
                      softWrap: true,
                      'Enter the information relative to your tank',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 288,
                  height: 365,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF789CD2),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: _tankNumberController,
                          decoration: const InputDecoration(
                            hintText: 'Tank number',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9FA5C0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            prefixIcon:
                                Icon(Icons.water, color: Color(0xFF989898)),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: _tankHeightController,
                          decoration: const InputDecoration(
                            hintText: 'Tank height',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9FA5C0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            prefixIcon:
                                Icon(Icons.water, color: Color(0xFF989898)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _tankWidthController,
                          decoration: const InputDecoration(
                            hintText: 'Base width',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9FA5C0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            prefixIcon:
                                Icon(Icons.water, color: Color(0xFF989898)),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _tankLengthController,
                          decoration: const InputDecoration(
                            hintText: 'Base length ',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9FA5C0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            prefixIcon:
                                Icon(Icons.water, color: Color(0xFF989898)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 600,
            right: 120,
            width: 157,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Tank tank = Tank();
                tank.height = _tankHeightController.text;
                tank.isCylinder = false;
                tank.width = _tankWidthController.text;
                tank.length = _tankLengthController.text;
                tank.tankId = _tankNumberController.text;
                tank.saveToSharedPreferences();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LiveLevelPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF789CD2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: const Color(0xFF789CD2),
              ),
              child: Container(
                width: 112,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TankInformationCylinder extends StatefulWidget {
  const TankInformationCylinder({super.key});

  @override
  _TankInformationCylinderState createState() =>
      _TankInformationCylinderState();
}

class _TankInformationCylinderState extends State<TankInformationCylinder> {
  final Color primaryColor = const Color(0xFF21457D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFBBD0EA),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Add a tank',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 35.16,
                    color: Color(0xff1a2a3a),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 400,
                  height: 20,
                  child: Center(
                    child: Text(
                      softWrap: true,
                      'Enter the information relative to your tank',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: 288,
                  height: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF789CD2),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: _tankNumberController,
                          decoration: const InputDecoration(
                            hintText: 'Tank number',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9FA5C0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            prefixIcon:
                                Icon(Icons.water, color: Color(0xFF989898)),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: _tankHeightController,
                          decoration: const InputDecoration(
                            hintText: 'Tank height',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9FA5C0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            prefixIcon:
                                Icon(Icons.water, color: Color(0xFF989898)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _tankWidthController,
                          decoration: const InputDecoration(
                            hintText: 'Base diameter',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF9FA5C0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF789CD2), width: 1),
                            ),
                            prefixIcon:
                                Icon(Icons.water, color: Color(0xFF989898)),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 570,
            right: 120,
            width: 157,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Tank tank = Tank();
                tank.height = _tankHeightController.text;
                tank.isCylinder = true;
                tank.baseD = _tankWidthController.text;

                tank.saveToSharedPreferences();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LiveLevelPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF789CD2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: const Color(0xFF789CD2),
              ),
              child: Container(
                width: 112,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TankShapePage extends StatefulWidget {
  const TankShapePage({super.key});

  @override
  _TankShapePageState createState() => _TankShapePageState();
}

class _TankShapePageState extends State<TankShapePage> {
  final Color primaryColor = const Color(0xFF21457D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFBBD0EA),
            child: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.2,
                  top: 50,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Add a tank',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 35.16,
                        color: Color(0xff1a2a3a),
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Select the shape of the tank',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        isCylinder = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TankInformationCylinder()),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF789CD2),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: const [
                            SizedBox(height: 60),
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: Image(
                                image: AssetImage('assets/cylinder.png'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text("Cylinder"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    GestureDetector(
                      onTap: () {
                        isCylinder = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TankInformation()),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF789CD2),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: const [
                            SizedBox(height: 60),
                            SizedBox(
                              width: 70,
                              height: 60,
                              child: Image(
                                image: AssetImage('assets/cuboidshape.png'),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text("Cuboid"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
