import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';

class GifDialog extends StatelessWidget {
  /// エラー・タイトル
  final String _title;

  /// エラー・メッセージ
  final String _message;

  /// メッセージを黒にするか
  final bool _isDanger;

  final Function _okTap;

  /// コンストラクタ
  GifDialog({
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
        builder: (BuildContext context) {
          return GifDialog(
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
      title: Container(),
      content: Stack(
        children: <Widget>[
          Container(
            color: AppColors.clearRed,
          ),
          Image(
            image: AssetImage('assets/images/like.gif'),
            fit: BoxFit.cover,
          ),
        ],
      ),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
    );
  }
}
