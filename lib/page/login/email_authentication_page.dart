import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/email_auth/email_auth_model.dart';
import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/enum_model/adviser_tab_category.dart';
import 'package:reqruit_manager/model/enum_model/auth_type.dart';
import 'package:reqruit_manager/model/enum_model/init_transition_type.dart';
import 'package:reqruit_manager/model/enum_model/student_tab_category.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/page/select_account/select_account_page.dart';
import 'package:reqruit_manager/page/sign_up/sign_up_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/adviser_tab_bar_controller.dart';
import 'package:reqruit_manager/page/tab_page/student/student_tab_bar_controller.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class EmailAuthenticationPage extends StatefulWidget {
  final AuthType authType;

  EmailAuthenticationPage({@required this.authType});

  @override
  _EmailAuthenticationPageState createState() =>
      _EmailAuthenticationPageState();
}

class _EmailAuthenticationPageState extends State<EmailAuthenticationPage> {
  String _titleText = '';
  String _buttonText = '';
  bool _showPassword;

  @override
  void initState() {
    switch (widget.authType) {
      case AuthType.login:
        _titleText = 'メールでログイン';
        _buttonText = 'ログイン';
        break;
      case AuthType.signUp:
        _titleText = 'メールで新規作成';
        _buttonText = '新規作成';
        break;
      default:
        // ここは通らない
        break;
    }
    _showPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomPadding: false,
      appBar: SimpleAppBar(
        titleText: Text(
          _titleText,
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: true,
      ),
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Center(
          child: Builder(builder: (context) {
            return Padding(
              padding: AppCommonPadding.pagePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'メールアドレス',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          InputTextField(
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'メールアドレス',
                            prefixIcon: Icon(Icons.mail_outline),
                            onChanged: (String text) {
                              ChangeNotifierModel.emailAuthModel.email = text;
                            },
                          ),
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
                            'パスワード',
                            style: AppTextStyle.subtitleTextStyle,
                          ),
                          InputTextField(
                            suffixIconTaped: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            obscureText: _showPassword,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: Icon(Icons.vpn_key),
                            suffixIcon: _showPassword
                                ? Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                  ),
                            hintText: 'パスワード',
                            onChanged: (String text) {
                              ChangeNotifierModel.emailAuthModel.password =
                                  text;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconCornerRadiusButton(
                      buttonText: Text(_buttonText,
                          style: TextStyle(
                            fontSize: AppTextSize.standardText,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          )),
                      buttonColor: AppColors.clearRed,
                      tapAction: () {
                        _tapAction(context);
                      }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void _tapAction(BuildContext context) async {
    final EmailAuthModel _emailAuthModel = ChangeNotifierModel.emailAuthModel;

    if (!Validation().emailAuthValidation(
        _emailAuthModel.email, _emailAuthModel.password, context)) return;

    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      if (_emailAuthModel.authType == AuthType.signUp) {
        await signUp(context, _emailAuthModel);
      } else if (_emailAuthModel.authType == AuthType.login) {
        await signIn(context, _emailAuthModel);
      } else {
        return;
      }
    } catch (e) {
      ProgressHud.of(context).dismiss();
      print(e);
      ErrorDialog.showErrorDialog(context, 'エラー', e.toString());
      return;
    }
  }

  Future<void> signUp(
      BuildContext context, EmailAuthModel emailAuthModel) async {
    final result = await emailAuthModel.signUp();
    // ローカルデータに保存
    SharedPreferencesServices().saveUserId(result.user.uid);

    ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "新規登録完了");

    await Future.delayed(const Duration(seconds: 1));
    // 画面遷移
    transitionToNextPage(InitTransitionType.selectAccount);
  }

  Future<void> signIn(
      BuildContext context, EmailAuthModel emailAuthModel) async {
    final result = await emailAuthModel.signIn();
    // ローカルデータに保存
    final AccountType accountType =
        await emailAuthModel.searchLoginData(result.user.uid);

    if (accountType == null) {
      transitionToNextPage(InitTransitionType.selectAccount);
    }

    SharedPreferencesServices().saveUserId(result.user.uid);
    ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "ログイン完了");
    await Future.delayed(const Duration(seconds: 1));

    if (accountType == AccountType.adviser) {
      transitionToNextPage(InitTransitionType.adviserTab);
    } else {
      transitionToNextPage(InitTransitionType.studentTab);
    }
  }

  void transitionToNextPage(InitTransitionType initTransitionType) {
    switch (initTransitionType) {
      case InitTransitionType.selectAccount:
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: SelectAccountPage()));
        break;
      case InitTransitionType.studentTab:
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: StudentTabBarController(
                  initialTabPage: StudentTabCategory.selection,
                )));
        break;
      case InitTransitionType.adviserTab:
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: AdviserTabBarController(
                  initialTabPage: AdviserTabCategory.requests,
                )));
        break;
      default:
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: SignUpPage()));
        break;
    }
  }
}
