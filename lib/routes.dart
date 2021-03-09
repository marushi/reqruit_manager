import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/enum_model/adviser_tab_category.dart';
import 'package:reqruit_manager/model/enum_model/init_transition_type.dart';
import 'package:reqruit_manager/model/enum_model/student_tab_category.dart';
import 'package:reqruit_manager/page/login/login_page.dart';
import 'package:reqruit_manager/page/on_boarding/on_boarding_page.dart';
import 'package:reqruit_manager/page/select_account/select_account_page.dart';
import 'package:reqruit_manager/page/sign_up/sign_up_page.dart';
import 'package:reqruit_manager/page/splash/splash_page.dart';
import 'package:reqruit_manager/page/tab_page/adviser/adviser_tab_bar_controller.dart';
import 'package:reqruit_manager/page/tab_page/student/fb_history/create_request_page.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/create_company_page.dart';
import 'package:reqruit_manager/page/tab_page/student/student_tab_bar_controller.dart';
import 'package:reqruit_manager/page/terms/terms_page.dart';

final routes = {
  '/': (context) => Container(), // 必ず必要
  '/splash': (context) => SplashPage(),
  '/onborading': (context) => OnBoardingPage(),
  '/signup': (context) => SignUpPage(),
  '/selectAccount': (context) => SelectAccountPage(),
  '/student/tab': (context) => StudentTabBarController(
        initialTabPage: StudentTabCategory.selection,
      ),
  '/adviser/tab': (context) => AdviserTabBarController(
        initialTabPage: AdviserTabCategory.requests,
      ),
  '/login': (context) => LoginPage(),
  '/terms': (context) => TermsPage(
        isFirstView: true,
      ),
  '/create/company': (context) => CreateCompanyPage(),
  '/create/request': (context) => CreateRequestPage(),
};

final initialRoute = setInitialRoute();

String setInitialRoute() {
  switch (ChangeNotifierModel.initTransition.initTransitionType) {
    case InitTransitionType.onBoarding:
      return '/onborading';
    case InitTransitionType.terms:
      return '/terms';
    case InitTransitionType.signUp:
      return '/signup';
    case InitTransitionType.selectAccount:
      return '/selectAccount';
    case InitTransitionType.studentTab:
      return '/student/tab';
    case InitTransitionType.adviserTab:
      return '/adviser/tab';
    default:
      return '/onboarding';
  }
}
