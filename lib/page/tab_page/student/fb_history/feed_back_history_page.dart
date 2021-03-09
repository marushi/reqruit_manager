import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/data_load_type.dart';
import 'package:reqruit_manager/model/main_model/request.dart';
import 'package:reqruit_manager/model/request_list/request_list_model.dart';
import 'package:reqruit_manager/page/tab_page/adviser/request_list/request_list_item.dart';
import 'package:reqruit_manager/widget/search_adviser_dialog.dart';

class FeedBackHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppCommonPadding.pagePadding,
      child: SingleChildScrollView(
        child: ChangeNotifierProvider.value(
          value: ChangeNotifierModel.requestListModel,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FutureBuilder(
                  future: _getHistoryList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Request>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length != 0) {
                        return Consumer<RequestListModel>(
                            builder: (context, model, _) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: model.requestList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RequestListItem(
                                request: snapshot.data[index],
                                index: index,
                                isAdviser: false,
                              );
                            },
                          );
                        });
                      } else {
                        return Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 200),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/create/request');
                                },
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.send,
                                      size: 60,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Text(
                                      'アドバイザーに依頼してみましょう！',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      }
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
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  ChangeNotifierModel.searchAdviserDialogModel
                                      .searchStatus = DataLoadType.none;
                                  SearchAdviserDialog.showSearchAdviserDialog(
                                      context);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.person_add,
                                      size: 60,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Text(
                                      'アドバイザーを探す',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                              ),
                              Text(
                                '※本機能はアドバイザーを\nつけることで使用可能です。',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: AppTextSize.standardText),
                              ),
                            ],
                          ),
                        ),
                      );
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

  Future<List<Request>> _getHistoryList() async {
    if (ChangeNotifierModel.studentModel.student.adviserList.length == 0) {
      return Future.error(['']);
    }

    try {
      await Future.forEach(ChangeNotifierModel.studentModel.student.adviserList,
          (adviser) async {
        await ChangeNotifierModel.requestListModel
            .getStudentHistoryList(adviser.id);
      });

      return Future.value(ChangeNotifierModel.requestListModel.requestList);
    } catch (e) {
      print(e);
      return Future.value([]);
    }
  }
}
