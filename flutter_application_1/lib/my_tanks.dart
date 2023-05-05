import 'package:flutter/material.dart';

class TankPage extends StatefulWidget {
  @override
  _TankPageState createState() => _TankPageState();
}

class _TankPageState extends State<TankPage> {
  List<TankData> tanks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBBD0EA),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Image.asset('assets/logo2.png'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tanks.length,
              itemBuilder: (context, index) {
                return TankBox(tank: tanks[index]);
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                tanks.add(TankData(
                  tankId: 'Tank ${tanks.length + 1}',
                  shape: 'Cylinder',
                  volume: '10,000 liters',
                ));
              });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class TankData {
  final String tankId;
  final String shape;
  final String volume;

  TankData({required this.tankId, required this.shape, required this.volume});
}

class TankBox extends StatelessWidget {
  final TankData tank;

  TankBox({required this.tank});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tank ID: ${tank.tankId}',
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tank\'s Shape: ${tank.shape}',
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tank\'s Volume: ${tank.volume}',
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}
