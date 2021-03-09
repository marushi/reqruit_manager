import 'package:flutter/cupertino.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';

class AppTextStyle {
  static final TextStyle appBarTextStyle = TextStyle(
      fontSize: AppTextSize.appBarTitleText, fontWeight: FontWeight.bold);
  static final TextStyle titleTextStyle =
      TextStyle(fontSize: AppTextSize.titleText, fontWeight: FontWeight.bold);
  static final TextStyle subtitleTextStyle = TextStyle(
      fontSize: AppTextSize.subtitleText, fontWeight: FontWeight.bold);
}
