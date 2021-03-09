import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/student_model.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/page/tab_page/student/setting/my_adviser_page.dart';
import 'package:reqruit_manager/page/tab_page/student/setting/open_es_page.dart';
import 'package:reqruit_manager/page/tab_page/student/setting/update_profile_page.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppCommonPadding.pagePadding,
      child: ChangeNotifierProvider.value(
        value: ChangeNotifierModel.studentModel,
        child: Consumer<StudentModel>(builder: (context, model, _) {
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
                  Text(model.student.name,
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
                  Text(EnumConvert.genderToString(model.student.gender),
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
                  Text(model.student.graduationYear,
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
                  Text(model.student.college,
                      style: TextStyle(fontSize: AppTextSize.smallText)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Divider(
                color: AppColors.darkGray,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              IconCornerRadiusButton(
                iconData: Icon(Icons.launch),
                buttonText: Text(
                  'オープンESを登録・確認する',
                  style: TextStyle(
                      color: AppColors.black, fontSize: AppTextSize.smallText),
                ),
                buttonColor: AppColors.clearRed,
                tapAction: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: OpenEsPage()));
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              IconCornerRadiusButton(
                iconData: Icon(Icons.search),
                buttonText: Text(
                  'アドバイザー一覧',
                  style: TextStyle(
                      color: AppColors.black, fontSize: AppTextSize.smallText),
                ),
                buttonColor: AppColors.clearGreen,
                tapAction: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: MyAdviserPage()));
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              IconCornerRadiusButton(
                iconData: Icon(Icons.person),
                buttonText: Text(
                  'プロフィールを変更する',
                  style: TextStyle(
                      color: AppColors.black, fontSize: AppTextSize.smallText),
                ),
                buttonColor: AppColors.clearBlue,
                tapAction: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: UpdateStudentProfilePage()));
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
