import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';

class AddMinusWidget extends StatelessWidget {
  final bool isHideMinus;
  final int index;

  AddMinusWidget({
    this.isHideMinus,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 15),
        ),
        InkWell(
          child: Image.asset('assets/icon/plus.png'),
          onTap: () {
            ChangeNotifierModel.createCompanyModel.addSelection(index);
          },
        ),
        isHideMinus
            ? Container()
            : Padding(
                padding: EdgeInsets.only(top: 30),
              ),
        isHideMinus
            ? Container()
            : InkWell(
                child: Image.asset('assets/icon/minus.png'),
                onTap: () {
                  ChangeNotifierModel.createCompanyModel.removeSelection(index);
                },
              ),
      ],
    );
  }
}
