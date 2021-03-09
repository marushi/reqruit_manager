import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';

class ErrorDialog extends StatelessWidget {
  /// エラー・タイトル
  final String _title;

  /// エラー・メッセージ
  final String _message;

  /// メッセージを黒にするか
  final bool _isDanger;

  /// コンストラクタ
  ErrorDialog({
    @required String title,
    @required String message,
    bool isDanger,
    Function onTapAction,
  })  : this._title = title,
        this._message = message,
        this._isDanger = isDanger;

  /// エラー簡易表示
  static Future<void> showErrorDialog(
      BuildContext context, String title, String message,
      {bool isDanger = true, void Function() onTapAction}) async {
    // ダイアログ表示
    await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ErrorDialog(
            title: title,
            message: message,
            isDanger: isDanger,
            onTapAction: onTapAction,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          _title,
          style: TextStyle(
              fontSize: AppTextSize.titleText, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Text(
              _message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppTextSize.standardText,
                color: _isDanger ? Colors.red : AppColors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 38),
            child: SizedBox(
              width: 287,
              height: 56,
              child: FlatButton(
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.borderGray),
                      borderRadius: BorderRadius.circular(0.0)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: AppColors.white,
                  child: Text('閉じる',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: AppTextSize.standardText,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
