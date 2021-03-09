import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/company_list/company_list_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_company/create_company_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/selection_status.dart';
import 'package:reqruit_manager/model/enum_model/selection_type.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/add_minus_widget.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/selection_circle_border.dart';
import 'package:reqruit_manager/widget/corner_radius_item.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/gif_dialog.dart';
import 'package:reqruit_manager/widget/modal_bottom_sheet_presenter.dart';
import 'package:reqruit_manager/widget/select_item_widget.dart';

/// TODO このページが3項演算子多すぎて嫌になっきたので余裕あったら直す。
class SelectionBlockWidget extends StatelessWidget {
  final bool isHideAddMinusWidget;
  final bool isLast;
  final bool isPass;
  final bool isSelect;
  final int selectionIndex;
  final bool isHideMinus;
  final String selectionNumberText;
  final bool isDetail;
  final bool isAdviser;
  final int companyIndex;

  SelectionBlockWidget({
    this.isHideAddMinusWidget = false,
    this.isLast = false,
    this.isPass = false,
    this.isSelect = true,
    this.selectionIndex,
    this.isHideMinus = false,
    this.selectionNumberText = '',
    this.isDetail = false,
    this.isAdviser = false,
    this.companyIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isHideAddMinusWidget
              ? Padding(
                  padding: EdgeInsets.only(left: 15),
                )
              : AddMinusWidget(
                  isHideMinus: isHideMinus,
                  index: selectionIndex,
                ),
          Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          SelectionCircleBorder(
            isLast: isLast,
            isPass: isPass,
            isNow: isDetail
                ? ChangeNotifierModel.companyListModel.companyList[companyIndex]
                        .nextSelection ==
                    ChangeNotifierModel
                        .companyListModel
                        .companyList[companyIndex]
                        .selectionList[selectionIndex]
                        .selectionType
                : false,
            isMiss: isDetail
                ? ChangeNotifierModel.companyListModel.companyList[companyIndex]
                            .selectionList[selectionIndex].selectionStatus ==
                        SelectionStatus.decline ||
                    ChangeNotifierModel
                            .companyListModel
                            .companyList[companyIndex]
                            .selectionList[selectionIndex]
                            .selectionStatus ==
                        SelectionStatus.miss
                : false,
            isComplete: isDetail
                ? ChangeNotifierModel.companyListModel.companyList[companyIndex]
                        .nowSelectionType ==
                    SelectionType.unofficialOffer
                : false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isSelect ? selectionNumberText : '',
                    style: TextStyle(
                        fontSize: AppTextSize.smallText,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: isSelect ? 10 : 0),
                  ),
                  !isDetail
                      ? Consumer<CreateCompanyModel>(
                          builder: (context, model, _) {
                            return isSelect
                                ? SelectItemWidget(
                                    text: EnumConvert.selectionTypeToString(
                                        model
                                            .company
                                            .selectionList[selectionIndex]
                                            .selectionType),
                                    tapAction: () {
                                      ModalBottomSheetPresenter
                                          .showSelectionTypeModalBottomSheet(
                                              context, selectionIndex);
                                    },
                                  )
                                : Text(
                                    EnumConvert.selectionTypeToString(model
                                        .company
                                        .selectionList[selectionIndex]
                                        .selectionType),
                                    style: TextStyle(
                                        fontSize: AppTextSize.smallText,
                                        fontWeight: FontWeight.bold),
                                  );
                          },
                        )
                      : Consumer<CompanyListModel>(
                          builder: (context, model, _) {
                            return isSelect
                                ? SelectItemWidget(
                                    text: EnumConvert.selectionTypeToString(
                                        model
                                            .companyList[companyIndex]
                                            .selectionList[selectionIndex]
                                            .selectionType),
                                    tapAction: () {
                                      ModalBottomSheetPresenter
                                          .showSelectionTypeModalBottomSheet(
                                              context, selectionIndex);
                                    },
                                  )
                                : Text(
                                    EnumConvert.selectionTypeToString(model
                                            .companyList[companyIndex]
                                            .selectionList[selectionIndex]
                                            .selectionType) +
                                        ':',
                                    style: TextStyle(
                                        fontSize: AppTextSize.smallText,
                                        fontWeight: FontWeight.bold),
                                  );
                          },
                        ),
                  isDetail
                      ? Padding(
                          padding: EdgeInsets.only(left: 10),
                        )
                      : Container(),
                  isDetail && isDisplaySelectionButton()
                      ? !isAdviser
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CornerRadiusItem(
                                  backgroundColor: AppColors.clearGreen,
                                  text: '通過',
                                  onTap: () async {
                                    ProgressHud.of(context).show(
                                        ProgressHudType.loading, "loading...");
                                    try {
                                      await ChangeNotifierModel.companyListModel
                                          .changeSelectionStatus(
                                              SelectionStatus.pass,
                                              companyIndex,
                                              selectionIndex);
                                      ProgressHud.of(context).showAndDismiss(
                                          ProgressHudType.success, "通過");
                                    } catch (e) {
                                      ProgressHud.of(context).dismiss();
                                      ErrorDialog.showErrorDialog(
                                          context, '通信エラー', e.toString());
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                CornerRadiusItem(
                                  backgroundColor: AppColors.clearBlue,
                                  text: '辞退',
                                  onTap: () async {
                                    ProgressHud.of(context).show(
                                        ProgressHudType.loading, "loading...");
                                    try {
                                      await ChangeNotifierModel.companyListModel
                                          .changeSelectionStatus(
                                              SelectionStatus.decline,
                                              companyIndex,
                                              selectionIndex);
                                      ProgressHud.of(context).showAndDismiss(
                                          ProgressHudType.error, "辞退");
                                    } catch (e) {
                                      ProgressHud.of(context).dismiss();
                                      ErrorDialog.showErrorDialog(
                                          context, '通信エラー', e.toString());
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                CornerRadiusItem(
                                  backgroundColor: AppColors.circleRed,
                                  text: '不採用',
                                  onTap: () async {
                                    ProgressHud.of(context).show(
                                        ProgressHudType.loading, "loading...");
                                    try {
                                      await ChangeNotifierModel.companyListModel
                                          .changeSelectionStatus(
                                              SelectionStatus.miss,
                                              companyIndex,
                                              selectionIndex);
                                      ProgressHud.of(context).showAndDismiss(
                                          ProgressHudType.error, "不採用");
                                    } catch (e) {
                                      ProgressHud.of(context).dismiss();
                                      ErrorDialog.showErrorDialog(
                                          context, '通信エラー', e.toString());
                                    }
                                  },
                                ),
                              ],
                            )
                          : Container()
                      : Container(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '日時：',
                    style: TextStyle(fontSize: AppTextSize.bottomTabText),
                  ),
                  !isDetail
                      ? Consumer<CreateCompanyModel>(
                          builder: (context, model, _) {
                            return SelectItemWidget(
                              text: EnumConvert.dateTimeToString(model.company
                                  .selectionList[selectionIndex].selectionDate),
                              tapAction: () {
                                ModalBottomSheetPresenter.showDateTimePicker(
                                    context, selectionIndex, true);
                              },
                            );
                          },
                        )
                      : Text(
                          EnumConvert.dateTimeToString(ChangeNotifierModel
                              .companyListModel
                              .companyList[companyIndex]
                              .selectionList[selectionIndex]
                              .selectionDate),
                          style: TextStyle(fontSize: AppTextSize.bottomTabText),
                        ),
                ],
              ),
            ],
          ),
        ]);
  }

  bool isDisplaySelectionButton() {
    // 次回選考が
    if (ChangeNotifierModel
            .companyListModel.companyList[companyIndex].nextSelection ==
        ChangeNotifierModel.companyListModel.companyList[companyIndex]
            .selectionList[selectionIndex].selectionType) {
      if (ChangeNotifierModel.companyListModel.companyList[companyIndex]
              .selectionList[selectionIndex].selectionStatus !=
          SelectionStatus.miss) {
        if (ChangeNotifierModel.companyListModel.companyList[companyIndex]
                .selectionList[selectionIndex].selectionStatus !=
            SelectionStatus.decline) {
          if (ChangeNotifierModel.companyListModel.companyList[companyIndex]
                  .nowSelectionType !=
              SelectionType.unofficialOffer) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
