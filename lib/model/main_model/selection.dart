import 'package:reqruit_manager/model/enum_model/selection_status.dart';
import 'package:reqruit_manager/model/enum_model/selection_type.dart';

class Selection {
  String id;
  int selectionNumber;
  SelectionType selectionType;
  DateTime selectionDate;
  SelectionStatus selectionStatus;
  DateTime completeDate;

  Selection({
    this.id,
    this.selectionNumber,
    this.selectionType,
    this.completeDate,
    this.selectionStatus,
    this.selectionDate,
  });
}
