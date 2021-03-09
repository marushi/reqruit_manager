import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';

class ConfirmDialog extends StatelessWidget {
  /// エラー・タイトル
  final String _title;

  /// エラー・メッセージ
  final String _message;

  /// メッセージを黒にするか
  final bool _isDanger;

  final Function _okTap;

  /// コンストラクタ
  ConfirmDialog({
    @required String title,
    @required String message,
    bool isDanger,
    Function okTap,
  })  : this._title = title,
        this._message = message,
        this._isDanger = isDanger,
        this._okTap = okTap;

  /// エラー簡易表示
  static Future<void> showConfirmDialog(
      BuildContext context, String title, String message, Function okTap,
      {bool isDanger = true, void Function() onTapAction}) async {
    // ダイアログ表示
    await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ConfirmDialog(
            title: title,
            message: message,
            isDanger: isDanger,
            okTap: okTap,
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
            width: double.infinity,
            margin: EdgeInsets.only(top: 38),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 115,
                  height: 40,
                  child: FlatButton(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.borderGray),
                          borderRadius: BorderRadius.circular(0.0)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: AppColors.white,
                      child: Text('OK',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        await _okTap();
                        Navigator.pop(context);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                SizedBox(
                  width: 115,
                  height: 40,
                  child: FlatButton(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.borderGray),
                          borderRadius: BorderRadius.circular(0.0)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: AppColors.white,
                      child: Text('Cancel',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
