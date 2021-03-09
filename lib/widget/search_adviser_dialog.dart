import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/search_adviser/search_adviser_dialog_model.dart';
import 'package:reqruit_manager/model/enum_model/data_load_type.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/firebase/user/firestore_user_api_service.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/modal_bottom_sheet_presenter.dart';
import 'package:reqruit_manager/widget/select_item_widget.dart';

class SearchAdviserDialog extends StatelessWidget {
  final adminTextController = TextEditingController();
  final snsTextController = TextEditingController();
  final bool _isProfileSetting;

  /// コンストラクタ
  SearchAdviserDialog({
    bool isProfileSetting,
    Function onTapAction,
  }) : this._isProfileSetting = isProfileSetting;

  /// エラー簡易表示
  static Future<void> showSearchAdviserDialog(BuildContext context,
      {bool isProfileSetting = false, void Function() onTapAction}) async {
    // ダイアログ表示
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SearchAdviserDialog(
            onTapAction: onTapAction,
            isProfileSetting: isProfileSetting,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'アドバイザーを探す',
          style: TextStyle(
              fontSize: AppTextSize.titleText, fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        child: ChangeNotifierProvider.value(
          value: ChangeNotifierModel.searchAdviserDialogModel,
          child: Consumer<SearchAdviserDialogModel>(
            builder: (context, model, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  model.searchStatus != DataLoadType.success
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'アドバイザーID',
                              style: AppTextStyle.subtitleTextStyle,
                            ),
                            InputTextField(
                              hintText: 'アドバイザーのIDを入力',
                              controller: adminTextController,
                            ),
                          ],
                        )
                      : Container(),
                  displayWidget(context, model),
                  model.searchStatus != DataLoadType.success
                      ? IconCornerRadiusButton(
                          buttonText: Text(
                            '検索する',
                            style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                fontWeight: FontWeight.bold),
                          ),
                          buttonColor: AppColors.circleRed,
                          tapAction: () {
                            ChangeNotifierModel.searchAdviserDialogModel
                                .searchAdviser(adminTextController.text);
                          },
                        )
                      : Container(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget displayWidget(BuildContext context, SearchAdviserDialogModel model) {
    switch (model.searchStatus) {
      case DataLoadType.none:
        return Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
      case DataLoadType.success:
        return Center(
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: NetworkImage(model.adviser.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                    ),
                    Text(
                      model.adviser.name,
                      style: AppTextStyle.subtitleTextStyle,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '選考状況を公開する',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '※後ほど変更も可能です。',
                          style: TextStyle(
                              fontSize: AppTextSize.smallText,
                              color: AppColors.darkGray),
                        )
                      ],
                    ),
                    CupertinoSwitch(
                      value: model.adviser.isOpenSelection,
                      onChanged: (bool value) {
                        model.changeSwitchState(value);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 110,
                      height: 40,
                      child: SelectItemWidget(
                        text: model.snsAccount,
                        tapAction: () {
                          ModalBottomSheetPresenter.showSnsModalBottomSheet(
                              context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 250,
                      height: 40,
                      child: InputTextField(
                        hintText: 'アカウント名を入力',
                        controller: snsTextController,
                        onChanged: (String text) {
                          model.changeSnsAccountName(text);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Center(
                  child: IconCornerRadiusButton(
                    buttonText: Text(
                      '追加する',
                      style: TextStyle(
                          fontSize: AppTextSize.smallText,
                          fontWeight: FontWeight.bold),
                    ),
                    buttonColor: AppColors.clearGreen,
                    tapAction: () {
                      tapAction(context, model);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      case DataLoadType.miss:
        return Center(
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Icon(
                  Icons.help_outline,
                  size: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'アドバイザーが存在しません。',
                  style: TextStyle(
                    fontSize: AppTextSize.standardText,
                  ),
                ),
                Text(
                  'または',
                  style: TextStyle(
                    fontSize: AppTextSize.standardText,
                  ),
                ),
                Text(
                  '追加済みのアドバイザーです。',
                  style: TextStyle(
                    fontSize: AppTextSize.standardText,
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
    }
  }

  void tapAction(BuildContext context, SearchAdviserDialogModel model) async {
    if (!Validation().inputSnsAccountValidation(
        model.snsAccount, model.snsAccountName, context)) return;

    ChangeNotifierModel.studentModel.student.snsAccount =
        EnumConvert.stringToSnsType(model.snsAccount);
    ChangeNotifierModel.studentModel.student.snsAccountName =
        model.snsAccountName;
    ChangeNotifierModel.studentModel.addAdviser(model.adviser);
    // プロフィール選択画面の場合だけ、通信しない
    if (_isProfileSetting) {
      Navigator.pop(context);
    } else {
      await FireStoreUserApiService().setStudentAdviserData(
          ChangeNotifierModel.studentModel.student.id, model.adviser);

      await FireStoreUserApiService().setAdviserStudentData(
          model.adviser, ChangeNotifierModel.studentModel.student);
      Navigator.pop(context);
    }
  }
}
