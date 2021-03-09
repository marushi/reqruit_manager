import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/report/report_page_model.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/modal_bottom_sheet_presenter.dart';
import 'package:reqruit_manager/widget/select_item_widget.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          '報告ページ',
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: true,
      ),
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Builder(builder: (context) {
          return Padding(
            padding: AppCommonPadding.pagePadding,
            child: ChangeNotifierProvider.value(
              value: ChangeNotifierModel.reportPageModel,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('報告理由', style: AppTextStyle.titleTextStyle),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Consumer<ReportPageModel>(
                        builder: (context, model, _) {
                          return SelectItemWidget(
                            text: model.report.reason,
                            tapAction: () {
                              ModalBottomSheetPresenter
                                  .showReportReasonModelSheet(context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  IconCornerRadiusButton(
                    buttonText: Text(
                      '報告する',
                      style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold),
                    ),
                    buttonColor: AppColors.clearRed,
                    tapAction: () {
                      _tapAction(context);
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

  void _tapAction(BuildContext context) async {
    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");
    try {
      await ChangeNotifierModel.reportPageModel.postToFireBase();

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "送信完了");

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
    } catch (e) {
      ProgressHud.of(context).dismiss();
      print(e);
      ErrorDialog.showErrorDialog(context, 'エラー', e.toString());
    }
  }
}
