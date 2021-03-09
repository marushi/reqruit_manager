import 'dart:ui';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';
import 'package:reqruit_manager/model/request_list/request_list_model.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/widget/select_item_widget.dart';
import 'package:reqruit_manager/widget/modal_bottom_sheet_presenter.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';

class TellRequestDetailPage extends StatelessWidget {
  final int index;

  TellRequestDetailPage({this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          '依頼詳細',
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
              child: ChangeNotifierProvider.value(
                value: ChangeNotifierModel.requestListModel,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '依頼者',
                              style: AppTextStyle.subtitleTextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 100),
                              child: Text(
                                ChangeNotifierModel.requestListModel
                                    .requestList[index].studentName,
                              ),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '依頼種別',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: EnumConvert.requestTypeToColor(
                                      ChangeNotifierModel.requestListModel
                                          .requestList[index].requestType),
                                  padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(EnumConvert.requestTypeToIconData(
                                          ChangeNotifierModel.requestListModel
                                              .requestList[index].requestType)),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Text(
                                        EnumConvert.requestTypeToString(
                                            ChangeNotifierModel
                                                .requestListModel
                                                .requestList[index]
                                                .requestType),
                                        style: AppTextStyle.subtitleTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                            '回答期限',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 100),
                            child: Text(
                              EnumConvert.dateTimeToString(ChangeNotifierModel
                                  .requestListModel
                                  .requestList[index]
                                  .studentDeadlineDate),
                            ),
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
                            'コメント',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(ChangeNotifierModel.requestListModel
                              .requestList[index].requestComment),
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
                            '電話対応',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'タイトル',
                                  style: TextStyle(
                                    fontSize: AppTextSize.standardText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(ChangeNotifierModel.requestListModel
                                  .requestList[index].tellRequestTitle),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            '依頼内容',
                            style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(ChangeNotifierModel.requestListModel
                              .requestList[index].tellRequestContent),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        '回答期限',
                        style: AppTextStyle.subtitleTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 100),
                        child: Consumer<RequestListModel>(
                            builder: (context, model, _) {
                          return SelectItemWidget(
                            tapAction: () {
                              ModalBottomSheetPresenter.showDateTimePicker(
                                  context, index, false);
                            },
                            text: EnumConvert.dateTimeToString(
                                model.requestList[index].adviserDeadlineDate),
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      IconCornerRadiusButton(
                          buttonText: Text(
                            '回答する',
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: AppTextSize.subtitleText,
                                fontWeight: FontWeight.bold),
                          ),
                          buttonColor: AppColors.clearRed,
                          tapAction: () {
                            _tapAnswerButtonAction(context);
                          }),
                    ]),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _tapAnswerButtonAction(BuildContext context) async {
    final Request request =
        ChangeNotifierModel.requestListModel.requestList[index];

    if (!Validation().inputDeadLineValidation(request, context)) return;

    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await ChangeNotifierModel.requestListModel
          .setAdviserDeadlineAndStatus(RequestStatus.doing, index);

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "返信完了");

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
    } catch (error) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
      print(error);
    }
  }
}
