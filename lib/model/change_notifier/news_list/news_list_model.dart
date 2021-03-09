import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/firebase/news/firestore_news_api_service.dart';
import 'package:reqruit_manager/model/main_model/news.dart';

class NewsListModel extends ChangeNotifier {
  List<News> newsList = [];

  Future<void> getNewsListForStudent() async {
    newsList = [];
    await Future.forEach(ChangeNotifierModel.studentModel.student.adviserList,
        (adviser) async {
      final QuerySnapshot querySnapshot =
          await FireStoreNewsApiService().getNewsData(adviser.id);
      if (querySnapshot.documents.length != 0) {
        querySnapshot.documents.forEach((doc) async {
          final news = News(
            id: doc.documentID,
            title: doc.data['title'],
            comment: doc.data['comment'],
            url: doc.data['url'],
            adviserId: doc.data['adviserId'],
            adviserName: doc.data['adviserName'],
            adviserImageUrl: doc.data['adviserImageUrl'],
          );
          newsList.add(news);
        });
      }
    });
  }

  Future<void> getNewsListForAdviser(String adviserId) async {
    newsList = [];
    final QuerySnapshot querySnapshot =
        await FireStoreNewsApiService().getNewsData(adviserId);
    if (querySnapshot.documents.length != 0) {
      querySnapshot.documents.forEach((doc) async {
        final news = News(
          id: doc.documentID,
          title: doc.data['title'],
          comment: doc.data['comment'],
          url: doc.data['url'],
          adviserId: doc.data['adviserId'],
          adviserName: doc.data['adviserName'],
          adviserImageUrl: doc.data['adviserImageUrl'],
        );
        newsList.add(news);
      });
    }
  }
}
