import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Widgets/Menu.dart';
import 'Home.dart';
import 'LoginPage.dart';
import 'SignUp.dart';
import 'Welcome.dart';
import 'Preview.dart';
import 'LiveHistoryPage.dart';
import 'FAQ.dart';
import '../Widgets/Graph.dart';
import '../Widgets/currentWaterLevel.dart';
import '../Widgets/PageViewDemo.dart';
import '../Widgets/CircleWaveWidget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.deepPurple,
            ledColor: Colors.deepPurple)
      ],
      debug: true);
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: SignUpPage(),
    ),
  );
}
