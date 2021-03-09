import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/app/app_text_style.dart';
import 'package:reqruit_manager/model/enum_model/enum_convert.dart';
import 'package:reqruit_manager/model/main_model/company.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/company_detail_page.dart';

class CompanyListItem extends StatelessWidget {
  final Company company;
  final String studentId;
  final bool isAdviser;
  final int companyIndex;

  CompanyListItem({
    this.company,
    this.studentId,
    this.isAdviser = false,
    this.companyIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: CompanyDetailPage(
                  studentId: studentId,
                  isAdviser: isAdviser,
                  companyIndex: companyIndex,
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
                width: 3,
                color: company.isComplete
                    ? AppColors.darkGray
                    : EnumConvert.wishGradeToColor(company.wishGrade)),
            borderRadius: BorderRadius.circular(10),
            color: company.isComplete ? AppColors.darkGray : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: company.isComplete
                    ? AppColors.darkGray
                    : EnumConvert.wishGradeToColor(company.wishGrade)
                        .withOpacity(0.5),
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
                company.name,
                style: AppTextStyle.subtitleTextStyle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(
                company.isComplete
                    ? '選考終了'
                    : '次の選考： ${EnumConvert.selectionTypeToString(company.nextSelection)}',
                style: TextStyle(fontSize: AppTextSize.smallText),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(
                '日程： ${EnumConvert.dateTimeToString(company.nextSelectionDate)}',
                style: TextStyle(fontSize: AppTextSize.smallText),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '選考状況：',
                    style: TextStyle(fontSize: AppTextSize.smallText),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 200,
                    animation: true,
                    lineHeight: 25.0,
                    animationDuration: 2000,
                    percent: company.percentage,
                    animateFromLastPercent: true,
                    center: Text(
                      company.percentage == 0
                          ? 'エントリー前'
                          : company.isComplete
                              ? '選考終了'
                              : (company.percentage * 100).floor().toString() +
                                  '%',
                      style: TextStyle(
                          fontSize: AppTextSize.smallText,
                          fontWeight: FontWeight.bold),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: company.isComplete
                        ? AppColors.darkGray
                        : EnumConvert.wishGradeToColor(company.wishGrade),
                    maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                    backgroundColor: company.isComplete
                        ? AppColors.darkGray
                        : AppColors.white,
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
