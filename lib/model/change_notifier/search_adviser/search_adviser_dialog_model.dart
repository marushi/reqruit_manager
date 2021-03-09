import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/data_load_type.dart';
import 'package:reqruit_manager/model/firebase/user/firestore_user_api_service.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';

class SearchAdviserDialogModel extends ChangeNotifier {
  DataLoadType searchStatus = DataLoadType.none;
  Adviser adviser;
  String snsAccount = 'SNS選択';
  String snsAccountName = '';

  void searchAdviser(String adminId) async {
    try {
      final QuerySnapshot querySnapshot =
          await FireStoreUserApiService().searchAdviser(adminId);

      if (querySnapshot == null || querySnapshot.documents.length == 0) {
        searchStatus = DataLoadType.miss;
        notifyListeners();
        return;
      }

      ChangeNotifierModel.studentModel.student.adviserList.forEach((adviser) {
        if (adviser.id == querySnapshot.documents[0].documentID) {
          searchStatus = DataLoadType.miss;
          notifyListeners();
          return;
        }
      });

      if (searchStatus == DataLoadType.miss) return;

      searchStatus = DataLoadType.success;

      querySnapshot.documents.forEach((doc) {
        adviser = Adviser(
          id: doc.documentID,
          name: doc.data['name'] as String,
          imageUrl: doc.data['imageUrl'] as String,
          isOpenSelection: false,
          fcmToken: doc.data['fcmToken'] ?? '',
        );
      });

      notifyListeners();
    } catch (e) {
      /// 例外処理書く
      return;
    }
  }

  void selectSnsAccount(String input) {
    if (snsAccount == input) return;

    snsAccount = input;

    notifyListeners();
  }

  void changeSwitchState(bool value) {
    adviser.isOpenSelection = value;
    notifyListeners();
  }

  void changeSnsAccountName(String text) {
    snsAccountName = text;
  }
}
