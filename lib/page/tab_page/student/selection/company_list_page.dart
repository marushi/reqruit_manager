import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/company_list/company_list_model.dart';
import 'package:reqruit_manager/model/main_model/company.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/company_list_item.dart';

class CompanyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppCommonPadding.pagePadding,
      child: SingleChildScrollView(
        child: ChangeNotifierProvider.value(
          value: ChangeNotifierModel.companyListModel,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//            Align(
//              alignment: Alignment.center,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    '並び替え',
//                    style: AppTextStyle.subtitleTextStyle,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 10),
//                  ),
//                  SelectItemWidget(
//                    text: '志望度',
//                    tapAction: () {},
//                  ),
//                ],
//              ),
//            ),
              Align(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                  future: _getCompanyList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Company>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length != 0) {
                        return Consumer<CompanyListModel>(
                            builder: (context, model, _) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: model.companyList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CompanyListItem(
                                company: model.companyList[index],
                                studentId:
                                    SharedPreferencesServices().getUserId(),
                                companyIndex: index,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Company>> _getCompanyList() async {
    final String studentId = SharedPreferencesServices().getUserId();
    try {
      await ChangeNotifierModel.companyListModel.getCompanyList(studentId);
      return Future.value(ChangeNotifierModel.companyListModel.companyList);
    } catch (e) {
      return [];
    }
  }
}
