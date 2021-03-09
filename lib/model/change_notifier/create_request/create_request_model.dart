import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:reqruit_manager/model/enum_model/request_type.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';

class CreateRequestModel extends ChangeNotifier {
  Request request = Request(
    studentId: ChangeNotifierModel.studentModel.student.id,
    studentName: ChangeNotifierModel.studentModel.student.name,
    adviserId: '',
    adviserName: '選択してください。',
    requestType: RequestType.es,
    requestTitle: '',
    requestWordCount: '',
    requestContent: '',
    requestComment: '',
    requestContentLengths: 0,
    studentDeadlineDate: DateTime.now(),
    adviserDeadlineDate: null,
    requestStatus: RequestStatus.newRequest,
  );

  void selectRequestType(RequestType select) {
    if (select == request.requestType) return;
    request.requestType = select;
    notifyListeners();
  }

  void selectAdviser(String adviserName, String adviserId) {
    if (adviserName == request.adviserName) return;
    request.adviserId = adviserId;
    request.adviserName = adviserName;
    notifyListeners();
  }

  void changeEntrySheetContent(String input) {
    request.requestContent = input;
    request.requestContentLengths = input.length;
    notifyListeners();
  }

  void changeComment(String input) {
    request.requestComment = input;
    notifyListeners();
  }

  void changeRequestTitle(String input) {
    request.requestTitle = input;
    notifyListeners();
  }

  void changeRequestWordCount(String input) {
    request.requestWordCount = input;
    notifyListeners();
  }

  void changeDeadlineDate(DateTime dateTime) {
    request.studentDeadlineDate = dateTime;
    notifyListeners();
  }

  void changeTellRequestTitle(String input) {
    request.tellRequestTitle = input;
    notifyListeners();
  }

  void changeTellRequestContent(String input) {
    request.tellRequestContent = input;
    notifyListeners();
  }
}
