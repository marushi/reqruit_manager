import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';

class SelectItemWidget extends StatelessWidget {
  final Function tapAction;
  final String text;

  SelectItemWidget({
    this.tapAction,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapAction,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderGray),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: AppTextSize.smallText),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
