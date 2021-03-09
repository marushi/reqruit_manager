import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/request_status.dart';
import 'package:reqruit_manager/model/enum_model/request_type.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/request_list/request_list_model.dart';
import 'package:reqruit_manager/page/tab_page/adviser/request_list/entry_sheet_request_detail_page.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/page/tab_page/adviser/request_list/entry_sheet_request_reply_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/request_list/tell_request_detail_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/request_list/tell_request_reply_page.dart';

class RequestListItem extends StatelessWidget {
  final Request request;
  final int index;
  final bool isAdviser;

  RequestListItem({
    this.request,
    this.index,
    this.isAdviser = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        transitionToRequestDetail(context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 15, 30, 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ChangeNotifierProvider.value(
              value: ChangeNotifierModel.requestListModel,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color:
                          EnumConvert.requestTypeToColor(request.requestType),
                      padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                      child: Row(
                        children: <Widget>[
                          Icon(EnumConvert.requestTypeToIconData(
                              request.requestType)),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                          ),
                          Text(
                            EnumConvert.requestTypeToString(
                                request.requestType),
                            style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Consumer<RequestListModel>(
                        builder: (context, model, _) {
                      return requestStatusToWidget(
                          model.requestList[index].requestStatus);
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isAdviser
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '依頼者：',
                            style: TextStyle(
                                fontSize: AppTextSize.smallText,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${request.studentName}',
                            style: TextStyle(fontSize: AppTextSize.smallText),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '対応者：',
                            style: TextStyle(
                                fontSize: AppTextSize.smallText,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${request.adviserName}',
                            style: TextStyle(fontSize: AppTextSize.smallText),
                          ),
                        ],
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '期限：',
                      style: TextStyle(
                          fontSize: AppTextSize.smallText,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      request.requestStatus != RequestStatus.newRequest
                          ? '${EnumConvert.dateTimeToString(request.adviserDeadlineDate)}'
                          : "未回答",
                      style: TextStyle(fontSize: AppTextSize.smallText),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 遷移が少し複雑なので関数にまとめる
  void transitionToRequestDetail(BuildContext context) {
    if (isAdviser) {
      // ES添削かつ新規作成の場合
      if (request.requestType == RequestType.es &&
          request.requestStatus == RequestStatus.newRequest) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: EntrySheetRequestDetailPage(
                  index: index,
                )));
        // ES添削かつ対応中の場合
      } else if (request.requestType == RequestType.es) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: EntrySheetRequestReplyPage(
                  index: index,
                )));
        // 電話対応かつ新規作成の場合
      } else if (request.requestType == RequestType.tell &&
          request.requestStatus == RequestStatus.newRequest) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TellRequestDetailPage(
                  index: index,
                )));
        // 電話対応かつ対応中の場合
      } else if (request.requestType == RequestType.tell) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TellRequestReplyPage(
                  index: index,
                )));
      }
    } else {
      if (request.requestType == RequestType.es) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: EntrySheetRequestReplyPage(
                  index: index,
                  isStudent: true,
                )));
      } else {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TellRequestReplyPage(
                  index: index,
                )));
      }
    }
  }

  Widget requestStatusToWidget(RequestStatus requestStatus) {
    switch (requestStatus) {
      case RequestStatus.newRequest:
        return isAdviser
            ? ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  color: AppColors.clearRed,
                  child: Text(
                    'NEW',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppTextSize.standardText,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white),
                  ),
                ),
              )
            : Text(
                '依頼中',
                style: TextStyle(
                    fontSize: AppTextSize.standardText,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundRed),
              );
      case RequestStatus.doing:
        return Text(
          '対応中...',
          style: TextStyle(
              fontSize: AppTextSize.standardText,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundRed),
        );
      case RequestStatus.finish:
        return Text(
          '対応済み',
          style: TextStyle(
              fontSize: AppTextSize.standardText,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGray),
        );
      default:
        return null;
    }
  }
}
