import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/page/tab_page/adviser/student_list/student_detail_page.dart';

class StudentListItem extends StatelessWidget {
  final Student student;

  StudentListItem({
    this.student,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: StudentDetailPage(
                  student: student,
                )));
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
                width: 3, color: EnumConvert.genderToColor(student.gender)),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color:
                    EnumConvert.genderToColor(student.gender).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                student.name,
                style: AppTextStyle.subtitleTextStyle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    EnumConvert.snsTypeToString(student.snsAccount) + '： ',
                    style: TextStyle(
                        fontSize: AppTextSize.smallText,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                  ),
                  Text(
                    student.snsAccountName,
                    style: TextStyle(
                      fontSize: AppTextSize.smallText,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '最終対応： ',
                    style: TextStyle(
                        fontSize: AppTextSize.smallText,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                  ),
                  Text(
                    EnumConvert.dateTimeToString(DateTime.now()),
                    style: TextStyle(
                      fontSize: AppTextSize.smallText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
