import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/enum_model/auth_type.dart';
import 'package:reqruit_manager/model/firebase/auth/firebase_auth_api_service.dart';
import 'package:reqruit_manager/model/firebase/user/firestore_user_api_service.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class EmailAuthModel extends ChangeNotifier {
  String email;
  String password;
  AuthType authType;

  EmailAuthModel({
    this.email,
    this.password,
    this.authType,
  });

  Future<AuthResult> signUp() async {
    return await FireBaseAuthApiService().signUp(email, password);
  }

  Future<AuthResult> signIn() async {
    return await FireBaseAuthApiService().signIn(email, password);
  }

  Future<AuthResult> googleSignIn() async {
    return await FireBaseAuthApiService().googleSignIn();
  }

  Future<AuthResult> signInWithApple() async {
    return await FireBaseAuthApiService().signInWithApple();
  }

  Future<AccountType> searchLoginData(String userId) async {
    final DocumentSnapshot studentDoc =
        await FireStoreUserApiService().searchStudentLoginData(userId);
    if (studentDoc.data != null) {
      final Student student =
          await FireStoreUserApiService().getStudentData(userId);
      ChangeNotifierModel.studentModel.student = student;
      SharedPreferencesServices().saveAccountType(AccountType.student);
      return AccountType.student;
    }

    final DocumentSnapshot adviserDoc =
        await FireStoreUserApiService().searchAdviserLoginData(userId);
    if (adviserDoc.data != null) {
      final Adviser adviser =
          await FireStoreUserApiService().getAdviserData(userId);
      ChangeNotifierModel.adviserModel.adviser = adviser;
      SharedPreferencesServices().saveAccountType(AccountType.adviser);
      return AccountType.adviser;
    }

    return null;
  }
}
