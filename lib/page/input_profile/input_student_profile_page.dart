import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/student_model.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/student_tab_category.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/page/tab_page/student/student_tab_bar_controller.dart';
import 'package:reqruit_manager/widget/corner_radius_item.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/modal_bottom_sheet_presenter.dart';
import 'package:reqruit_manager/widget/radius_border_container.dart';
import 'package:reqruit_manager/widget/search_adviser_dialog.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class InputStudentProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: SimpleAppBar(
        titleText: Text(
          'プロフィール入力',
          style: AppTextStyle.titleTextStyle,
        ),
        isShowBackButton: true,
      ),
      backgroundColor: AppColors.white,
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Center(
          child: Builder(builder: (context) {
            return Padding(
              padding: AppCommonPadding.pagePadding,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ChangeNotifierProvider.value(
                      value: ChangeNotifierModel.studentModel,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '名前',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CornerRadiusItem(
                                      backgroundColor: AppColors.backgroundRed,
                                      text: '必須',
                                      textColor: AppColors.white,
                                      textSize: AppTextSize.smallText,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                ),
                                InputTextField(
                                  keyboardType: TextInputType.text,
                                  hintText: '名前',
                                  onChanged: (String text) {
                                    ChangeNotifierModel
                                        .studentModel.student.name = text;
                                  },
                                ),
                              ]),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '性別',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CornerRadiusItem(
                                      backgroundColor: AppColors.backgroundRed,
                                      text: '必須',
                                      textColor: AppColors.white,
                                      textSize: AppTextSize.smallText,
                                    ),
                                  ],
                                ),
                                Consumer<StudentModel>(
                                  builder: (context, model, _) {
                                    return RadiusBorderContainer(
                                      tapAction: () {
                                        ModalBottomSheetPresenter
                                            .showSexModalBottomSheet(context);
                                      },
                                      displayText: EnumConvert.genderToString(
                                          model.student.gender),
                                    );
                                  },
                                ),
                              ]),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '卒業年',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CornerRadiusItem(
                                      backgroundColor: AppColors.backgroundRed,
                                      text: '必須',
                                      textColor: AppColors.white,
                                      textSize: AppTextSize.smallText,
                                    ),
                                  ],
                                ),
                                Consumer<StudentModel>(
                                    builder: (context, model, _) {
                                  return RadiusBorderContainer(
                                    tapAction: () {
                                      ModalBottomSheetPresenter
                                          .showGraduateModalBottomSheet(
                                              context);
                                    },
                                    displayText: model.student.graduationYear,
                                  );
                                }),
                              ]),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '大学(学部・学科)',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CornerRadiusItem(
                                      backgroundColor:
                                          AppColors.backgroundDarkGray,
                                      text: '任意',
                                      textColor: AppColors.white,
                                      textSize: AppTextSize.smallText,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                ),
                                InputTextField(
                                  keyboardType: TextInputType.text,
                                  hintText: '○○大学 △△学部 □□学科',
                                  onChanged: (String text) {
                                    ChangeNotifierModel
                                        .studentModel.student.college = text;
                                  },
                                ),
                              ]),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'アドバイザーを検索する',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CornerRadiusItem(
                                      backgroundColor:
                                          AppColors.backgroundDarkGray,
                                      text: '任意',
                                      textColor: AppColors.white,
                                      textSize: AppTextSize.smallText,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                ),
                                IconCornerRadiusButton(
                                  buttonText: Text(
                                    'アドバイザーを検索する',
                                    style: TextStyle(
                                        fontSize: AppTextSize.standardText,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  buttonColor: AppColors.clearGreen,
                                  tapAction: () {
                                    SearchAdviserDialog.showSearchAdviserDialog(
                                        context,
                                        isProfileSetting: true);
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3),
                                ),
                                Text(
                                  '※本アプリはアドバイザーをつけることで、\nより便利に使用することができます。',
                                  style: TextStyle(
                                      fontSize: AppTextSize.smallText,
                                      color: AppColors.backgroundRed),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                    IconCornerRadiusButton(
                      buttonText: Text(
                        'アカウントを作成する',
                        style: TextStyle(
                            fontSize: AppTextSize.standardText,
                            fontWeight: FontWeight.bold),
                      ),
                      buttonColor: AppColors.clearRed,
                      tapAction: () {
                        _tapCreateAction(context);
                      },
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _tapCreateAction(BuildContext context) async {
    final Student student = ChangeNotifierModel.studentModel.student;

    if (!Validation().inputStudentValidation(
        student.name, student.gender, student.graduationYear, context)) return;

    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await ChangeNotifierModel.studentModel.saveFireStore();

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "登録完了");

      SharedPreferencesServices().saveAccountType(AccountType.student);

      await Future.delayed(const Duration(seconds: 1));

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: StudentTabBarController(
                initialTabPage: StudentTabCategory.selection,
              )));
    } catch (e) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
    }
  }
}
