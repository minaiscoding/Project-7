import 'package:fluid/Screens/login_page.dart';
import 'package:flutter/material.dart'; //imports dart
import '../Screens/sign_up.dart';

Widget menuItem(String title, bool isSelected) {
  final textStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1,
    color: isSelected ? Colors.white : const Color(0xFF21457D),
  );
  final elevation = isSelected ? 8.0 : 0.0;
  final backgroundColor = isSelected ?const Color(0xFF21457D) : Colors.white;
  final boxShadow = isSelected
      ? [
          BoxShadow(
            color: Color.fromRGBO(101, 160, 255, 0.5),
            offset: Offset(0, 8),
            blurRadius: 30,
          ),
        ]
      : null;
  final borderRadius = BorderRadius.circular(30);

  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      shadowColor: Color(0xFF21457D),
    ),
    child: Container(
      width: 121,
      height: 56,
      alignment: Alignment.center,
      child: Text(
        title,
        style: textStyle,
      ),
    ),
  );
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(59, 142, 0, 0),
          width: 273,
          height: 434,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromRGBO(26, 42, 58, 0.25),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(101, 160, 255, 0.5),
                offset: Offset(0, 8),
                blurRadius: 30,
              ),
            ],
            borderRadius: BorderRadius.circular(33),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              menuItem('Home', true),
              SizedBox(height: 28),
              menuItem('Settings', false),
              SizedBox(height: 28),
              menuItem('FAQ', false),
              SizedBox(height: 28),
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    storePhoneNumberAndSignInStatus("", false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF21457D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
