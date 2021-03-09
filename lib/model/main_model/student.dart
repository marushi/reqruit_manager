import 'package:reqruit_manager/model/enum_model/gender.dart';
import 'package:reqruit_manager/model/enum_model/sns_type.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';

class Student {
  String id;
  String name;
  Gender gender;
  String graduationYear;
  String college;
  List<Adviser> adviserList;
  SnsType snsAccount;
  String snsAccountName;
  bool isOpenSelection;
  String fcmToken;

  Student({
    this.id,
    this.name,
    this.gender,
    this.graduationYear,
    this.college,
    this.adviserList,
    this.snsAccount,
    this.snsAccountName,
    this.isOpenSelection,
    this.fcmToken,
  });
}
