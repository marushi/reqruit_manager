import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';

class DrawerListItem extends StatelessWidget {
  final String title;
  final Function onTap;

  DrawerListItem({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          title: RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontSize: 16,
                  fontFamily: 'YuGothic'),
            ),
          ),
          onTap: onTap,
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.white,
          )),
    );
  }
}
