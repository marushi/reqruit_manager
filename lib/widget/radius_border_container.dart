import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';

class RadiusBorderContainer extends StatelessWidget {
  final Function tapAction;
  final String displayText;

  RadiusBorderContainer({this.tapAction, this.displayText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: tapAction,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkGray),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            displayText,
            style: TextStyle(fontSize: AppTextSize.standardText),
          ),
        ),
      ),
    );
  }
}
