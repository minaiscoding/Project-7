import 'package:flutter/material.dart';
import 'live_history_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'sign_up.dart';
import '../Widgets/page_view_demo.dart';
import 'login_page.dart';

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
      // home: PageViewDemo(),
      home: SignUpPage(),
    ),
  );
}
