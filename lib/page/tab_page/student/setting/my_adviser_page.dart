import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/change_notifier/input_profile/student_model.dart';
import 'package:reqruit_manager/widget/adviser_list_item.dart';
import 'package:reqruit_manager/widget/search_adviser_dialog.dart';
import 'package:reqruit_manager/widget/simple_app_bar.dart';

class MyAdviserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: Text('アドバイザー一覧'),
        isShowBackButton: true,
      ),
      body: ChangeNotifierProvider.value(
        value: ChangeNotifierModel.studentModel,
        child: Consumer<StudentModel>(
          builder: (context, model, _) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: model.student.adviserList.length,
              itemBuilder: (BuildContext context, int index) {
                return AdviserListItem(
                  studentModel: model,
                  index: index,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.black,
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
        onPressed: () {
          SearchAdviserDialog.showSearchAdviserDialog(context);
        },
      ),
    );
  }
}
