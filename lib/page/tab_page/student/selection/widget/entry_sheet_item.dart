import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/create_company/create_company_model.dart';
import 'package:reqruit_manager/model/change_notifier/open_es/open_es_model.dart';
import 'package:reqruit_manager/page/tab_page/student/selection/widget/entry_sheet_add_minus_button.dart';
import 'package:reqruit_manager/widget/input_text_field.dart';

class EntrySheetItem extends StatelessWidget {
  EntrySheetItem({this.createCompanyModel, this.openEsModel, this.index});

  final CreateCompanyModel createCompanyModel;
  final OpenEsModel openEsModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'タイトル',
            style: TextStyle(
                fontSize: AppTextSize.smallText, fontWeight: FontWeight.bold),
          ),
          InputTextField(
            controller: createCompanyModel != null
                ? TextEditingController(
                    text:
                        createCompanyModel.company.entrySheetList[index].title)
                : TextEditingController(
                    text: openEsModel.entrySheetList[index].title),
            hintText: '学生時代に頑張ったこと',
            onChanged: (String text) {
              if (createCompanyModel != null) {
                createCompanyModel.changeEntrySheetTitle(text, index);
              } else {
                openEsModel.changeEntrySheetTitle(text, index);
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Text(
            '内容',
            style: TextStyle(
                fontSize: AppTextSize.smallText, fontWeight: FontWeight.bold),
          ),
          InputTextField(
            controller: createCompanyModel != null
                ? TextEditingController(
                    text: createCompanyModel
                        .company.entrySheetList[index].content)
                : TextEditingController(
                    text: openEsModel.entrySheetList[index].content),
            onChanged: (String text) {
              if (createCompanyModel != null) {
                createCompanyModel.changeEntrySheetContent(text, index);
              } else {
                openEsModel.changeEntrySheetContent(text, index);
              }
            },
            hintText: '私が学生時代頑張ったことは4年間続けたアルバイトです・・',
            maxLines: 10,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 5),
              child: createCompanyModel != null
                  ? Consumer<CreateCompanyModel>(
                      builder: (context, model, _) {
                        return Text(
                          '現在の文字数： ${model.company.entrySheetList[index].length}',
                          style: TextStyle(fontSize: AppTextSize.smallText),
                        );
                      },
                    )
                  : Consumer<OpenEsModel>(
                      builder: (context, model, _) {
                        return Text(
                          '現在の文字数： ${model.entrySheetList[index].length}',
                          style: TextStyle(fontSize: AppTextSize.smallText),
                        );
                      },
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          EntrySheetAddMinusButton(
            openEsModel: openEsModel,
            createCompanyModel: createCompanyModel,
            index: index,
          ),
        ],
      ),
    );
  }
}
