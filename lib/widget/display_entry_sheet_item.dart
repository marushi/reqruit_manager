import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/main_model/entry_sheet.dart';

class DisplayEntrySheetItem extends StatelessWidget {
  DisplayEntrySheetItem({this.entrySheet, this.index});

  final EntrySheet entrySheet;
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
          Text(
            entrySheet.title,
            style: TextStyle(
              fontSize: AppTextSize.smallText,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Text(
            '内容',
            style: TextStyle(
                fontSize: AppTextSize.smallText, fontWeight: FontWeight.bold),
          ),
          Text(
            entrySheet.content,
            style: TextStyle(
              fontSize: AppTextSize.smallText,
            ),
          ),
        ],
      ),
    );
  }
}
