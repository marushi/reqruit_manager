import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/page/tab_page/adviser/request_list/request_list_item.dart';
import 'package:reqruit_manager/model/main_model/request.dart';

class RequestListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
//          Align(
//            alignment: Alignment.center,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(
//                  '並び替え',
//                  style: TextStyle(
//                    fontSize: AppTextSize.bottomTabText,
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 10),
//                ),
//                SelectItemWidget(
//                  text: '志望度',
//                  tapAction: () {},
//                ),
//              ],
//            ),
//          ),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: FutureBuilder(
                  future: _getRequestList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Request>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length != 0) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RequestListItem(
                              request: snapshot.data[index],
                              index: index,
                            );
                          },
                        );
                      }
                      return Container();
                    } else if (snapshot.connectionState !=
                        ConnectionState.done) {
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
              ))
        ],
      ),
    );
  }
}

Future<List<Request>> _getRequestList() async {
  try {
    await ChangeNotifierModel.requestListModel.getAdviserRequestList();
    return Future.value(ChangeNotifierModel.requestListModel.requestList);
  } catch (e) {
    return [];
  }
}
