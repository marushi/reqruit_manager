import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/page/input_profile/input_adviser_profile_page.dart';
import 'package:reqruit_manager/page/input_profile/input_student_profile_page.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class SelectAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          'アカウント選択',
          style: AppTextStyle.titleTextStyle,
        ),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: AppCommonPadding.appBarNotPagePadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '就活生ですか？',
                    style: AppTextStyle.subtitleTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  IconCornerRadiusButton(
                    buttonColor: AppColors.clearRed,
                    buttonText: Text('就活生の方はこちら',
                        style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        )),
                    tapAction: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: InputStudentProfilePage()));
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'アドバイザーですか？',
                    style: AppTextStyle.subtitleTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  IconCornerRadiusButton(
                    buttonColor: AppColors.clearGreen,
                    buttonText: Text('アドバイザーの方はこちら',
                        style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        )),
                    tapAction: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: InputAdviserProfilePage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
