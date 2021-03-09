import 'dart:ui';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';

class EntrySheetRequestReplyPage extends StatelessWidget {
  final int index;
  final bool isStudent;

  EntrySheetRequestReplyPage({this.index, this.isStudent = false});

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
                            isStudent
                                ? Text(
                                    '対応者',
                                    style: AppTextStyle.subtitleTextStyle,
                                  )
                                : Text(
                                    '依頼者',
                                    style: AppTextStyle.subtitleTextStyle,
                                  ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            isStudent
                                ? Container(
                                    margin: EdgeInsets.only(right: 100),
                                    child: Text(
                                      ChangeNotifierModel.requestListModel
                                          .requestList[index].studentName,
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(right: 100),
                                    child: Text(
                                      ChangeNotifierModel.requestListModel
                                          .requestList[index].adviserName,
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText),
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
                            padding: EdgeInsets.only(top: 10),
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
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 100),
                            child: Text(
                              ChangeNotifierModel.requestListModel
                                          .requestList[index].requestStatus !=
                                      RequestStatus.newRequest
                                  ? EnumConvert.dateTimeToString(
                                      ChangeNotifierModel
                                          .requestListModel
                                          .requestList[index]
                                          .adviserDeadlineDate)
                                  : "未回答",
                              style:
                                  TextStyle(fontSize: AppTextSize.standardText),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ES',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 90,
                                child: Text(
                                  'お題：',
                                  style: TextStyle(
                                    fontSize: AppTextSize.standardText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                    ChangeNotifierModel.requestListModel
                                        .requestList[index].requestTitle,
                                    style: TextStyle(
                                        fontSize: AppTextSize.standardText)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 90,
                                child: Text(
                                  '文字数：',
                                  style: TextStyle(
                                    fontSize: AppTextSize.standardText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                    '${ChangeNotifierModel.requestListModel.requestList[index].requestWordCount} 字以内',
                                    style: TextStyle(
                                        fontSize: AppTextSize.standardText)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              '内容：',
                              style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                              ChangeNotifierModel.requestListModel
                                  .requestList[index].requestContent,
                              style: TextStyle(
                                  fontSize: AppTextSize.standardText)),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          ChangeNotifierModel.requestListModel
                                      .requestList[index].requestStatus ==
                                  RequestStatus.doing
                              ? ConstrainedBox(
                                  constraints:
                                      BoxConstraints.expand(height: 30),
                                  child: Text(
                                    '入力文字数： ${ChangeNotifierModel.requestListModel.requestList[index].requestContent.length}',
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ChangeNotifierModel.requestListModel
                                      .requestList[index].requestStatus ==
                                  RequestStatus.newRequest
                              ? Container()
                              : Text(
                                  '添削後ES',
                                  style: AppTextStyle.subtitleTextStyle,
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          requestStatusToReplyESWidget(ChangeNotifierModel
                              .requestListModel
                              .requestList[index]
                              .requestStatus),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          ChangeNotifierModel.requestListModel
                                      .requestList[index].requestStatus ==
                                  RequestStatus.newRequest
                              ? Container()
                              : Text(
                                  'コメント',
                                  style: AppTextStyle.subtitleTextStyle,
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          requestStatusToReplyCommentWidget(ChangeNotifierModel
                              .requestListModel
                              .requestList[index]
                              .requestStatus),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      if (ChangeNotifierModel.requestListModel
                              .requestList[index].requestStatus ==
                          RequestStatus.doing)
                        isStudent
                            ? Container()
                            : IconCornerRadiusButton(
                                buttonText: Text(
                                  '回答する',
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
    final Request request =
        ChangeNotifierModel.requestListModel.requestList[index];

    if (!Validation().inputAnswerValidation(
        request.checkedES, request.adviserComment, context)) return;

    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await ChangeNotifierModel.requestListModel
          .setCheckedESAndAdviserComment(RequestStatus.finish, index);

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "回答完了");

      await await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
    } catch (error) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
      print(error);
    }
  }

  Widget requestStatusToReplyESWidget(RequestStatus requestStatus) {
    switch (requestStatus) {
      case RequestStatus.doing:
        return InputTextField(
          hintText: '',
          maxLines: 10,
          onChanged: (String text) {
            ChangeNotifierModel.requestListModel.changeCheckedES(text, index);
          },
        );
      case RequestStatus.finish:
        return Text(
            ChangeNotifierModel.requestListModel.requestList[index].checkedES);
      case RequestStatus.newRequest:
        return Container();
      default:
        return null;
    }
  }

  Widget requestStatusToReplyCommentWidget(RequestStatus requestStatus) {
    switch (requestStatus) {
      case RequestStatus.doing:
        return InputTextField(
          hintText: '',
          onChanged: (String text) {
            ChangeNotifierModel.requestListModel.changeComment(text, index);
          },
        );
      case RequestStatus.finish:
        return Text(
            ChangeNotifierModel
                .requestListModel.requestList[index].adviserComment,
            style: TextStyle(fontSize: AppTextSize.standardText));
      case RequestStatus.newRequest:
        return Container();
      default:
        return null;
    }
  }
}
