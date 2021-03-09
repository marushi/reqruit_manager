import 'package:reqruit_manager/model/enum_model/account_type.dart';
import 'package:reqruit_manager/model/enum_model/init_transition_type.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class InitTransition {
  InitTransitionType initTransitionType;
  bool isForce = false;

  void setInitTransition() {
    // 初期起動で問題があった場合は強制的に新規登録画面に飛ばす
    if (isForce) {
      initTransitionType = InitTransitionType.signUp;
      return;
    }

    if (!SharedPreferencesServices().getOnBoardingShow()) {
      initTransitionType = InitTransitionType.onBoarding;
    } else if (!SharedPreferencesServices().getTermsAccept()) {
      initTransitionType = InitTransitionType.terms;
    } else if (SharedPreferencesServices().getUserId().isEmpty) {
      initTransitionType = InitTransitionType.signUp;
    } else if (SharedPreferencesServices().getAccountType() == null) {
      initTransitionType = InitTransitionType.selectAccount;
    } else if (SharedPreferencesServices().getAccountType() ==
        AccountType.student) {
      initTransitionType = InitTransitionType.studentTab;
    } else if (SharedPreferencesServices().getAccountType() ==
        AccountType.adviser) {
      initTransitionType = InitTransitionType.adviserTab;
    } else {
      initTransitionType = InitTransitionType.onBoarding;
    }
  }
}
