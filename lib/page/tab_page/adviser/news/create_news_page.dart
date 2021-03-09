import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/main_model/news.dart';
import 'package:reqruit_manager/model/validation/validation.dart';
import 'package:reqruit_manager/widget/confirm_dialog.dart';
import 'package:reqruit_manager/widget/error_dialog.dart';
import 'package:reqruit_manager/widget/icon_corner_radius_button.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class CreateNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text(
          'ニュース追加',
          style: AppTextStyle.appBarTextStyle,
        ),
        isShowBackButton: true,
      ),
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: AppCommonPadding.pagePadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'タイトル',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        InputTextField(
                          keyboardType: TextInputType.text,
                          hintText: 'タイトル',
                          onChanged: (String text) {
                            ChangeNotifierModel.createNewsModel.news.title =
                                text;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'コメント',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        InputTextField(
                          maxLines: 10,
                          keyboardType: TextInputType.text,
                          hintText: 'コメント',
                          onChanged: (String text) {
                            ChangeNotifierModel.createNewsModel.news.comment =
                                text;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '参照URL',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        InputTextField(
                          keyboardType: TextInputType.text,
                          hintText: 'https://',
                          onChanged: (String text) {
                            ChangeNotifierModel.createNewsModel.news.url = text;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                    IconCornerRadiusButton(
                      buttonText: Text(
                        'ニュースを作成する',
                        style: TextStyle(
                            fontSize: AppTextSize.standardText,
                            fontWeight: FontWeight.bold),
                      ),
                      buttonColor: AppColors.clearRed,
                      tapAction: () {
                        _tapCreateAction(context);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _tapCreateAction(BuildContext context) async {
    final News _news = ChangeNotifierModel.createNewsModel.news;

    if (!(await Validation().inputNewsValidation(_news, context))) return;

    // newsとcommentは空白の場合は確認のダイアログをだす
    if (_news.comment.isEmpty) {
      if (_news.url.isEmpty) {
        ConfirmDialog.showConfirmDialog(context, '確認', 'コメントとURLが空白ですがよろしいですか？',
            () {
          setNewsData(context);
        });
      } else {
        ConfirmDialog.showConfirmDialog(context, '確認', 'コメントが空白ですがよろしいですか？',
            () {
          setNewsData(context);
        });
      }
    } else if (_news.url.isEmpty) {
      ConfirmDialog.showConfirmDialog(context, '確認', 'URLが空白ですがよろしいですか？', () {
        setNewsData(context);
      });
    } else {
      await setNewsData(context);
    }
  }

  Future<void> setNewsData(BuildContext context) async {
    ProgressHud.of(context).show(ProgressHudType.loading, "loading...");

    try {
      await ChangeNotifierModel.createNewsModel.setNewsData();

      ProgressHud.of(context).showAndDismiss(ProgressHudType.success, "登録完了");

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);
    } catch (e) {
      ProgressHud.of(context).dismiss();
      ErrorDialog.showErrorDialog(context, '通信エラー', '通信環境を確認の上再度お試しください。');
    }
  }
}
