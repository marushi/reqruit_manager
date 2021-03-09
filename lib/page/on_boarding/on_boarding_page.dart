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
        title: '選考中の会社を登録',
        body: '会社を登録して、選考状況・ESの管理が可能です。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/images/adviser.png',
        title: 'アドバイザーを探す',
        body: 'アドバイザーを探して、ESの添削や電話相談の管理が可能です。',
        doAnimateImage: true),
  ];
}
