import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_company/create_company_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/company.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/entry_sheet_add_minus_button.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/entry_sheet_item.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/selection_block_widget.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/modal_bottom_sheet_presenter.dart';
import 'package:reqruit_manager/widget/select_item_widget.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class CreateCompanyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          '会社登録',
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: true,
      ),
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: AppCommonPadding.pagePadding,
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                    value: ChangeNotifierModel.createCompanyModel,
                  ),
                  ChangeNotifierProvider.value(
                    value: ChangeNotifierModel.companyListModel,
                  ),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '会社名',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        InputTextField(
                          hintText: '株式会社XXX',
                          onChanged: (String input) {
                            ChangeNotifierModel
                                .createCompanyModel.company.name = input;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '志望度',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Consumer<CreateCompanyModel>(
                          builder: (context, model, _) {
                            return SelectItemWidget(
                              tapAction: () {
                                ModalBottomSheetPresenter
                                    .showWishGradeModalBottomSheet(context);
                              },
                              text: EnumConvert.wishGradeToString(
                                  model.company.wishGrade),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '会社URL',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        InputTextField(
                          hintText: 'https://wwww.co.jp',
                          onChanged: (String input) {
                            ChangeNotifierModel.createCompanyModel.company.url =
                                input;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '会社住所',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        InputTextField(
                          hintText: '東京都港区赤坂8-8-88',
                          onChanged: (String input) {
                            ChangeNotifierModel
                                .createCompanyModel.company.address = input;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'メモ',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        InputTextField(
                          onChanged: (String text) {
                            ChangeNotifierModel
                                .createCompanyModel.company.memo = text;
                          },
                          hintText: 'リーダシップがある人材を求めている',
                          maxLines: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Text(
                      '選考',
                      style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Consumer<CreateCompanyModel>(
                      builder: (context, model, _) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: model.company.selectionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SelectionBlockWidget(
                              isHideAddMinusWidget:
                                  _isHideAddButton(model, index),
                              isLast: index ==
                                      model.company.selectionList.length - 1
                                  ? true
                                  : false,
                              isSelect: (index == 0 ||
                                      index ==
                                          model.company.selectionList.length -
                                              1)
                                  ? false
                                  : true,
                              isHideMinus: _isHideMinusButton(model, index),
                              selectionIndex: index,
                              selectionNumberText: index == 1
                                  ? '最終選考'
                                  : (model.company.selectionList.length -
                                              1 -
                                              index)
                                          .toString() +
                                      '次選考:',
                            );
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ES',
                            style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                fontWeight: FontWeight.bold),
                          ),
                          Consumer<CreateCompanyModel>(
                            builder: (context, model, _) {
                              return model.company.entrySheetList.length != 0
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          model.company.entrySheetList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return EntrySheetItem(
                                          createCompanyModel: model,
                                          index: index,
                                        );
                                      },
                                    )
                                  : EntrySheetAddMinusButton(
                                      createCompanyModel: model,
                                      index: 0,
                                      isEntrySheetCountZero: true,
                                    );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          IconCornerRadiusButton(
                            buttonText: Text(
                              '登録する',
                              style: TextStyle(
                                  fontSize: AppTextSize.standardText,
                                  fontWeight: FontWeight.bold),
                            ),
                            buttonColor: AppColors.clearRed,
                            tapAction: () {
                              _tapRegisterButton(context);
                            },
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _tapRegisterButton(BuildContext context) async {
    final Company company = ChangeNotifierModel.createCompanyModel.company;

    if (!Validation().inputCompanyValidation(company, context)) return;

    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await ChangeNotifierModel.createCompanyModel.saveFireStore();

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "登録完了");

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
    } catch (e) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
      print('更新失敗');
    }
  }

  bool _isHideAddButton(CreateCompanyModel model, int index) {
    switch (model.company.selectionList[index].selectionNumber) {
      case 1:
        return true;
      case 2:
        // 4つになった時はプラスだけ出す
        if (model.company.selectionList.length == 4) {
          return false;
        } else {
          return true;
        }
        break;
      case 98:
        return true;
      case 99:
        return true;
      default:
        return false;
    }
  }

  bool _isHideMinusButton(CreateCompanyModel model, int index) {
    if (model.company.selectionList.length == 4 &&
        model.company.selectionList[index].selectionNumber == 2) {
      return true;
    } else {
      return false;
    }
  }
}
