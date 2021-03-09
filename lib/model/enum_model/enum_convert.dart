import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/enum_model/gender.dart';
import 'package:reqruit_manager/model/enum_model/selection_status.dart';
import 'package:reqruit_manager/model/enum_model/selection_type.dart';
import 'package:reqruit_manager/model/enum_model/sns_type.dart';
import 'package:reqruit_manager/model/enum_model/wish_grade.dart';
import 'package:reqruit_manager/model/enum_model/request_type.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';

class EnumConvert {
  static String genderToString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return '男性';
      case Gender.female:
        return '女性';
      case Gender.none:
        return 'その他';
      default:
        return '';
    }
  }

  static Gender stringToGender(String genderString) {
    switch (genderString) {
      case '男性':
        return Gender.male;
      case '女性':
        return Gender.female;
      case 'その他':
        return Gender.none;
      default:
        return null;
    }
  }

  static String accountTypeToString(AccountType accountType) {
    switch (accountType) {
      case AccountType.adviser:
        return 'adviser';
      case AccountType.student:
        return 'student';
      default:
        return '';
    }
  }

  static AccountType stringToAccountType(String accountTypeString) {
    switch (accountTypeString) {
      case 'adviser':
        return AccountType.adviser;
      case 'student':
        return AccountType.student;
      default:
        return null;
    }
  }

  static String snsTypeToString(SnsType snsType) {
    switch (snsType) {
      case SnsType.line:
        return 'LINE';
      case SnsType.twitter:
        return 'Twitter';
      case SnsType.slack:
        return 'Slack';
      case SnsType.facebook:
        return 'Facebook';
      default:
        return '';
    }
  }

  static SnsType stringToSnsType(String snsTypeString) {
    switch (snsTypeString) {
      case 'LINE':
        return SnsType.line;
      case 'Twitter':
        return SnsType.twitter;
      case 'Slack':
        return SnsType.slack;
      case 'Facebook':
        return SnsType.facebook;
      default:
        return null;
    }
  }

  static String wishGradeToString(WishGrade wishGrade) {
    switch (wishGrade) {
      case WishGrade.high:
        return '高';
      case WishGrade.middle:
        return '中';
      case WishGrade.low:
        return '低';
      default:
        return '';
    }
  }

  static WishGrade stringToWishGrade(String wishGradeString) {
    switch (wishGradeString) {
      case '高':
        return WishGrade.high;
      case '中':
        return WishGrade.middle;
      case '低':
        return WishGrade.low;
      default:
        return null;
    }
  }

  static Color wishGradeToColor(WishGrade wishGrade) {
    switch (wishGrade) {
      case WishGrade.high:
        return AppColors.clearRed;
      case WishGrade.middle:
        return AppColors.clearGreen;
      case WishGrade.low:
        return AppColors.clearBlue;
      default:
        return AppColors.white;
    }
  }

  static String requestTypeToString(RequestType requestType) {
    switch (requestType) {
      case RequestType.es:
        return 'ES添削';
      case RequestType.tell:
        return '電話対応';
      default:
        return null;
    }
  }

  static RequestType stringToRequestType(String requestTypeString) {
    switch (requestTypeString) {
      case 'ES添削':
        return RequestType.es;
      case '電話対応':
        return RequestType.tell;
      default:
        return null;
    }
  }

  static String dateTimeToString(DateTime date) {
    initializeDateFormatting("ja_JP");
    var formatter = new DateFormat('yyyy/MM/dd (E) HH:ss', "ja_JP");
    var formatted = formatter.format(date);
    return formatted;
  }

  static DateTime stringToDateTime(String dateTimeString) {
    DateTime datetime = DateTime.parse(dateTimeString);
    return datetime;
  }

  static String selectionTypeToString(SelectionType selectionType) {
    switch (selectionType) {
      case SelectionType.entry:
        return 'エントリー';
      case SelectionType.entrySheet:
        return 'ES提出';
      case SelectionType.webTest:
        return 'WEBテスト';
      case SelectionType.groupInterview:
        return '集団面接';
      case SelectionType.personalInterview:
        return '個人面接';
      case SelectionType.presentation:
        return 'プレゼン';
      case SelectionType.test:
        return '筆記テスト';
      case SelectionType.groupDiscussion:
        return 'グルディス';
      case SelectionType.officerInterview:
        return '役員面接';
      case SelectionType.presidentInterview:
        return '社長面接';
      case SelectionType.unofficialOffer:
        return '内定';
      default:
        return '';
    }
  }

  static SelectionType stringToSelectionType(String selectionTypeString) {
    switch (selectionTypeString) {
      case 'エントリー':
        return SelectionType.entry;
      case 'ES提出':
        return SelectionType.entrySheet;
      case 'WEBテスト':
        return SelectionType.webTest;
      case '集団面接':
        return SelectionType.groupInterview;
      case '個人面接':
        return SelectionType.personalInterview;
      case 'プレゼン':
        return SelectionType.presentation;
      case '筆記テスト':
        return SelectionType.test;
      case 'グルディス':
        return SelectionType.groupDiscussion;
      case '役員面接':
        return SelectionType.officerInterview;
      case '社長面接':
        return SelectionType.presidentInterview;
      case '内定':
        return SelectionType.unofficialOffer;
      default:
        return SelectionType.none;
    }
  }

  static String selectionStatusToString(SelectionStatus selectionStatus) {
    switch (selectionStatus) {
      case SelectionStatus.wait:
        return '未選考';
      case SelectionStatus.now:
        return '選考中';
      case SelectionStatus.pass:
        return '通過';
      case SelectionStatus.miss:
        return '終了';
      case SelectionStatus.decline:
        return '辞退';
      default:
        return '';
    }
  }

  static SelectionStatus stringToSelectionStatus(String selectionStatusString) {
    switch (selectionStatusString) {
      case '未選考':
        return SelectionStatus.wait;
      case '選考中':
        return SelectionStatus.now;
      case '通過':
        return SelectionStatus.pass;
      case '終了':
        return SelectionStatus.miss;
      case '辞退':
        return SelectionStatus.decline;
      default:
        return null;
    }
  }

  static IconData requestTypeToIconData(RequestType requestType) {
    switch (requestType) {
      case RequestType.es:
        return Icons.edit;
      case RequestType.tell:
        return Icons.phone_in_talk;
      default:
        return null;
    }
  }

  static Color requestTypeToColor(RequestType requestType) {
    switch (requestType) {
      case RequestType.es:
        return Color.fromRGBO(240, 144, 141, 1);
      case RequestType.tell:
        return Color.fromRGBO(178, 255, 178, 1);
      default:
        return null;
    }
  }

  static String requestStatusToString(RequestStatus requestStatus) {
    switch (requestStatus) {
      case RequestStatus.newRequest:
        return '未対応';
      case RequestStatus.doing:
        return '対応中';
      case RequestStatus.finish:
        return '対応済み';
      default:
        return null;
    }
  }

  static RequestStatus stringToRequestStatus(String requestStatusString) {
    switch (requestStatusString) {
      case '未対応':
        return RequestStatus.newRequest;
      case '対応中':
        return RequestStatus.doing;
      case '対応済み':
        return RequestStatus.finish;
      default:
        return null;
    }
  }

  static String requestStatusToReplyTitleText(RequestStatus requestStatus) {
    switch (requestStatus) {
      case RequestStatus.doing:
        return '依頼(対応中)';
      case RequestStatus.finish:
        return '依頼(対応済み)';
      case RequestStatus.newRequest:
        return '依頼(未対応)';
      default:
        return null;
    }
  }

  static Color genderToColor(Gender gender) {
    switch (gender) {
      case Gender.male:
        return AppColors.clearBlue;
      case Gender.female:
        return AppColors.clearRed;
      default:
        return AppColors.darkGray;
    }
  }
}
