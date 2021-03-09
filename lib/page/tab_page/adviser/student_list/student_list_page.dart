import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_common_padding.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/firebase/user/firestore_user_api_service.dart';
import 'package:reqruit_manager/model/main_model/student.dart';
import 'package:reqruit_manager/page/tab_page/adviser/student_list/student_list_item.dart';

class StudentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppCommonPadding.pagePadding,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
//            Align(
//              alignment: Alignment.center,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    '絞り込み',
//                    style: AppTextStyle.subtitleTextStyle,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 10),
//                  ),
//                  SelectItemWidget(
//                    text: '1週間以内',
//                    tapAction: () {},
//                  ),
//                ],
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(top: 5),
//            ),
//            Divider(
//              color: AppColors.darkGray,
//            ),
            Align(
              alignment: Alignment.topLeft,
              child: FutureBuilder(
                future: _getStudentList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Student>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StudentListItem(
                            student: snapshot.data[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: Text(
                            'アドバイザーの登録をしてもらおう！',
                            style: TextStyle(
                                fontSize: AppTextSize.standardText,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
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
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: Text(
                          'アドバイザーの登録をしてもらおう！',
                          style: TextStyle(
                              fontSize: AppTextSize.standardText,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Student>> _getStudentList() async {
    final adviserId = ChangeNotifierModel.adviserModel.adviser.id;

    try {
      final _studentList =
          await FireStoreUserApiService().getAdviserStudentData(adviserId);
      return Future.value(_studentList);
    } catch (e) {
      return Future.value([]);
    }
  }
}
