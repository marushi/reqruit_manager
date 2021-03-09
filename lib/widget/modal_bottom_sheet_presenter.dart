import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';

class ModalBottomSheetPresenter {
  static void showSexModalBottomSheet(BuildContext context) {
    final List<String> gender = ['男性', '女性', 'その他'];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: gender.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(gender[index]),
                onTap: () {
                  ChangeNotifierModel.studentModel
                      .selectGender(EnumConvert.stringToGender(gender[index]));
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showGraduateModalBottomSheet(BuildContext context) {
    final List<String> graduation = ['21卒', '22卒', '23卒', '24卒', '25卒', '26卒'];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: graduation.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(graduation[index]),
                onTap: () {
                  ChangeNotifierModel.studentModel
                      .selectGraduation(graduation[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showSnsModalBottomSheet(BuildContext context) {
    final List<String> sns = [
      'LINE',
      'Twitter',
      'Slack',
      'Facebook',
    ];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: sns.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(sns[index]),
                onTap: () {
                  ChangeNotifierModel.searchAdviserDialogModel
                      .selectSnsAccount(sns[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showWishGradeModalBottomSheet(BuildContext context) {
    final List<String> wishGrade = ['高', '中', '低'];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: wishGrade.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(wishGrade[index]),
                onTap: () {
                  ChangeNotifierModel.createCompanyModel
                      .selectWishGrade(wishGrade[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showSelectionTypeModalBottomSheet(
      BuildContext context, int tapIndex) {
    final List<String> selectionType = [
      'ES提出',
      'WEBテスト',
      'グルディス',
      '筆記テスト',
      'プレゼン',
      '集団面接',
      '個人面接',
      '役員面接',
      '社長面接',
      ''
    ];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: selectionType.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(selectionType[index]),
                onTap: () {
                  ChangeNotifierModel.createCompanyModel
                      .selectSelectionType(selectionType[index], tapIndex);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showDateTimePicker(
      BuildContext context, int tapIndex, bool isSelectionPage) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2030, 12, 31),
      currentTime: DateTime.now(),
      locale: LocaleType.jp,
      theme: DatePickerTheme(
        headerColor: AppColors.white,
        backgroundColor: AppColors.white,
        itemStyle: TextStyle(
            color: AppColors.linkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18),
        doneStyle: TextStyle(color: AppColors.black, fontSize: 16),
        cancelStyle: TextStyle(color: AppColors.darkGray, fontSize: 16),
      ),
      onConfirm: (date) {
        if (isSelectionPage) {
          ChangeNotifierModel.createCompanyModel
              .selectSelectionDate(date, tapIndex);
        } else {
          // DatePicker使う場合はここに確認ボタンを押した時の処理を記述
          ChangeNotifierModel.createRequestModel.changeDeadlineDate(date);
          ChangeNotifierModel.requestListModel
              .selectAdviserDeadlineDate(date, tapIndex);
        }
      },
    );
  }

  static void showRequestTypeModalBottomSheet(BuildContext context) {
    final List<String> request = ['ES添削', '電話対応'];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: request.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(request[index]),
                onTap: () {
                  ChangeNotifierModel.createRequestModel.selectRequestType(
                      EnumConvert.stringToRequestType(request[index]));
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showSelectAdviserModalBottomSheet(BuildContext context) {
    final List<Adviser> adviser =
        ChangeNotifierModel.studentModel.student.adviserList;

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: adviser.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(adviser[index].name),
                onTap: () {
                  ChangeNotifierModel.createRequestModel
                      .selectAdviser(adviser[index].name, adviser[index].id);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showReportReasonModelSheet(BuildContext context) {
    final List<String> reason = [
      '内容に興味がない',
      '不審な内容またはスパムである',
      '不適切または攻撃的な内容を含んでいる',
      '自傷行為や自殺の意思をほのめかしている'
    ];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: reason.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(reason[index]),
                onTap: () {
                  ChangeNotifierModel.reportPageModel
                      .changeReportReason(reason[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
