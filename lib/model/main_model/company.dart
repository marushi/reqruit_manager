import 'package:reqruit_manager/model/enum_model/selection_type.dart';
import 'package:reqruit_manager/model/enum_model/wish_grade.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';
import 'package:reqruit_manager/model/main_model/selection.dart';

class Company {
  /// 会社情報
  String id;
  String name;
  WishGrade wishGrade;
  String url;
  String address;
  String memo;

  /// 選考関係
  List<Selection> selectionList;
  List<EntrySheet> entrySheetList;

  /// 現在選考状況
  String nowSelectionTypeString;
  SelectionType nowSelectionType;
  bool isComplete;
  double percentage;

  /// 次の選考
  SelectionType nextSelection;
  DateTime nextSelectionDate;

  Company({
    this.id,
    this.name,
    this.wishGrade,
    this.url,
    this.address,
    this.memo,
    this.selectionList,
    this.entrySheetList,
    this.nowSelectionTypeString,
    this.nextSelection,
    this.nextSelectionDate,
    this.nowSelectionType,
    this.isComplete,
    this.percentage,
  });
}
