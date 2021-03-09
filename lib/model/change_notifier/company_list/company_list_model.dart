import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/selection_status.dart';
import 'package:reqruit_manager/model/enum_model/selection_type.dart';
import 'package:reqruit_manager/model/firebase/company/firestore_company_api_service.dart';
import 'package:reqruit_manager/model/main_model/company.dart';

class CompanyListModel extends ChangeNotifier {
  List<Company> companyList = [];

  Future<void> getCompanyList(String studentId) async {
    companyList = await FireStoreCompanyApiService().getCompanyData(studentId);
  }

  Future<void> changeSelectionStatus(
      SelectionStatus status, int companyIndex, int selectionIndex) async {
    if (selectionIndex == 0) {
      companyList[companyIndex].selectionList[selectionIndex].selectionStatus =
          status;
      companyList[companyIndex].nowSelectionType =
          companyList[companyIndex].selectionList[selectionIndex].selectionType;
      companyList[companyIndex].nowSelectionTypeString =
          EnumConvert.selectionTypeToString(companyList[companyIndex]
              .selectionList[selectionIndex]
              .selectionType);
    } else {
      companyList[companyIndex].selectionList[selectionIndex].selectionStatus =
          status;
      companyList[companyIndex].nowSelectionType =
          companyList[companyIndex].selectionList[selectionIndex].selectionType;
      companyList[companyIndex].nowSelectionTypeString =
          EnumConvert.selectionTypeToString(companyList[companyIndex]
              .selectionList[selectionIndex]
              .selectionType);
      companyList[companyIndex].nextSelection = companyList[companyIndex]
          .selectionList[selectionIndex - 1]
          .selectionType;
      companyList[companyIndex].nextSelectionDate = companyList[companyIndex]
          .selectionList[selectionIndex - 1]
          .selectionDate;

      if (status == SelectionStatus.decline || status == SelectionStatus.miss) {
        companyList[companyIndex]
            .selectionList[selectionIndex - 1]
            .selectionStatus = status;
        companyList[companyIndex].isComplete = true;
        companyList[companyIndex].percentage = 0;
      }
    }

    companyList[companyIndex].percentage =
        (companyList[companyIndex].selectionList.length - selectionIndex) /
            companyList[companyIndex].selectionList.length;

    await FireStoreCompanyApiService()
        .updateCompanySelectionData(companyList[companyIndex]);
    notifyListeners();
  }

  void selectCompleteDate(
      DateTime dateTime, int companyIndex, int selectionIndex) {
    companyList[companyIndex].selectionList[selectionIndex].completeDate =
        dateTime;
    notifyListeners();
  }

  Future<void> getSelectionList(String studentId, int companyIndex) async {
    companyList[companyIndex].selectionList = await FireStoreCompanyApiService()
        .getSelectionData(companyList[companyIndex].id, studentId);
    notifyListeners();
  }

  Future<void> getEntrySheetList(String studentId, int companyIndex) async {
    companyList[companyIndex].entrySheetList =
        await FireStoreCompanyApiService()
            .getEntrySheetData(companyList[companyIndex].id, studentId);
    notifyListeners();
  }

  void addCompanyList(Company company) {
    company.isComplete = false;
    company.percentage = 0;
    company.nowSelectionType = SelectionType.entry;
    company.nowSelectionTypeString =
        EnumConvert.selectionTypeToString(company.nowSelectionType);
    company.nextSelection = SelectionType.entrySheet;
    company.nextSelectionDate = DateTime.now();
    companyList.insert(0, company);
    notifyListeners();
  }
}
