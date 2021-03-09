import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqruit_manager/model/main_model/report.dart';

class FireStoreReportApiService {
  final fireStore = Firestore.instance;
  final _reportPath = 'report';

  Future<void> setReportData(Report report) async {
    await fireStore.collection(_reportPath).document().setData({
      'newsId': report.newsId,
      'reason': report.reason,
      'studentId': report.studentId,
    });
  }
}
