import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Menu.dart';
import 'Home.dart';
import 'LoginPage.dart';
import 'SignUp.dart';
import 'Welcome.dart';
import 'Preview.dart';
import 'HistoryStats.dart';
import 'FAQ.dart';
import 'Graph.dart';
import 'currentWaterLevel.dart';
import 'PageViewDemo.dart';
import 'CircleWaveWidget.dart';
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
      home: Home(),
    ),
  );
}
