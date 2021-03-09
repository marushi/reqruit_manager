import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  final String _userIdKey = 'user_id';
  final String _userNameKey = 'user_name';
  final String _userImageUrlKey = 'user_image_url';
  final String _userCollegeKey = 'user_college';
  final String _userGraduationKey = 'user_graduation';
  final String _onBoardingIdKey = 'onboarding';
  final String _accountTypeKey = 'account_type';
  final String _fcmTokenKey = 'fcm_token';
  final String _isTermsAccept = 'terms';

  /// shared_preferences ライブラリ インスタンス
  static SharedPreferences preferences;

  String getUserId() {
    String customerId = preferences.getString(_userIdKey);
    if (customerId == null) return '';

    return customerId;
  }

  void saveUserId(String customerId) {
    if (customerId == null) return;
    preferences.setString(_userIdKey, customerId);
  }

  void saveAccountType(AccountType accountType) {
    preferences.setString(
        _accountTypeKey, EnumConvert.accountTypeToString(accountType));
  }

  AccountType getAccountType() {
    String accountTypeString = preferences.getString(_accountTypeKey);
    if (accountTypeString == null) return null;

    return EnumConvert.stringToAccountType(accountTypeString);
  }

  Future<Student> getStudentData() async {
    String id = preferences.getString(_userIdKey);
    String name = preferences.getString(_userNameKey);
    String graduationYear = preferences.getString(_userGraduationKey);
    String college = preferences.getString(_userCollegeKey);
    List<Adviser> adviserList = [];

    if (id == null || name == null || graduationYear == null || college == null)
      return Student();

    return Student(
      id: id,
      name: name,
      graduationYear: graduationYear,
      college: college,
      adviserList: adviserList,
    );
  }

  void setStudentData(Student student) {
    preferences.setString(_userIdKey, student.id);
    preferences.setString(_userNameKey, student.name);
    preferences.setString(_userGraduationKey, student.graduationYear);
    preferences.setString(_userCollegeKey, student.college);
  }

  void removeUserData() {
    preferences.remove(_userIdKey);
    preferences.remove(_userNameKey);
    preferences.remove(_userCollegeKey);
    preferences.remove(_userGraduationKey);
    preferences.remove(_userImageUrlKey);
    preferences.remove(_accountTypeKey);
  }

  Adviser getAdviserData() {
    String id = preferences.getString(_userIdKey);
    String name = preferences.getString(_userNameKey);
    String imageUrl = preferences.getString(_userImageUrlKey);

    if (id == null || name == null || imageUrl == null) return Adviser();

    return Adviser(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }

  void setAdviserData(Adviser adviser) {
    preferences.setString(_userIdKey, adviser.id);
    preferences.setString(_userNameKey, adviser.name);
    preferences.setString(_userImageUrlKey, adviser.imageUrl);
  }

  bool getOnBoardingShow() {
    bool isSkipOnBoarding = preferences.getBool(_onBoardingIdKey);
    if (isSkipOnBoarding == null) return false;

    return isSkipOnBoarding;
  }

  void setOnBoardingShow() {
    preferences.setBool(_onBoardingIdKey, true);
  }

  void setTermsAccept() {
    preferences.setBool(_isTermsAccept, true);
  }

  bool getTermsAccept() {
    bool isTermsAccept = preferences.getBool(_isTermsAccept);
    if (isTermsAccept == null) return false;

    return isTermsAccept;
  }

  void setFcmToken(String fcmToken) {
    preferences.setString(_fcmTokenKey, fcmToken);
  }

  String getFcmToken() {
    String fcmToken = preferences.getString(_fcmTokenKey);
    if (fcmToken == null) return '';

    return fcmToken;
  }
}
