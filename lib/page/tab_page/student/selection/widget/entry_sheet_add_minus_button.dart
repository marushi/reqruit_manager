import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';
import 'package:reqruit_manager/model/change_notifier/create_company/create_company_model.dart';
import 'package:reqruit_manager/model/change_notifier/open_es/open_es_model.dart';
import 'package:reqruit_manager/widget/corner_radius_item.dart';

class EntrySheetAddMinusButton extends StatelessWidget {
  EntrySheetAddMinusButton({
    this.createCompanyModel,
    this.openEsModel,
    this.index,
    this.isEntrySheetCountZero = false,
  });

  final CreateCompanyModel createCompanyModel;
  final OpenEsModel openEsModel;
  final int index;
  final bool isEntrySheetCountZero;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isEntrySheetCountZero
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (createCompanyModel != null) {
              createCompanyModel.addEntrySheet();
            } else {
              openEsModel.addEntrySheet();
            }
          },
          child: CornerRadiusItem(
            text: 'ESを追加する',
            textSize: AppTextSize.smallText,
            backgroundColor: AppColors.clearBlue,
          ),
        ),
        !isEntrySheetCountZero
            ? InkWell(
                onTap: () {
                  if (createCompanyModel != null) {
                    createCompanyModel.removeEntrySheet(index);
                  } else {
                    openEsModel.removeEntrySheet(index);
                  }
                },
                child: CornerRadiusItem(
                  text: 'ESを削除する',
                  textSize: AppTextSize.smallText,
                  backgroundColor: AppColors.circleRed,
                ),
              )
            : Container(),
      ],
    );
  }
}
