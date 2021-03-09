import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/selection_status.dart';
import 'package:reqruit_manager/model/enum_model/selection_type.dart';
import 'package:reqruit_manager/model/enum_model/wish_grade.dart';
import 'package:reqruit_manager/model/firebase/company/firestore_company_api_service.dart';
import 'package:reqruit_manager/model/main_model/company.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';
import 'package:reqruit_manager/model/main_model/selection.dart';

class CreateCompanyModel extends ChangeNotifier {
  Company company = Company(
    name: '',
    url: '',
    address: '',
    memo: '',
    wishGrade: WishGrade.high,
    entrySheetList: [EntrySheet(title: '', content: '', length: 0)],
    selectionList: [
      Selection(
        selectionNumber: 99,
        selectionType: SelectionType.unofficialOffer,
        selectionDate: DateTime.now(),
        selectionStatus: SelectionStatus.wait,
      ),
      Selection(
        selectionNumber: 98,
        selectionType: SelectionType.presidentInterview,
        selectionDate: DateTime.now(),
        selectionStatus: SelectionStatus.wait,
      ),
      Selection(
        selectionNumber: 3,
        selectionType: SelectionType.webTest,
        selectionDate: DateTime.now(),
        selectionStatus: SelectionStatus.wait,
      ),
      Selection(
        selectionNumber: 2,
        selectionType: SelectionType.entrySheet,
        selectionDate: DateTime.now(),
        selectionStatus: SelectionStatus.wait,
      ),
      Selection(
        selectionNumber: 1,
        selectionType: SelectionType.entry,
        selectionDate: DateTime.now(),
        selectionStatus: SelectionStatus.wait,
      ),
    ],
  );
  List<String> selectionNameList = ['', '最終選考', '2次選考', '1次選考', ''];

  void selectWishGrade(String select) {
    if (select == EnumConvert.wishGradeToString(company.wishGrade)) return;
    company.wishGrade = EnumConvert.stringToWishGrade(select);
    notifyListeners();
  }

  void changeEntrySheetTitle(String input, int index) {
    company.entrySheetList[index].title = input;
  }

  void changeEntrySheetContent(String input, int index) {
    company.entrySheetList[index].content = input;
    company.entrySheetList[index].length = input.length;
  }

  void addEntrySheet() {
    company.entrySheetList.add(EntrySheet(title: '', content: '', length: 0));
    notifyListeners();
  }

  void removeEntrySheet(int index) {
    if (company.entrySheetList.length == 0) return;
    company.entrySheetList.removeAt(index);
    notifyListeners();
  }

  void addSelection(int index) {
    company.selectionList.insert(
      index,
      Selection(
        selectionNumber: index + 1,
        selectionType: SelectionType.none,
        selectionStatus: SelectionStatus.wait,
        selectionDate: DateTime.now(),
      ),
    );
    selectionNameList.insert(
        index, (company.selectionList.length - 3).toString() + '次選考');
    notifyListeners();
  }

  void removeSelection(int index) {
    if (company.entrySheetList.length == 4) return;
    company.selectionList.removeAt(index);
    selectionNameList.removeAt(index);
    notifyListeners();
  }

  void selectSelectionDate(DateTime date, int index) {
    company.selectionList[index].selectionDate = date;
    notifyListeners();
  }

  void selectSelectionType(String select, int index) {
    company.selectionList[index].selectionType =
        EnumConvert.stringToSelectionType(select);
    notifyListeners();
  }

  Future<void> saveFireStore() async {
    final String studentId = ChangeNotifierModel.studentModel.student.id;
    company.id =
        await FireStoreCompanyApiService().addCompanyData(studentId, company);
    ChangeNotifierModel.companyListModel.addCompanyList(company);
  }
}
