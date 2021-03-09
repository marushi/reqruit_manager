import 'package:reqruit_manager/model/enum_model/request_type.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';

class Request {
  String requestId;
  String studentId;
  String studentName;
  String adviserId;
  String adviserName;
  RequestType requestType;
  String requestTitle;
  String requestWordCount;
  String requestContent;
  String requestComment;
  int requestContentLengths;
  DateTime studentDeadlineDate;
  DateTime adviserDeadlineDate;
  RequestStatus requestStatus;
  String adviserComment;
  String checkedES;
  String tellRequestTitle;
  String tellRequestContent;
  String adviserFcmToken;
  String studentFcmToken;

  Request({
    this.requestId,
    this.studentId,
    this.studentName,
    this.adviserId,
    this.adviserName,
    this.requestType,
    this.requestTitle,
    this.requestWordCount,
    this.requestContent,
    this.requestComment,
    this.requestContentLengths,
    this.studentDeadlineDate,
    this.adviserDeadlineDate,
    this.requestStatus,
    this.adviserComment,
    this.checkedES,
    this.tellRequestTitle,
    this.tellRequestContent,
    this.adviserFcmToken,
    this.studentFcmToken,
  });
}
