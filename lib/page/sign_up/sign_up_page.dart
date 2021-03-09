import 'dart:io';

import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_device_info.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/email_auth/email_auth_model.dart';
import 'package:reqruit_manager/model/enum_model/auth_type.dart';
import 'package:reqruit_manager/page/login/email_authentication_page.dart';
import 'package:reqruit_manager/page/login/login_page.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:page_transition/page_transition.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Builder(builder: (context) {
          return Center(
            child: Padding(
              padding: AppCommonPadding.pagePadding,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                  ),
                  Text('新規登録', style: AppTextStyle.titleTextStyle),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  IconCornerRadiusButton(
                    buttonText: Text('メールアドレスで作成',
                        style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        )),
                    buttonColor: AppColors.clearRed,
                    iconData: Icon(Icons.mail),
                    tapAction: () {
                      ChangeNotifierModel.emailAuthModel = EmailAuthModel(
                        email: '',
                        password: '',
                        authType: AuthType.signUp,
                      );
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: EmailAuthenticationPage(
                                authType: AuthType.signUp,
                              )));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 109,
                        height: 2,
                        color: AppColors.darkGray,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                      ),
                      Text(
                        'または',
                        style: TextStyle(
                            fontSize: AppTextSize.standardText,
                            color: AppColors.darkGray),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                      ),
                      Container(
                        width: 109,
                        height: 2,
                        color: AppColors.darkGray,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Platform.isIOS &&
                          AppDeviceInfo.iosDeviceInfo.systemVersion
                              .startsWith('13')
                      ? IconCornerRadiusButton(
                          buttonText: Text('  Appleでサインアップ',
                              style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              )),
                          buttonColor: AppColors.black,
                          tapAction: () {
                            tapAppleButton(context);
                          },
                        )
                      : Container(),
                  Platform.isIOS &&
                          AppDeviceInfo.iosDeviceInfo.systemVersion
                              .startsWith('13')
                      ? Padding(
                          padding: EdgeInsets.only(top: 30),
                        )
                      : Container(),
                  IconCornerRadiusButton(
                    buttonText: Text('Googleアカウントで作成',
                        style: TextStyle(
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        )),
                    buttonColor: AppColors.white,
                    iconImagePath:
                        'assets/icon/btn_google_light_focus_ios@3x.png',
                    tapAction: () {
                      tapGoogleButton(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'アカウントをお持ちの方は',
                        style: TextStyle(
                            fontSize: AppTextSize.standardText,
                            color: AppColors.darkGray),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: LoginPage())),
                        child: Text(
                          'こちら',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold,
                              color: AppColors.linkBlue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
