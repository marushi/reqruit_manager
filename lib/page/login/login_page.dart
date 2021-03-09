import 'dart:io';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_device_info.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/email_auth/email_auth_model.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/enum_model/adviser_tab_category.dart';
import 'package:reqruit_manager/model/enum_model/auth_type.dart';
import 'package:reqruit_manager/model/enum_model/student_tab_category.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/page/login/email_authentication_page.dart';
import 'package:reqruit_manager/page/select_account/select_account_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/adviser_tab_bar_controller.dart';
import 'package:reqruit_manager/page/tab_page/student/student_tab_bar_controller.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Center(
          child: Builder(builder: (context) {
            return Padding(
              padding: AppCommonPadding.pagePadding,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                  ),
                  Text('ログイン', style: AppTextStyle.titleTextStyle),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  IconCornerRadiusButton(
                    buttonText: Text('メールアドレスでログイン',
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
                        authType: AuthType.login,
                      );
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: EmailAuthenticationPage(
                                authType: AuthType.login,
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
                          buttonText: Text('  Appleでサインイン',
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
                    buttonText: Text('Googleアカウントでログイン',
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
                        '新規作成の場合は',
                        style: TextStyle(
                            fontSize: AppTextSize.standardText,
                            color: AppColors.darkGray),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
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
            );
          }),
        ),
      ),
    );
  }
}

void tapAppleButton(BuildContext context) async {
  ProgressHud.of(context).show(ProgressHudType.loading, "loading...");
  try {
    final AuthResult _result =
        await ChangeNotifierModel.emailAuthModel.signInWithApple();
    SharedPreferencesServices().saveUserId(_result.user.uid);

    await getAccountData(_result, context);
  } catch (e) {
    ProgressHud.of(context).dismiss();
    print(e);
    ErrorDialog.showErrorDialog(context, 'エラー', e.toString());
  }
}

void tapGoogleButton(BuildContext context) async {
  ProgressHud.of(context).show(ProgressHudType.loading, "loading...");
  try {
    final AuthResult _result =
        await ChangeNotifierModel.emailAuthModel.googleSignIn();
    SharedPreferencesServices().saveUserId(_result.user.uid);

    await getAccountData(_result, context);
  } catch (e) {
    ProgressHud.of(context).dismiss();
    print(e);
    ErrorDialog.showErrorDialog(context, 'エラー', e.toString());
  }
}

Future<void> getAccountData(AuthResult result, BuildContext context) async {
  final AccountType _accountType =
      await ChangeNotifierModel.emailAuthModel.searchLoginData(result.user.uid);
  switch (_accountType) {
    case AccountType.student:
      await ChangeNotifierModel.studentModel.getFireStoreData(result.user.uid);

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "ログイン完了");
      await Future.delayed(const Duration(seconds: 1));

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: StudentTabBarController(
                initialTabPage: StudentTabCategory.selection,
              )));
      break;
    case AccountType.adviser:
      await ChangeNotifierModel.adviserModel.getFireStoreData(result.user.uid);

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "ログイン完了");
      await Future.delayed(const Duration(seconds: 1));

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: AdviserTabBarController(
                initialTabPage: AdviserTabCategory.requests,
              )));
      break;
    default:
      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "新規登録完了");
      await Future.delayed(const Duration(seconds: 1));

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: SelectAccountPage()));
      break;
  }
}
