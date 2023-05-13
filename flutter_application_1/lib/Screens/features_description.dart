import 'package:flutter/material.dart'; //imports dart

class Preview extends StatelessWidget {
  const Preview({Key? key}) : super(key: key);
  @override //redefinition of the build widget
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFF5FDFF),
            Color(0xFF4675C0),
          ],
          stops: [0.0185, 1.3432],
          transform: GradientRotation(180 * 3.14151617 / 180),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: MediaQuery.of(context).size.width * 0.125,
              top: MediaQuery.of(context).size.height * 0.08,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.923),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      const Color(0xFFFFFFFF),
                      const Color(0xFFDFECFF),
                      const Color(0xFFC3DBFF),
                      const Color(0x00C3DBFF).withOpacity(0.8),
                    ],
                    stops: const [0.0561, 0.2843, 0.8113, 1.4206],
                    transform: const GradientRotation(139.58 * 3.141516 / 180),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(101, 160, 255, 0.8),
                      blurRadius: 27.5785,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.001,
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Image(
                      image: const AssetImage('assets/percent.png'),
                      width: MediaQuery.of(context).size.width *
                          0.06, // set the width of the image
                      height: MediaQuery.of(context).size.width *
                          0.06, // set the height of the image
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.013,
                    ),
                    const Text('Water level',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1a2a3a),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: const Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          'provides the user with the water level in their tank through a visual representation, with great precision at any time.'),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.125,
              top: MediaQuery.of(context).size.height * 0.365,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.923),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      const Color(0xFFFFFFFF),
                      const Color(0xFFDFECFF),
                      const Color(0xFFC3DBFF),
                      const Color(0x00C3DBFF).withOpacity(0.8),
                    ],
                    stops: const [0.0561, 0.2843, 0.8113, 1.4206],
                    transform: const GradientRotation(139.58 * 3.141516 / 180),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(101, 160, 255, 0.8),
                      blurRadius: 27.5785,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.017,
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.014),
                    Image(
                      image: const AssetImage('assets/chart.png'),
                      width: MediaQuery.of(context).size.width *
                          0.08, // set the width of the image
                      height: MediaQuery.of(context).size.width *
                          0.08, // set the height of the image
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    const Text('History',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff1a2a3a),
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.02,
                        bottom: MediaQuery.of(context).size.width * 0.02,
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: const Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          'keeps track of the water level by time and displays it through a graph either monthly, weekly or daily.'),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.125,
              top: MediaQuery.of(context).size.height * 0.65,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.923),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      const Color(0xFFFFFFFF),
                      const Color(0xFFDFECFF),
                      const Color(0xFFC3DBFF),
                      const Color(0x00C3DBFF).withOpacity(0.8),
                    ],
                    stops: const [0.0561, 0.2843, 0.8113, 1.4206],
                    transform: const GradientRotation(139.58 * 3.141516 / 180),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(101, 160, 255, 0.8),
                      blurRadius: 27.5785,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        bottom: MediaQuery.of(context).size.height * 0.015,
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Image(
                      image: const AssetImage('assets/SMSlogo.png'),
                      width: MediaQuery.of(context).size.width *
                          0.07, // set the width of the image
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.023),
                    const Text('SMS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff1a2a3a),
                          fontFamily: 'aquire',
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: const Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          'offers the possibility of receiving the water level via SMS and sends SMS alerts in extreme situations.'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
