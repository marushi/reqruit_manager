import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class FirestoreRequestApiService {
  final fireStore = Firestore.instance;
  final _requestPath = 'request';

  //studentが依頼を作成
  Future<void> setRequestData(BuildContext context, Request request) async {
    await fireStore.collection(_requestPath).document().setData({
      'studentName': request.studentName,
      'studentId': request.studentId,
      'adviserName': request.adviserName,
      'adviserId': request.adviserId,
      'title': request.requestTitle,
      'type': EnumConvert.requestTypeToString(request.requestType),
      'studentDeadlineDate': request.studentDeadlineDate,
      'adviserDeadlineDate': request.adviserDeadlineDate,
      'comment': request.requestComment,
      'wordCount': request.requestWordCount,
      'content': request.requestContent,
      'status': EnumConvert.requestStatusToString(request.requestStatus),
      'tellRequestTitle': request.tellRequestTitle,
      'tellRequestContent': request.tellRequestContent,
      'createdAt': DateTime.now(),
    });
  }

  Future<List<Request>> getStudentRequestData(String adviserId) async {
    final studentId = SharedPreferencesServices().getUserId();

    // FB履歴の場合は対応完了したやつだけ
    final querySnapshot = await fireStore
        .collection(_requestPath)
        .where("adviserId", isEqualTo: adviserId)
        .where("studentId", isEqualTo: studentId)
        .orderBy("createdAt", descending: true)
        .getDocuments();

    if (querySnapshot.documents.length == 0) return [];

    return querySnapshot.documents.map((doc) {
      final Request request = Request(
        requestId: doc.documentID,
        studentId: doc.data["studentId"],
        studentName: doc.data["studentName"],
        adviserId: doc.data["adviserId"],
        adviserName: doc.data["adviserName"],
        requestType: EnumConvert.stringToRequestType(doc.data["type"]),
        requestTitle: doc.data["title"],
        requestWordCount: doc.data["wordCount"],
        requestContent: doc.data["content"],
        requestComment: doc.data["comment"],
        studentDeadlineDate:
            (doc.data['studentDeadlineDate'] as Timestamp).toDate(),
        requestStatus: EnumConvert.stringToRequestStatus(doc.data["status"]),
        checkedES: doc.data['checkedES'],
        adviserComment: doc.data['adviserComment'],
        tellRequestTitle: doc.data['tellRequestTitle'],
        tellRequestContent: doc.data['tellRequestContent'],
      );
      if (doc.data['adviserDeadlineDate'] == null) {
        request.adviserDeadlineDate =
            (doc.data['studentDeadlineDate'] as Timestamp).toDate();
      } else {
        request.adviserDeadlineDate =
            (doc.data['adviserDeadlineDate'] as Timestamp).toDate();
      }
      return request;
    }).toList();
  }

  //アドバイザーが依頼データを取得
  Future<List<Request>> getAdviserRequestData(bool isHistory) async {
    final adviserId = SharedPreferencesServices().getUserId();

    // FB履歴の場合は対応完了したやつだけ
    final querySnapshot = !isHistory
        ? await fireStore
            .collection(_requestPath)
            .where("adviserId", isEqualTo: adviserId)
            .where("status", whereIn: ["対応中", "未対応"])
            .orderBy("createdAt", descending: true)
            .getDocuments()
        : await fireStore
            .collection(_requestPath)
            .where("adviserId", isEqualTo: adviserId)
            .where("status", isEqualTo: "対応済み")
            .getDocuments();

    if (querySnapshot.documents.length == 0) return [];

    return querySnapshot.documents.map((doc) {
      final Request request = Request(
        requestId: doc.documentID,
        studentId: doc.data["studentId"],
        studentName: doc.data["studentName"],
        adviserId: doc.data["adviserId"],
        adviserName: doc.data["adviserName"],
        requestType: EnumConvert.stringToRequestType(doc.data["type"]),
        requestTitle: doc.data["title"],
        requestWordCount: doc.data["wordCount"],
        requestContent: doc.data["content"],
        requestComment: doc.data["comment"],
        studentDeadlineDate:
            (doc.data['studentDeadlineDate'] as Timestamp).toDate(),
        requestStatus: EnumConvert.stringToRequestStatus(doc.data["status"]),
        checkedES: doc.data['checkedES'],
        adviserComment: doc.data['adviserComment'],
        tellRequestTitle: doc.data['tellRequestTitle'],
        tellRequestContent: doc.data['tellRequestContent'],
      );
      if (doc.data['adviserDeadlineDate'] == null) {
        request.adviserDeadlineDate =
            (doc.data['studentDeadlineDate'] as Timestamp).toDate();
      } else {
        request.adviserDeadlineDate =
            (doc.data['adviserDeadlineDate'] as Timestamp).toDate();
      }
      return request;
    }).toList();
  }

  Future<void> setAdviserDeadlineAndStatus(Request request) async {
    await fireStore
        .collection(_requestPath)
        .document(request.requestId)
        .setData({
      'adviserDeadlineDate': request.adviserDeadlineDate,
      'status': EnumConvert.requestStatusToString(request.requestStatus),
    }, merge: true);
  }

  Future<void> setCheckedESAndAdviserComment(Request request) async {
    await fireStore
        .collection(_requestPath)
        .document(request.requestId)
        .setData({
      'adviserComment': request.adviserComment,
      'checkedES': request.checkedES,
      'status': EnumConvert.requestStatusToString(RequestStatus.finish),
      'completeDate': DateTime.now(),
    }, merge: true);
  }
}
