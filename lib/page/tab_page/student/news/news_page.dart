import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/main_model/news.dart';
import 'package:reqruit_manager/page/tab_page/student/news/news_list_item.dart';
import 'package:reqruit_manager/widget/search_adviser_dialog.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppCommonPadding.pagePadding,
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: FutureBuilder(
                future: _getNewsList(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          /// ニュースのリストアイテムを作る
                          return NewsListItem(
                            news: snapshot.data[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: Text(
                            'アドバイザーの投稿を待とう！',
                            style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                  } else if (snapshot.connectionState != ConnectionState.done) {
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
    );
  }

  Future<List<News>> _getNewsList() async {
    if (ChangeNotifierModel.studentModel.student.adviserList.length == 0) {
      return Future.error([]);
    }

    try {
      await ChangeNotifierModel.newsListModel.getNewsListForStudent();
      return Future.value(ChangeNotifierModel.newsListModel.newsList);
    } catch (e) {
      return Future.value([]);
    }
  }
}
