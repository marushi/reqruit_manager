import 'package:reqruit_manager/model/main_model/student.dart';

class Adviser {
  String id;
  String name;
  String adminId;
  String imageUrl;
  bool isOpenSelection;
  List<Student> studentList;
  String fcmToken;

  Adviser({
    this.id,
    this.name,
    this.adminId,
    this.imageUrl,
    this.isOpenSelection,
    this.studentList,
    this.fcmToken,
  });
}
