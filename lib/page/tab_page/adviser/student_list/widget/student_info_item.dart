import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/student.dart';

class StudentInfoItem extends StatelessWidget {
  final Student student;

  StudentInfoItem({this.student});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '名前',
              style: AppTextStyle.subtitleTextStyle,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(student.name,
                style: TextStyle(fontSize: AppTextSize.smallText)),
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
              '性別',
              style: AppTextStyle.subtitleTextStyle,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(EnumConvert.genderToString(student.gender),
                style: TextStyle(fontSize: AppTextSize.smallText)),
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
              '卒業年',
              style: AppTextStyle.subtitleTextStyle,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(student.graduationYear,
                style: TextStyle(fontSize: AppTextSize.smallText)),
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
              '大学(学部・学科)',
              style: AppTextStyle.subtitleTextStyle,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(student.college,
                style: TextStyle(fontSize: AppTextSize.smallText)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Divider(
          color: AppColors.darkGray,
        ),
      ],
    );
  }
}
