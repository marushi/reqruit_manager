import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/firebase/user/firestore_user_api_service.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';

class OpenEsModel extends ChangeNotifier {
  List<EntrySheet> entrySheetList = [
    EntrySheet(
      title: '',
      content: '',
      length: 0,
    ),
  ];

  Future<void> getOpenEsData() async {
    try {
      entrySheetList = await FireStoreUserApiService().getOpenEsData();
      if (entrySheetList.length == 0) {
        entrySheetList = [
          EntrySheet(
            title: '',
            content: '',
            length: 0,
          ),
        ];
      } else {}
      return;
    } catch (e) {
      entrySheetList = [
        EntrySheet(
          title: '',
          content: '',
          length: 0,
        ),
      ];
    }
  }

  void changeEntrySheetTitle(String input, int index) {
    entrySheetList[index].title = input;
    notifyListeners();
  }

  void changeEntrySheetContent(String input, int index) {
    entrySheetList[index].content = input;
    entrySheetList[index].length = input.length;
    notifyListeners();
  }

  void addEntrySheet() {
    entrySheetList.add(EntrySheet(title: '', content: '', length: 0));
    notifyListeners();
  }

  void removeEntrySheet(int index) {
    if (entrySheetList.length == 0) return;
    entrySheetList.removeAt(index);
    notifyListeners();
  }

  Future<void> setOpenEsData() async {
    entrySheetList.forEach((entrySheet) async {
      await FireStoreUserApiService().setOpenEsData(entrySheet);
    });
  }
}
