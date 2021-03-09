import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';

class SelectionCircleBorder extends StatelessWidget {
  final bool isLast;
  final bool isPass;
  final bool isNow;
  final bool isMiss;
  final bool isComplete;

  SelectionCircleBorder(
      {this.isLast,
      this.isPass,
      this.isNow,
      this.isMiss = false,
      this.isComplete = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: circleInnerColor(),
            border: Border.all(width: 1, color: circleBorderColor()),
            borderRadius: BorderRadius.circular(7.5),
          ),
        ),
        isLast
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: 7.5),
                child: Container(
                  width: 1,
                  height: 70,
                  color: borderColor(),
                ),
              ),
      ],
    );
  }

  Color circleBorderColor() {
    if (isComplete) return AppColors.clearRed;
    if (isPass) {
      return AppColors.clearRed;
    } else {
      if (isNow) {
        if (isMiss) {
          return AppColors.darkGray;
        } else {
          return AppColors.clearRed;
        }
      } else {
        return AppColors.darkGray;
      }
    }
  }

  Color circleInnerColor() {
    if (isComplete) return AppColors.clearRed;
    if (isPass) {
      return AppColors.clearRed;
    } else {
      if (isNow) {
        return AppColors.white;
      } else {
        if (isMiss) {
          return AppColors.darkGray;
        } else {
          return AppColors.white;
        }
      }
    }
  }

  Color borderColor() {
    if (isComplete) return AppColors.clearRed;
    if (isPass) {
      return AppColors.clearRed;
    } else {
      if (isNow) {
        if (isMiss) {
          return AppColors.darkGray;
        } else {
          return AppColors.clearRed;
        }
      } else {
        return AppColors.darkGray;
      }
    }
  }
}
