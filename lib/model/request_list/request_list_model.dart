import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';
import 'package:reqruit_manager/model/firebase/request/firestore_request_api_service.dart';
import 'package:reqruit_manager/model/main_model/request.dart';

class RequestListModel extends ChangeNotifier {
  List<Request> requestList = [];

  Future<void> getAdviserRequestList() async {
    try {
      requestList =
          await FirestoreRequestApiService().getAdviserRequestData(false);
      return;
    } catch (e) {
      return;
    }
  }

  Future<void> getAdviserHistoryList() async {
    requestList =
        await FirestoreRequestApiService().getAdviserRequestData(true);
    return;
  }

  Future<void> getStudentHistoryList(String adviserId) async {
    requestList =
        await FirestoreRequestApiService().getStudentRequestData(adviserId);
    return;
  }

  Future<void> changeRequestStatusToFirebase(
      RequestStatus requestStatus, int index) async {
    requestList[index].requestStatus = RequestStatus.doing;
    await FirestoreRequestApiService()
        .setAdviserDeadlineAndStatus(requestList[index]);
    notifyListeners();
  }

  Future<void> setAdviserDeadlineAndStatus(
      RequestStatus requestStatus, int index) async {
    requestList[index].requestStatus = RequestStatus.doing;
    await FirestoreRequestApiService()
        .setAdviserDeadlineAndStatus(requestList[index]);
    notifyListeners();
  }

  Future<void> setCheckedESAndAdviserComment(
      RequestStatus requestStatus, int index) async {
    requestList[index].requestStatus = RequestStatus.finish;
    await FirestoreRequestApiService()
        .setCheckedESAndAdviserComment(requestList[index]);
    notifyListeners();
  }

  void selectAdviserDeadlineDate(DateTime dateTime, int index) {
    requestList[index].adviserDeadlineDate = dateTime;
    notifyListeners();
  }

  void changeComment(String input, int index) {
    requestList[index].adviserComment = input;
    notifyListeners();
  }

  void changeCheckedES(String input, int index) {
    requestList[index].checkedES = input;
    notifyListeners();
  }

  void addRequest(Request request) {
    requestList.insert(0, request);
    notifyListeners();
  }
}
