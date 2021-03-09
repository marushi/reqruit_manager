import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/create_request/create_request_model.dart';
import 'package:reqruit_manager/model/enum_model/request_type.dart';
import 'package:reqruit_manager/widget/select_item_widget.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/widget/modal_bottom_sheet_presenter.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:reqruit_manager/model/firebase/request/firestore_request_api_service.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';

class CreateRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          '依頼作成',
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: true,
      ),
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            return Padding(
              padding: AppCommonPadding.pagePadding,
              child: ChangeNotifierProvider.value(
                value: ChangeNotifierModel.createRequestModel,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                            Container(
                              margin: EdgeInsets.only(right: 100),
                              child: Consumer<CreateRequestModel>(
                                  builder: (context, model, _) {
                                return SelectItemWidget(
                                  tapAction: () {
                                    ModalBottomSheetPresenter
                                        .showRequestTypeModalBottomSheet(
                                            context);
                                  },
                                  text: EnumConvert.requestTypeToString(
                                      model.request.requestType),
                                );
                              }),
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
                            '対応者',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 100),
                            child: Consumer<CreateRequestModel>(
                                builder: (context, model, _) {
                              return SelectItemWidget(
                                tapAction: () {
                                  ModalBottomSheetPresenter
                                      .showSelectAdviserModalBottomSheet(
                                          context);
                                },
                                text: model.request.adviserName,
                              );
                            }),
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
                            '希望期限',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 100),
                            child: Consumer<CreateRequestModel>(
                                builder: (context, model, _) {
                              return SelectItemWidget(
                                tapAction: () {
                                  ModalBottomSheetPresenter.showDateTimePicker(
                                      context, null, false);
                                },
                                text: EnumConvert.dateTimeToString(
                                    model.request.studentDeadlineDate),
                              );
                            }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Consumer<CreateRequestModel>(
                          builder: (context, model, _) {
                        return Container(
                          child: getWidget(model.request.requestType),
                        );
                      }),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      IconCornerRadiusButton(
                          buttonText: Text(
                            '依頼を作成する',
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: AppTextSize.subtitleText,
                                fontWeight: FontWeight.bold),
                          ),
                          buttonColor: AppColors.clearRed,
                          tapAction: () {
                            _tapCreateRequestAction(context);
                          }),
                    ]),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getWidget(RequestType requestType) {
    if (requestType == RequestType.es) {
      return Column(
        children: <Widget>[
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
              InputTextField(
                hintText: 'なるべく早めでお願いします。',
                onChanged: (String text) {
                  ChangeNotifierModel.createRequestModel.changeComment(text);
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
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
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 60,
                    child: Text(
                      'お題：',
                      style: TextStyle(
                        fontSize: AppTextSize.standardText,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InputTextField(onChanged: (String text) {
                      ChangeNotifierModel.createRequestModel
                          .changeRequestTitle(text);
                    }),
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
                    width: 60,
                    child: Text(
                      '文字数：',
                      style: TextStyle(
                        fontSize: AppTextSize.standardText,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InputTextField(
                      hintText: '400文字以内',
                      onChanged: (String text) {
                        ChangeNotifierModel.createRequestModel
                            .changeRequestWordCount(text);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              InputTextField(
                hintText: '私が学生時代頑張ったことは4年間続けたアルバイトです・・',
                maxLines: 10,
                onChanged: (String text) {
                  ChangeNotifierModel.createRequestModel
                      .changeEntrySheetContent(text);
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              ConstrainedBox(
                constraints: BoxConstraints.expand(height: 30),
                child: Consumer<CreateRequestModel>(
                  builder: (context, model, _) {
                    return Text(
                      '現在の文字数： ${model.request.requestContentLengths}',
                      style: TextStyle(fontSize: AppTextSize.smallText),
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '依頼内容',
            style: AppTextStyle.subtitleTextStyle,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          InputTextField(
              hintText: 'タイトル',
              onChanged: (String text) {
                ChangeNotifierModel.createRequestModel
                    .changeTellRequestTitle(text);
              }),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          InputTextField(
            hintText: '面接練習をしていただきたいです・・',
            maxLines: 10,
            onChanged: (String text) {
              ChangeNotifierModel.createRequestModel
                  .changeTellRequestContent(text);
            },
          ),
        ],
      );
    }
  }

  void _tapCreateRequestAction(BuildContext context) async {
    final Request request = ChangeNotifierModel.createRequestModel.request;

    if (request.requestType == RequestType.es) {
      if (!Validation().inputRequestValidation(
          request.adviserName,
          request.requestTitle,
          request.requestWordCount,
          request.requestContent,
          context)) return;
    } else {
      if (!Validation().inputTellRequestValidation(
          request.adviserName,
          request.tellRequestTitle,
          request.tellRequestContent,
          context)) return;
    }

    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await FirestoreRequestApiService().setRequestData(context, request);

      ChangeNotifierModel.requestListModel.addRequest(request);

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "依頼完了");

      await Future.delayed(const Duration(seconds: 1));

      ChangeNotifierModel.createRequestModel = CreateRequestModel();

      Navigator.pop(context);
    } catch (error) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
      print(error);
    }
  }
}
