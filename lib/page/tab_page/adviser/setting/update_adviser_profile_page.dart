import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/advider_model.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/widget/corner_radius_item.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class UpdateAdviserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: SimpleAppBar(
        titleText: Text(
          'プロフィール更新',
          style: AppTextStyle.titleTextStyle,
        ),
        isShowBackButton: true,
      ),
      backgroundColor: AppColors.white,
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Builder(builder: (context) {
          return Padding(
            padding: AppCommonPadding.pagePadding,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ChangeNotifierProvider.value(
                        value: ChangeNotifierModel.adviserModel,
                        child: Consumer<AdviserModel>(
                          builder: (context, model, _) {
                            return InkWell(
                              onTap: ChangeNotifierModel
                                  .adviserModel.selectProfileImage,
                              child: Center(
                                  child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(75),
                                      image: DecorationImage(
                                          image: model.fileImage == null
                                              ? AssetImage(
                                                  'assets/images/no_image.png')
                                              : model.fileImage,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  Text(
                                    'プロフィール写真を選択する',
                                    style: TextStyle(
                                        fontSize: AppTextSize.standardText,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.linkBlue),
                                  ),
                                ],
                              )),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              controller: TextEditingController(
                                  text: ChangeNotifierModel
                                      .adviserModel.adviser.name),
                              onChanged: (String text) {
                                ChangeNotifierModel.adviserModel.adviser.name =
                                    text;
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'アドバイザーID',
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
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'adviser01',
                              controller: TextEditingController(
                                  text: ChangeNotifierModel
                                      .adviserModel.adviser.adminId),
                              onChanged: (String text) {
                                ChangeNotifierModel
                                    .adviserModel.adviser.adminId = text;
                              },
                            ),
                            Text(
                              '※就活生に検索してもらうためのIDです',
                              style: TextStyle(
                                  fontSize: AppTextSize.smallText,
                                  color: AppColors.backgroundRed),
                            ),
                            Text(
                              '※半角英数6文字以上の入力をお願いします',
                              style: TextStyle(
                                  fontSize: AppTextSize.smallText,
                                  color: AppColors.backgroundRed),
                            ),
                          ]),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  IconCornerRadiusButton(
                    buttonText: Text(
                      'プロフィールを更新する',
                      style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold),
                    ),
                    buttonColor: AppColors.clearGreen,
                    tapAction: () {
                      _tapCreateAction(context);
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _tapCreateAction(BuildContext context) async {
    if (!Validation().inputAdviserValidation(
        ChangeNotifierModel.adviserModel.adviser.name,
        ChangeNotifierModel.adviserModel.adviser.adminId,
        context)) return;

    if (await ChangeNotifierModel.adviserModel.searchAdviser()) {
      ErrorDialog.showErrorDialog(context, '重複エラー', 'すでにそのアドバイザーIDは使われています。');
      return;
    }

    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await ChangeNotifierModel.adviserModel.saveFireStore();

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "更新完了");

      SharedPreferencesServices().saveAccountType(AccountType.adviser);

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
    } catch (e) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
    }
  }
}
