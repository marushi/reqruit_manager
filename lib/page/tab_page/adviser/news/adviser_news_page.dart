import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/create_news/create_news_model.dart';
import 'package:reqruit_manager/model/main_model/news.dart';
import 'package:reqruit_manager/page/tab_page/adviser/news/create_news_page.dart';
import 'package:reqruit_manager/page/tab_page/student/news/news_list_item.dart';

class AdviserNewsPage extends StatelessWidget {
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
                          return NewsListItem(
                            news: snapshot.data[index],
                          );
                        },
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
                                  ChangeNotifierModel.createNewsModel =
                                      CreateNewsModel();
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: CreateNewsPage()));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.border_color,
                                      size: 60,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Text(
                                      'お知らせを投稿しましょう！',
                                      style: TextStyle(
                                          fontSize: AppTextSize.standardText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                ChangeNotifierModel.createNewsModel =
                                    CreateNewsModel();
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: CreateNewsPage()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.border_color,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                  ),
                                  Text(
                                    'お知らせを投稿しましょう！',
                                    style: TextStyle(
                                        fontSize: AppTextSize.standardText,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
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
    final adviserId = ChangeNotifierModel.adviserModel.adviser.id;
    try {
      await ChangeNotifierModel.newsListModel.getNewsListForAdviser(adviserId);
      return Future.value(ChangeNotifierModel.newsListModel.newsList);
    } catch (e) {
      return Future.value([]);
    }
  }
}
