import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/page/sign_up/sign_up_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/setting/update_adviser_profile_page.dart';
import 'package:reqruit_manager/page/tab_page/drawer/drawer_list_item.dart';
import 'package:reqruit_manager/page/tab_page/student/setting/my_adviser_page.dart';
import 'package:reqruit_manager/page/tab_page/student/setting/open_es_page.dart';
import 'package:reqruit_manager/page/tab_page/student/setting/update_profile_page.dart';
import 'package:reqruit_manager/page/terms/terms_page.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:page_transition/page_transition.dart';

class TabPagesDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: Container(
          color: AppColors.drawerBlack,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Container(
                  height: 70,
                ),
              ),
              DrawerListItem(
                title: 'プロフィールを変更',
                onTap: () {
                  if (SharedPreferencesServices().getAccountType() ==
                      AccountType.student) {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: UpdateStudentProfilePage()));
                  } else {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: UpdateAdviserProfilePage()));
                  }
                },
              ),
              SharedPreferencesServices().getAccountType() ==
                      AccountType.student
                  ? DrawerListItem(
                      title: 'オープンESを編集',
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: OpenEsPage()));
                      },
                    )
                  : Container(),
              SharedPreferencesServices().getAccountType() ==
                      AccountType.student
                  ? DrawerListItem(
                      title: 'アドバイザー一覧',
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: MyAdviserPage()));
                      },
                    )
                  : Container(),
              DrawerListItem(
                title: '利用規約',
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: TermsPage()));
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: IconCornerRadiusButton(
                  buttonText: Text(
                    'ログアウト',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppTextSize.standardText,
                        fontWeight: FontWeight.bold),
                  ),
                  buttonColor: AppColors.backgroundDarkGray,
                  buttonHeight: 35,
                  tapAction: () {
                    _logout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    final _fireBaseAuth = FirebaseAuth.instance;
    try {
      await _fireBaseAuth.signOut();
      SharedPreferencesServices().removeUserData();
      // ChangeNotifierModelを全て初期化
      ChangeNotifierModel.initModel();
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.leftToRightWithFade,
              child: SignUpPage()));
    } catch (e) {
      ErrorDialog.showErrorDialog(context, 'ログアウト失敗', e.toString());
    }
  }
}
