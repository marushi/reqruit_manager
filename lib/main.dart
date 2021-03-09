import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_device_info.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/routes.dart' as routes;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesServices.preferences = await SharedPreferences.getInstance();
  if (Platform.isIOS)
    AppDeviceInfo.iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
  final userId = SharedPreferencesServices().getUserId();
  if (userId.isNotEmpty) {
    final accountType = SharedPreferencesServices().getAccountType();
    if (accountType != null) {
      if (accountType == AccountType.student) {
        try {
          await ChangeNotifierModel.studentModel.getFireStoreData(userId);
        } catch (e) {
          ChangeNotifierModel.initTransition.isForce = true;
        }
      } else if (accountType == AccountType.adviser) {
        try {
          await ChangeNotifierModel.adviserModel.getFireStoreData(userId);
        } catch (e) {
          ChangeNotifierModel.initTransition.isForce = true;
        }
      }
    }
  }

  // 初期の遷移先を判定
  ChangeNotifierModel.initTransition.setInitTransition();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reqruit Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: routes.initialRoute,
      routes: routes.routes,
    );
  }
}
