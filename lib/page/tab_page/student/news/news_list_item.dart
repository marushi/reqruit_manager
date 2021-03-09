import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/report/report_page_model.dart';
import 'package:reqruit_manager/model/main_model/news.dart';
import 'package:reqruit_manager/page/report/report_page.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListItem extends StatelessWidget {
  final News news;

  NewsListItem({this.news});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              news.title,
              style: AppTextStyle.subtitleTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(news.adviserImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
                Text(
                  news.adviserName,
                  style: TextStyle(fontSize: AppTextSize.standardText),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Text(
          news.title,
          style: TextStyle(fontSize: AppTextSize.standardText),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        news.url.isNotEmpty
            ? Column(
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      if (await canLaunch(news.url)) {
                        await launch(news.url);
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('有効なURLではありません。'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      news.url,
                      style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          color: AppColors.linkBlue),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                ],
              )
            : Container(),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              ChangeNotifierModel.reportPageModel = ReportPageModel();
              ChangeNotifierModel.reportPageModel.report.newsId = news.id;
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ReportPage()));
            },
            child: Text(
              '不適切な投稿を報告する',
              style: TextStyle(
                  fontSize: AppTextSize.standardText,
                  color: AppColors.backgroundRed),
            ),
          ),
        ),
        Divider(
          color: AppColors.darkGray,
        ),
      ],
    );
  }
}
