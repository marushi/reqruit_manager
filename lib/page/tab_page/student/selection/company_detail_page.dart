import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/company_list/company_list_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/enum_model/selection_status.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';
import 'package:reqruit_manager/model/main_model/selection.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/selection_block_widget.dart';
import 'package:reqruit_manager/widget/corner_radius_item.dart';
import 'package:reqruit_manager/widget/display_entry_sheet_item.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoder/geocoder.dart';

class CompanyDetailPage extends StatelessWidget {
  final String studentId;
  final bool isAdviser;
  final int companyIndex;

  CompanyDetailPage({
    this.studentId,
    this.isAdviser = false,
    this.companyIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          '会社詳細',
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
                value: ChangeNotifierModel.companyListModel,
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
                        Text(
                          ChangeNotifierModel
                              .companyListModel.companyList[companyIndex].name,
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
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
                        CornerRadiusItem(
                          backgroundColor: EnumConvert.wishGradeToColor(
                              ChangeNotifierModel.companyListModel
                                  .companyList[companyIndex].wishGrade),
                          text: EnumConvert.wishGradeToString(
                              ChangeNotifierModel.companyListModel
                                  .companyList[companyIndex].wishGrade),
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
                        InkWell(
                          onTap: () async {
                            await launch(ChangeNotifierModel.companyListModel
                                .companyList[companyIndex].url);
                          },
                          child: Text(
                            ChangeNotifierModel
                                .companyListModel.companyList[companyIndex].url,
                            style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                color: AppColors.linkBlue),
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
                          '会社住所',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        InkWell(
                          onTap: () {
                            tapAddress(
                                ChangeNotifierModel.companyListModel
                                    .companyList[companyIndex].address,
                                context);
                          },
                          child: Text(
                            ChangeNotifierModel.companyListModel
                                .companyList[companyIndex].address,
                            style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                color: AppColors.linkBlue),
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
                          'メモ',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Text(
                          ChangeNotifierModel
                              .companyListModel.companyList[companyIndex].memo,
                          style: TextStyle(
                            fontSize: AppTextSize.standardText,
                          ),
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
                    FutureBuilder(
                      future: _getSelectionData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Selection>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return Consumer<CompanyListModel>(
                                builder: (context, model, _) {
                              return ListView.builder(
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: model.companyList[companyIndex]
                                    .selectionList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SelectionBlockWidget(
                                    isHideAddMinusWidget: true,
                                    isSelect: false,
                                    isPass: model
                                            .companyList[companyIndex]
                                            .selectionList[index]
                                            .selectionStatus ==
                                        SelectionStatus.pass,
                                    isLast: index ==
                                            model.companyList[companyIndex]
                                                    .selectionList.length -
                                                1
                                        ? true
                                        : false,
                                    selectionIndex: index,
                                    isDetail: true,
                                    isAdviser: isAdviser,
                                    companyIndex: companyIndex,
                                  );
                                },
                              );
                            });
                          }
                          return Container();
                        } else if (snapshot.connectionState !=
                            ConnectionState.done) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50),
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
                          FutureBuilder(
                            future: _getEntrySheetData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<EntrySheet>> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length != 0) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return DisplayEntrySheetItem(
                                        entrySheet: snapshot.data[index],
                                      );
                                    },
                                  );
                                }
                                return Container();
                              } else if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 50),
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

  void tapAddress(String address, BuildContext context) async {
    try {
      var _results = await Geocoder.local.findAddressesFromQuery(address);
      final double _latitude = _results.first.coordinates.latitude;
      final double _longitude = _results.first.coordinates.longitude;
      final String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$_latitude,$_longitude';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    } catch (e) {
      ErrorDialog.showErrorDialog(context, 'エラー', '住所の形式が正しくありません');
    }
  }

  Future<List<Selection>> _getSelectionData() async {
    await ChangeNotifierModel.companyListModel
        .getSelectionList(studentId, companyIndex);
    return Future.value(ChangeNotifierModel
        .companyListModel.companyList[companyIndex].selectionList);
  }

  Future<List<EntrySheet>> _getEntrySheetData() async {
    await ChangeNotifierModel.companyListModel
        .getEntrySheetList(studentId, companyIndex);
    return Future.value(ChangeNotifierModel
        .companyListModel.companyList[companyIndex].entrySheetList);
  }
}
