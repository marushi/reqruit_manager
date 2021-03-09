import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/student_model.dart';
import 'package:reqruit_manager/widget/confirm_dialog.dart';

class AdviserListItem extends StatelessWidget {
  final StudentModel studentModel;
  final int index;

  AdviserListItem({
    this.studentModel,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        image: DecorationImage(
                          image: NetworkImage(
                              studentModel.student.adviserList[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Text(
                      studentModel.student.adviserList[index].name,
                      style: TextStyle(fontSize: AppTextSize.standardText),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CupertinoSwitch(
                      value: studentModel
                          .student.adviserList[index].isOpenSelection,
                      onChanged: (bool value) {
                        ConfirmDialog.showConfirmDialog(
                            context, '確認', '公開情報を変更しますか？', () {
                          studentModel.changeSelectionOpenState(value, index);
                        });
                      },
                    ),
                    Text(
                      studentModel.student.adviserList[index].isOpenSelection
                          ? '公開中'
                          : '非公開',
                      style: TextStyle(
                        fontSize: AppTextSize.standardText,
                        color: studentModel
                                .student.adviserList[index].isOpenSelection
                            ? Colors.green
                            : AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.darkGray,
          ),
        ],
      ),
    );
  }
}
