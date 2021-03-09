import 'dart:ui';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';

class TellRequestReplyPage extends StatelessWidget {
  final int index;
  final bool isStudent;

  TellRequestReplyPage({this.index, this.isStudent = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          EnumConvert.requestStatusToReplyTitleText(ChangeNotifierModel
              .requestListModel.requestList[index].requestStatus),
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
                        padding: EdgeInsets.only(top: 20),
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
                        padding: EdgeInsets.only(top: 20),
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
                                  .adviserDeadlineDate),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '依頼内容',
                              style: AppTextStyle.subtitleTextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 90,
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
                          ]),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      if (ChangeNotifierModel.requestListModel
                              .requestList[index].requestStatus ==
                          RequestStatus.doing)
                        IconCornerRadiusButton(
                            buttonText: Text(
                              '対応済みにする',
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: AppTextSize.subtitleText,
                                  fontWeight: FontWeight.bold),
                            ),
                            buttonColor: AppColors.clearRed,
                            tapAction: () {
                              _tapAnswerButton(context);
                            }),
                    ]),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _tapAnswerButton(BuildContext context) async {
    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await ChangeNotifierModel.requestListModel
          .setCheckedESAndAdviserComment(RequestStatus.finish, index);

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "対応済み");

      await await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
    } catch (error) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
      print(error);
    }
  }
}
