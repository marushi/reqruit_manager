import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';

class CornerRadiusItem extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double textSize;
  final Function onTap;

  CornerRadiusItem({
    this.backgroundColor,
    this.text,
    this.textColor = AppColors.black,
    this.textSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor),
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
