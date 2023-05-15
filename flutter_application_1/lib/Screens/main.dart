import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'live_history_page.dart';
import 'login_page.dart';
import '../Widgets/page_view_demo.dart';
import 'sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  Map<String, dynamic> phoneAndSignInData =
      await retrievePhoneNumberAndSignInStatus();

  String phoneNumber = phoneAndSignInData['phone_number'];
  bool isSignedIn = phoneAndSignInData['is_signed_in'];
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: //isSignedIn
          isSignedIn
              ? LiveHistoryPage((getTankNumber(phoneNumber)).toString())
              : PageViewDemo(),
    ),
  );
}
