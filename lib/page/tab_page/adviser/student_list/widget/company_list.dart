import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/firebase/company/firestore_company_api_service.dart';
import 'package:reqruit_manager/model/main_model/company.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/company_list_item.dart';

class CompanyList extends StatelessWidget {
  final Student student;

  CompanyList({this.student});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: FutureBuilder(
        future: _getCompanyList(),
        builder: (BuildContext context, AsyncSnapshot<List<Company>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CompanyListItem(
                    company: snapshot.data[index],
                    studentId: student.id,
                    isAdviser: true,
                    companyIndex: index,
                  );
                },
              );
            }
            return Text(
              '選考状況が登録されていません。',
              style: TextStyle(fontSize: AppTextSize.smallText),
            );
          } else if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<List<Company>> _getCompanyList() async {
    try {
      await ChangeNotifierModel.companyListModel.getCompanyList(student.id);
      return Future.value(ChangeNotifierModel.companyListModel.companyList);
    } catch (e) {
      return [];
    }
  }
}
