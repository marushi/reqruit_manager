import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';

class IconCornerRadiusButton extends StatelessWidget {
  final Text buttonText;
  final Color buttonColor;
  final String iconImagePath;
  final Icon iconData;
  final Function tapAction;
  final double buttonHeight;
  final double buttonWidth;
  final bool isShadow;

  IconCornerRadiusButton({
    this.buttonText,
    this.buttonColor,
    this.buttonHeight = 48,
    this.buttonWidth = double.infinity,
    this.iconImagePath,
    this.iconData,
    this.tapAction,
    this.isShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      child: FlatButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
              width: 1,
              color: buttonColor == AppColors.white
                  ? AppColors.borderGray
                  : buttonColor),
        ),
        color: buttonColor,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: iconData != null
                  ? iconData
                  : iconImagePath != null
                      ? Image.asset(
                          iconImagePath,
                          width: 20,
                          height: 20,
                        )
                      : Container(),
            ),
            Center(
              child: buttonText,
            ),
          ],
        ),
        onPressed: tapAction,
      ),
    );
  }
}
