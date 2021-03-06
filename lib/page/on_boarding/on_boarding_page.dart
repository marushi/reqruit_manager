import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class OnBoardingPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () async {
          SharedPreferencesServices().setOnBoardingShow();
          _firebaseMessaging.requestNotificationPermissions(
              const IosNotificationSettings(
                  sound: true, badge: true, alert: true));
          _firebaseMessaging.onIosSettingsRegistered
              .listen((IosNotificationSettings settings) {
            print("Settings registered: $settings");
          });
          _firebaseMessaging.getToken().then((String token) {
            assert(token != null);
            print("Push Messaging token: $token");
            SharedPreferencesServices().setFcmToken(token);
            print(SharedPreferencesServices().getFcmToken());
          });
          Navigator.pushNamed(context, '/terms');
        },
        finishCallback: () async {
          SharedPreferencesServices().setOnBoardingShow();
          _firebaseMessaging.requestNotificationPermissions(
              const IosNotificationSettings(
                  sound: true, badge: true, alert: true));
          _firebaseMessaging.onIosSettingsRegistered
              .listen((IosNotificationSettings settings) {
            print("Settings registered: $settings");
          });
          _firebaseMessaging.getToken().then((String token) {
            assert(token != null);
            print("Push Messaging token: $token");
            SharedPreferencesServices().setFcmToken(token);
            print(SharedPreferencesServices().getFcmToken());
          });
          Navigator.pushNamed(context, '/terms');
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/images/company.png',
        title: '???????????????????????????',
        body: '???????????????????????????????????????ES???????????????????????????',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/images/adviser.png',
        title: '???????????????????????????',
        body: '?????????????????????????????????ES???????????????????????????????????????????????????',
        doAnimateImage: true),
  ];
}
