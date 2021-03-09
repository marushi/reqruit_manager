import 'package:flutter/cupertino.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/gender.dart';
import 'package:reqruit_manager/model/enum_model/selection_type.dart';
import 'package:reqruit_manager/model/main_model/company.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';
import 'package:reqruit_manager/model/main_model/news.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Validation {
  bool emailAuthValidation(
      String email, String password, BuildContext context) {
    if (email.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'メールアドレスが空白です。');
      return false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'メールアドレスが正しい形式ではありません。');
      return false;
    } else if (password.length <= 5 ||
        !RegExp(r"^[a-z0-9]").hasMatch(password)) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'パスワードは半角英数字6文字以上でお願いします。');
      return false;
    } else {
      return true;
    }
  }

  bool inputStudentValidation(
      String name, Gender gender, String graduationYear, BuildContext context) {
    if (name.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', '名前が空白です。');
      return false;
    } else if (EnumConvert.genderToString(gender) == '選択してください') {
      ErrorDialog.showErrorDialog(context, '入力エラー', '性別が未選択です。');
      return false;
    } else if (graduationYear == '選択してください') {
      ErrorDialog.showErrorDialog(context, '入力エラー', '卒業年が未選択です。');
      return false;
    } else {
      return true;
    }
  }

  bool inputAdviserValidation(
      String name, String adminId, BuildContext context) {
    if (name.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', '名前が空白です。');
      return false;
    } else if (adminId.length <= 5 || !RegExp(r"^[a-z0-9]").hasMatch(adminId)) {
      ErrorDialog.showErrorDialog(
          context, '入力エラー', 'アドバイザーIDは半角英数6文字以上でお願いします。');
      return false;
    } else {
      return true;
    }
  }

  bool inputSnsAccountValidation(
      String snsAccount, String snsAccountName, BuildContext context) {
    if (snsAccount == 'SNS選択') {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'SNSを選択してください。');
      return false;
    } else if (snsAccountName.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'アカウント名を入力してください。');
      return false;
    } else {
      return true;
    }
  }

  bool inputRequestValidation(String adviserName, String requestTitle,
      String wordCount, String requestContent, BuildContext context) {
    if (adviserName == '選択してください。') {
      ErrorDialog.showErrorDialog(context, '入力エラー', '対応者を選択してください。');
      return false;
    } else if (requestTitle.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'お題を入力してください。');
      return false;
    } else if (wordCount.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', '文字数を入力してください。');
      return false;
    } else if (requestContent.isEmpty) {
      ErrorDialog.showErrorDialog(context, "入力エラー", '内容を入力してください。');
      return false;
    } else {
      return true;
    }
  }

  bool inputCompanyValidation(Company company, BuildContext context) {
    bool isEntrySheetError;
    bool isSelectionError;

    if (company.name.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', '会社名が空白です。');
      return false;
    }

    if (company.entrySheetList.length != 0) {
      // forEachだとbreakできないので、forでやる
      for (var entrySheet in company.entrySheetList) {
        if (entrySheet.title.isEmpty) {
          ErrorDialog.showErrorDialog(
              context, '入力エラー', 'エントリーシートがタイトルが空白のものがあります。');
          isEntrySheetError = true;
          break;
        } else if (entrySheet.content.isEmpty) {
          ErrorDialog.showErrorDialog(
              context, '入力エラー', 'エントリーシートが内容が空白のものがあります。');
          isEntrySheetError = true;
          break;
        } else {
          isEntrySheetError = false;
        }
      }
    } else {
      isEntrySheetError = false;
    }

    // エントリーシートのバリデーションでエラーあり。
    if (isEntrySheetError) return false;

    /// 誕生日(先の日付ならんなんでもよし)
    DateTime preDateTime = DateTime(2100, 12, 21);

    // forEachだとbreakできないので、forでやる
    for (var selection in company.selectionList) {
      if (selection.selectionType == SelectionType.none) {
        ErrorDialog.showErrorDialog(
            context, '入力エラー', '選考のタイプが選択されていない部分があります。');
        isSelectionError = true;
        break;
      }

      // 内定から順に入ってるので前日付より大きいとOUT
      if (selection.selectionDate.millisecondsSinceEpoch >=
          preDateTime.millisecondsSinceEpoch) {
        ErrorDialog.showErrorDialog(context, '入力エラー', '前の選考より日付が早いものがあります。');
        isSelectionError = true;
        break;
      } else {
        preDateTime = selection.selectionDate;
        isSelectionError = false;
      }
    }

    if (isSelectionError) return false;

    return true;
  }

  bool inputOpenEsValidation(
      List<EntrySheet> entrySheetList, BuildContext context) {
    bool isEntrySheetError;

    if (entrySheetList.length != 0) {
      // forEachだとbreakできないので、forでやる
      for (var entrySheet in entrySheetList) {
        if (entrySheet.title.isEmpty) {
          ErrorDialog.showErrorDialog(
              context, '入力エラー', 'エントリーシートがタイトルが空白のものがあります。');
          isEntrySheetError = true;
          break;
        } else if (entrySheet.content.isEmpty) {
          ErrorDialog.showErrorDialog(
              context, '入力エラー', 'エントリーシートが内容が空白のものがあります。');
          isEntrySheetError = true;
          break;
        } else {
          isEntrySheetError = false;
        }
      }
    } else {
      isEntrySheetError = false;
    }

    // エントリーシートのバリデーションでエラーあり。
    if (isEntrySheetError) return false;

    return true;
  }

  Future<bool> inputNewsValidation(News news, BuildContext context) async {
    if (news.title.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'タイトルが空白です。');
      return false;
    } else {
      return true;
    }
  }

  bool inputAnswerValidation(
      String checkedES, String adviserComment, BuildContext context) {
    if (checkedES.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'ESを添削して入力してください。');
      return false;
    } else if (adviserComment.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'コメントを入力してください。');
      return false;
    } else {
      return true;
    }
  }

  bool inputTellRequestValidation(String adviserName, String tellRequestTitle,
      String tellRequestContent, BuildContext context) {
    if (adviserName == '選択してください。') {
      ErrorDialog.showErrorDialog(context, '入力エラー', '対応者を選択してください。');
      return false;
    } else if (tellRequestTitle.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', 'タイトルを入力してください。');
      return false;
    } else if (tellRequestContent.isEmpty) {
      ErrorDialog.showErrorDialog(context, '入力エラー', '依頼内容を入力してください。');
      return false;
    } else {
      return true;
    }
  }

  bool inputDeadLineValidation(Request request, BuildContext context) {
    if (request.adviserDeadlineDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      ErrorDialog.showErrorDialog(context, '入力エラー', '対応日時を現在時刻より遅くしてください');
      return false;
    } else {
      return true;
    }
  }
}
