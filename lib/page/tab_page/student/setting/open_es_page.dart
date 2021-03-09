import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/open_es/open_es_model.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/entry_sheet_add_minus_button.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/entry_sheet_item.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class OpenEsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          'オープンES',
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: true,
      ),
      body: ChangeNotifierProvider.value(
        value: ChangeNotifierModel.openEsModel,
        child: Padding(
          padding: AppCommonPadding.pagePadding,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: FutureBuilder(
                    future: _getOpenEs(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<EntrySheet>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length != 0) {
                          return Consumer<OpenEsModel>(
                              builder: (context, model, _) {
                            return model.entrySheetList.length != 0
                                ? ListView.builder(
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: model.entrySheetList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return EntrySheetItem(
                                        openEsModel: model,
                                        index: index,
                                      );
                                    },
                                  )
                                : EntrySheetAddMinusButton(
                                    openEsModel: model,
                                    index: 0,
                                    isEntrySheetCountZero: true,
                                  );
                          });
                        }
                        return Container();
                      } else if (snapshot.connectionState !=
                          ConnectionState.done) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 200),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
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
                    _setOpenEsData(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setOpenEsData(BuildContext context) async {
    if (!Validation().inputOpenEsValidation(
        ChangeNotifierModel.openEsModel.entrySheetList, context)) return;

    try {
      await ChangeNotifierModel.openEsModel.setOpenEsData();
      Navigator.pop(context);
    } catch (e) {
      ErrorDialog.showErrorDialog(context, '通信エラー', e.toString());
    }
  }

  Future<List<EntrySheet>> _getOpenEs() async {
    await ChangeNotifierModel.openEsModel.getOpenEsData();

    return ChangeNotifierModel.openEsModel.entrySheetList;
  }
}
