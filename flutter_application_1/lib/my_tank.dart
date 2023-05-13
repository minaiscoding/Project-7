import 'package:flutter/material.dart';
import 'live_level.dart';
import 'add_tank.dart';

class TankPage extends StatefulWidget {
  const TankPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TankPageState createState() => _TankPageState();
}

bool _isMenuOpen = false;

class _TankPageState extends State<TankPage> {
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
              top: 250,
              left: 50,
              right: 50,
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My tank',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        )),
                    Text(
                      tank.isCylinder ? 'Shape: Cylinder' : 'Shape: Cuboid',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Height: ${tank.height} cm',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      tank.isCylinder
                          ? 'Base diameter: ${tank.baseD} cm'
                          : 'Width: ${tank.width} cm',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      tank.isCylinder ? '' : 'Length: ${tank.length} cm',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TankShapePage()),
                    );
                  },
                  child: const Text('Edit Tank Info'),
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
