import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';
import 'package:reqruit_manager/model/firebase/news/firestore_news_api_service.dart';
import 'package:reqruit_manager/model/main_model/news.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class CreateNewsModel extends ChangeNotifier {
  News news = News(
    id: '',
    title: '',
    comment: '',
    url: '',
    adviserId: '',
    adviserImageUrl: '',
    createdAt: DateTime.now(),
  );

  Future<void> setNewsData() async {
    news.adviserId = SharedPreferencesServices().getUserId();
    news.adviserImageUrl = ChangeNotifierModel.adviserModel.adviser.imageUrl;
    news.adviserName = ChangeNotifierModel.adviserModel.adviser.name;
    news.createdAt = DateTime.now();
    await FireStoreNewsApiService().setNewsData(news);
  }
}
