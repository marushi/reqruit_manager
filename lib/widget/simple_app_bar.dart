import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  SimpleAppBar({
    this.titleText,
    this.isShowBackButton = false,
    this.isShowDrawer = false,
    this.isHideBorder = false,
  });

  /// titleのテキスト
  final Text titleText;

  /// 戻るボタンを表示するフラグ
  final bool isShowBackButton;

  /// ドロワーを表示するフラグ
  final bool isShowDrawer;

  /// AppBarのボーダーを消すフラグ
  final bool isHideBorder;

  @override
  final Size preferredSize = Size.fromHeight(46);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: AppColors.borderGray, width: 1),
      )),
      child: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: DefaultTextStyle.merge(
          style: TextStyle(
            color: Colors.black,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Align(
                  alignment: Alignment.center,
                  child: titleText,
                ),
              ),
              isShowDrawer
                  ? drawerButton(isShowDrawer, context)
                  : backButton(isShowBackButton, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(bool isHideBackButton, BuildContext context) {
    if (!isHideBackButton) return Container();
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 21, top: 0),
        child: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 26,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget drawerButton(bool isShowDrawer, BuildContext context) {
    if (!isShowDrawer) return Container();
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 21, top: 5),
        child: GestureDetector(
          child: Icon(
            Icons.menu,
            size: 26,
          ),
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}
