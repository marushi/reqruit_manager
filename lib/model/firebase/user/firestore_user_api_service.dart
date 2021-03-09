import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class FireStoreUserApiService {
  final fireStore = Firestore.instance;
  final _studentPath = 'student';
  final _adviserPath = 'adviser';
  final _openEsPath = 'openEs';

  Future<void> setStudentData(Student student) async {
    await fireStore.collection(_studentPath).document(student.id).setData({
      'name': student.name,
      'gender': EnumConvert.genderToString(student.gender),
      'graduationYear': student.graduationYear,
      'college': student.college ?? '',
      'fcmToken': student.fcmToken,
    }, merge: true);
  }

  Future<void> setAdviserStudentData(Adviser adviser, Student student) async {
    await fireStore
        .collection(_adviserPath)
        .document(adviser.id)
        .collection(_studentPath)
        .document(student.id)
        .setData({
      'name': student.name,
      'gender': EnumConvert.genderToString(student.gender),
      'graduationYear': student.graduationYear,
      'college': student.college ?? '',
      'snsAccount': EnumConvert.snsTypeToString(student.snsAccount),
      'snsAccountName': student.snsAccountName,
      'isOpenSelection': adviser.isOpenSelection,
      'fcmToken': adviser.fcmToken,
    }, merge: true);
  }

  Future<void> setStudentAdviserData(String studentId, Adviser adviser) async {
    await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_adviserPath)
        .document(adviser.id)
        .setData({
      'name': adviser.name,
      'imageUrl': adviser.imageUrl,
      'isOpenSelection': adviser.isOpenSelection,
      'fcmToken': adviser.fcmToken,
    }, merge: true);
  }

  Future<void> setAdviserData(Adviser adviser) async {
    await fireStore.collection(_adviserPath).document(adviser.id).setData({
      'name': adviser.name,
      'adminId': adviser.adminId,
      'imageUrl': adviser.imageUrl,
      'fcmToken': adviser.fcmToken,
    }, merge: true);
  }

  Future<Student> getStudentData(String studentId) async {
    try {
      final documentSnapshot =
          await fireStore.collection(_studentPath).document(studentId).get();
      if (documentSnapshot.exists) {
        final querySnapshot = await fireStore
            .collection(_studentPath)
            .document(studentId)
            .collection(_adviserPath)
            .getDocuments();
        // adviserのサブコレクションが存在するか
        if (querySnapshot.documents.length != 0) {
          List<Adviser> adviserList = [];
          querySnapshot.documents.forEach((doc) {
            final Adviser adviser = Adviser(
              id: doc.documentID,
              name: doc.data['name'] as String,
              imageUrl: doc.data['imageUrl'] as String,
              isOpenSelection: doc.data['isOpenSelection'] as bool,
            );
            adviserList.add(adviser);
          });
          return Student(
            id: studentId,
            name: documentSnapshot.data['name'] as String,
            gender: EnumConvert.stringToGender(
                documentSnapshot.data['gender'] as String),
            college: documentSnapshot.data['college'] as String ?? '',
            graduationYear: documentSnapshot.data['graduationYear'] as String,
            adviserList: adviserList,
            fcmToken: documentSnapshot.data['fcmToken'] ?? '',
          );
        } else {
          return Student(
            id: studentId,
            name: documentSnapshot.data['name'] as String,
            gender: EnumConvert.stringToGender(
                documentSnapshot.data['gender'] as String),
            college: documentSnapshot.data['college'] as String ?? '',
            graduationYear: documentSnapshot.data['graduationYear'] as String,
            adviserList: [],
            fcmToken: documentSnapshot.data['fcmToken'] ?? '',
          );
        }
      } else {
        return Student();
      }
    } catch (e) {
      return Student();
    }
  }

  Future<Adviser> getAdviserData(String adviserId) async {
    try {
      final documentSnapshot =
          await fireStore.collection(_adviserPath).document(adviserId).get();
      if (documentSnapshot.exists) {
        final querySnapshot = await fireStore
            .collection(_adviserPath)
            .document(adviserId)
            .collection(_studentPath)
            .getDocuments();
        if (querySnapshot.documents.length != 0) {
          List<Student> studentList = [];
          querySnapshot.documents.forEach((doc) {
            final Student student = Student(
              id: doc.documentID,
              name: doc.data['name'] as String,
              college: doc.data['college'] as String ?? '',
              gender: EnumConvert.stringToGender(doc.data['gender'] as String),
              snsAccount:
                  EnumConvert.stringToSnsType(doc.data['snsAccount'] as String),
              snsAccountName: doc.data['snsAccountName'] as String,
              graduationYear: doc.data['graduationYear'] as String,
              fcmToken: doc.data['fcmToken'] ?? '',
            );
            studentList.add(student);
          });
          return Adviser(
            id: adviserId,
            name: documentSnapshot.data['name'] as String,
            imageUrl: documentSnapshot.data['imageUrl'] as String,
            studentList: studentList,
            fcmToken: documentSnapshot.data['fcmToken'] ?? '',
          );
        }
        return Adviser(
          id: adviserId,
          name: documentSnapshot.data['name'] as String,
          imageUrl: documentSnapshot.data['imageUrl'] as String,
          studentList: [],
          fcmToken: documentSnapshot.data['fcmToken'] ?? '',
        );
      } else {
        return Adviser();
      }
    } catch (e) {
      return Adviser();
    }
  }

  Future<List<Student>> getAdviserStudentData(String adviserId) async {
    final QuerySnapshot _querySnapshot = await fireStore
        .collection(_adviserPath)
        .document(adviserId)
        .collection(_studentPath)
        .getDocuments();
    return _querySnapshot.documents.map((doc) {
      final Student _student = Student(
        id: doc.documentID,
        name: doc.data['name'],
        gender: EnumConvert.stringToGender(doc.data['gender']),
        graduationYear: doc.data['graduationYear'],
        college: doc.data['college'],
        isOpenSelection: doc.data['isOpenSelection'],
        snsAccount: EnumConvert.stringToSnsType(doc.data['snsAccount']),
        snsAccountName: doc.data['snsAccountName'],
        fcmToken: doc.data['fcmToken'] ?? '',
      );
      return _student;
    }).toList();
  }

  Future<List<EntrySheet>> getOpenEsData() async {
    final _studentId = SharedPreferencesServices().getUserId();
    final QuerySnapshot _querySnapshot = await fireStore
        .collection(_studentPath)
        .document(_studentId)
        .collection(_openEsPath)
        .getDocuments();

    return _querySnapshot.documents.map((doc) {
      final EntrySheet _entrySheet = EntrySheet(
        id: doc.documentID,
        title: doc.data['title'],
        content: doc.data['content'],
        length: (doc.data['content'] as String).length,
      );
      return _entrySheet;
    }).toList();
  }

  Future<void> setOpenEsData(EntrySheet entrySheet) async {
    final _studentId = SharedPreferencesServices().getUserId();
    await fireStore
        .collection(_studentPath)
        .document(_studentId)
        .collection(_openEsPath)
        .document()
        .setData({
      'title': entrySheet.title,
      'content': entrySheet.content,
    });
  }

  Future<void> updateStudentAdviserOpenEsState(
      Adviser adviser, Student student) async {
    await fireStore
        .collection(_studentPath)
        .document(student.id)
        .collection(_adviserPath)
        .document(adviser.id)
        .updateData({
      'isOpenSelection': adviser.isOpenSelection,
    });
  }

  Future<void> updateAdviserStudentOpenEsState(
      Adviser adviser, Student student) async {
    await fireStore
        .collection(_adviserPath)
        .document(adviser.id)
        .collection(_studentPath)
        .document(student.id)
        .updateData({
      'isOpenSelection': adviser.isOpenSelection,
    });
  }

  Future<QuerySnapshot> searchAdviser(String adminId) async {
    final querySnapshot = await fireStore
        .collection(_adviserPath)
        .where('adminId', isEqualTo: adminId)
        .getDocuments();
    return querySnapshot;
  }

  Future<DocumentSnapshot> searchStudentLoginData(String userId) async {
    final studentDoc =
        await fireStore.collection(_studentPath).document(userId).get();
    return studentDoc;
  }

  Future<DocumentSnapshot> searchAdviserLoginData(String userId) async {
    final adviserDoc =
        await fireStore.collection(_adviserPath).document(userId).get();
    return adviserDoc;
  }
}
