import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/enum_model/gender.dart';
import 'package:reqruit_manager/model/firebase/user/firestore_user_api_service.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class StudentModel extends ChangeNotifier {
  Student student = Student(
      id: SharedPreferencesServices().getUserId(),
      name: '',
      gender: Gender.none,
      graduationYear: '選択してください',
      college: '',
      adviserList: []);

  void selectGender(Gender input) {
    if (student.gender == input) return;

    student.gender = input;

    notifyListeners();
  }

  void selectGraduation(String input) {
    if (student.graduationYear == input) return;

    student.graduationYear = input;

    notifyListeners();
  }

  void addAdviser(Adviser adviser) {
    student.adviserList.add(adviser);
    notifyListeners();
  }

  Future<void> changeSelectionOpenState(bool value, int index) async {
    try {
      student.adviserList[index].isOpenSelection = value;
      await FireStoreUserApiService()
          .updateAdviserStudentOpenEsState(student.adviserList[index], student);
      await FireStoreUserApiService()
          .updateStudentAdviserOpenEsState(student.adviserList[index], student);
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  Future<void> getFireStoreData(String userId) async {
    student = await FireStoreUserApiService().getStudentData(userId);
  }

  Future<void> saveFireStore() async {
    student.fcmToken = SharedPreferencesServices().getFcmToken();
    await FireStoreUserApiService().setStudentData(student);

    if (student.adviserList.length != 0) {
      // studentのサブコレクションに更新
      await FireStoreUserApiService()
          .setStudentAdviserData(student.id, student.adviserList[0]);
      // adviserのサブコレクションに更新
      await FireStoreUserApiService()
          .setAdviserStudentData(student.adviserList[0], student);
    }
  }

  Future<void> updateStudentProfile() async {
    await FireStoreUserApiService().setStudentData(student);
  }
}
