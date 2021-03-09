import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/company.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';
import 'package:reqruit_manager/model/main_model/selection.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class FireStoreCompanyApiService {
  final fireStore = Firestore.instance;
  final _studentPath = 'student';
  final _companyPath = 'company';
  final _entrySheetPath = 'entry_sheet';
  final _selectionPath = 'selection';

  Future<String> addCompanyData(String studentId, Company company) async {
    final DocumentReference doc = await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .add({
      'name': company.name,
      'wishGrade': EnumConvert.wishGradeToString(company.wishGrade),
      'url': company.url,
      'address': company.address,
      'memo': company.memo,
      'isComplete': false,
      'percentage': 0,
      'nowSelectionStatusString': 'エントリー前',
      'nextSelection': 'エントリー',
      'nextSelectionDate': company.selectionList.last.selectionDate,
      'nowSelectionType': EnumConvert.selectionTypeToString(
          company.selectionList.last.selectionType),
      'createdAt': DateTime.now(),
    });

    company.entrySheetList.forEach((entrySheet) async {
      await setEntrySheetData(studentId, doc.documentID, entrySheet);
    });

    company.selectionList.forEach((selection) async {
      await setSelectionData(studentId, doc.documentID, selection);
    });

    return doc.documentID;
  }

  Future<void> setEntrySheetData(
      String studentId, String companyId, EntrySheet entrySheet) async {
    await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .document(companyId)
        .collection(_entrySheetPath)
        .add({
      'title': entrySheet.title,
      'content': entrySheet.content,
    });
  }

  Future<void> setSelectionData(
      String studentId, String companyId, Selection selection) async {
    await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .document(companyId)
        .collection(_selectionPath)
        .add({
      'selectionNumber': selection.selectionNumber,
      'selectionType':
          EnumConvert.selectionTypeToString(selection.selectionType),
      'selectionStatus':
          EnumConvert.selectionStatusToString(selection.selectionStatus),
      'selectionDate': selection.selectionDate,
      'completeDate': DateTime.now(),
    });
  }

  Future<List<Company>> getCompanyData(String studentId) async {
    final querySnapshot = await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .orderBy('createdAt', descending: true)
        .getDocuments();

    if (querySnapshot.documents.length == 0) return [];

    return querySnapshot.documents.map((doc) {
      final Company company = Company(
        id: doc.documentID,
        name: doc.data['name'],
        wishGrade: EnumConvert.stringToWishGrade(doc.data['wishGrade']),
        url: doc.data['url'],
        address: doc.data['address'],
        memo: doc.data['memo'],
        isComplete: doc.data['isComplete'] ?? false,
        percentage: (doc.data['percentage'] ?? 0.0).toDouble(),
        nowSelectionTypeString: doc.data['nowSelectionStatusString'],
        nextSelectionDate:
            (doc.data['nextSelectionDate'] as Timestamp).toDate(),
        nextSelection:
            EnumConvert.stringToSelectionType(doc.data['nextSelection']),
        nowSelectionType:
            EnumConvert.stringToSelectionType(doc.data['nowSelectionType']),
      );
      return company;
    }).toList();
  }

  Future<List<Selection>> getSelectionData(
      String companyId, String studentId) async {
    final querySnapshot = await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .document(companyId)
        .collection(_selectionPath)
        .orderBy('selectionNumber', descending: true)
        .getDocuments();

    if (querySnapshot.documents.length == 0) return [];

    return querySnapshot.documents.map((doc) {
      final Selection selection = Selection(
        id: doc.documentID,
        selectionDate: (doc.data['selectionDate'] as Timestamp).toDate(),
        selectionNumber: doc.data['selectionNumber'],
        selectionType:
            EnumConvert.stringToSelectionType(doc.data['selectionType']),
        selectionStatus:
            EnumConvert.stringToSelectionStatus(doc.data['selectionStatus']),
        completeDate: (doc.data['completeDate'] as Timestamp).toDate(),
      );
      return selection;
    }).toList();
  }

  Future<List<EntrySheet>> getEntrySheetData(
      String companyId, String studentId) async {
    final querySnapshot = await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .document(companyId)
        .collection(_entrySheetPath)
        .getDocuments();

    if (querySnapshot.documents.length == 0) return [];

    return querySnapshot.documents.map((doc) {
      final EntrySheet entrySheet = EntrySheet(
        id: doc.documentID,
        title: doc.data['title'],
        content: doc.data['content'],
      );
      return entrySheet;
    }).toList();
  }

  Future<void> updateCompanySelectionData(Company company) async {
    final studentId = SharedPreferencesServices().getUserId();

    await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .document(company.id)
        .updateData({
      'name': company.name,
      'wishGrade': EnumConvert.wishGradeToString(company.wishGrade),
      'url': company.url,
      'address': company.address,
      'memo': company.memo,
      'isComplete': company.isComplete,
      'percentage': company.percentage,
      'nowSelectionStatusString':
          EnumConvert.selectionTypeToString(company.nowSelectionType),
      'nextSelection': EnumConvert.selectionTypeToString(company.nextSelection),
      'nextSelectionDate': company.selectionList.last.selectionDate,
      'nowSelectionType': EnumConvert.selectionTypeToString(
          company.selectionList.last.selectionType),
    });

    company.selectionList.forEach((selection) async {
      await updateSelectionData(company.id, selection);
    });
  }

  Future<void> updateSelectionData(
      String companyId, Selection selection) async {
    final studentId = SharedPreferencesServices().getUserId();

    await fireStore
        .collection(_studentPath)
        .document(studentId)
        .collection(_companyPath)
        .document(companyId)
        .collection(_selectionPath)
        .document(selection.id)
        .updateData({
      'selectionNumber': selection.selectionNumber,
      'selectionType':
          EnumConvert.selectionTypeToString(selection.selectionType),
      'selectionStatus':
          EnumConvert.selectionStatusToString(selection.selectionStatus),
      'selectionDate': selection.selectionDate,
      'completeDate': DateTime.now(),
    });
  }
}
