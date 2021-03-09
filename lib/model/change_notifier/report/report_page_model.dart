import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/firebase/report/firestore_report_api_service.dart';
import 'package:reqruit_manager/model/main_model/report.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class ReportPageModel extends ChangeNotifier {
  Report report = Report(
    reason: '内容に興味がない',
  );

  void changeReportReason(String select) {
    if (report.reason == select) return;

    report.reason = select;
    notifyListeners();
  }

  Future<void> postToFireBase() async {
    report.studentId = SharedPreferencesServices().getUserId();
    await FireStoreReportApiService().setReportData(report);
  }
}
