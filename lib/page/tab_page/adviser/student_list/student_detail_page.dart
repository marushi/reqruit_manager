import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/page/tab_page/adviser/student_list/widget/company_list.dart';
import 'package:reqruit_manager/page/tab_page/adviser/student_list/widget/student_info_item.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class StudentDetailPage extends StatelessWidget {
  final Student student;

  StudentDetailPage({this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          student.name,
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: true,
      ),
      body: Padding(
        padding: AppCommonPadding.pagePadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StudentInfoItem(
                student: student,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                '選考',
                style: AppTextStyle.subtitleTextStyle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              student.isOpenSelection
                  ? CompanyList(
                      student: student,
                    )
                  : Text(
                      '選考状況の公開許可がありません。',
                      style: TextStyle(fontSize: AppTextSize.smallText),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
