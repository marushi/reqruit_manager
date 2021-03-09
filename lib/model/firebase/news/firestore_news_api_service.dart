import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqruit_manager/model/main_model/news.dart';

class FireStoreNewsApiService {
  final fireStore = Firestore.instance;
  final _newsPath = 'news';

  Future<void> setNewsData(News news) async {
    await fireStore.collection(_newsPath).document().setData({
      'title': news.title,
      'comment': news.comment,
      'url': news.url,
      'adviserId': news.adviserId,
      'adviserImageUrl': news.adviserImageUrl,
      'adviserName': news.adviserName,
      'createdAt': news.createdAt,
    }, merge: true);
  }

  Future<QuerySnapshot> getNewsData(String adviserId) async {
    final QuerySnapshot querySnapshot = await fireStore
        .collection(_newsPath)
        .where('adviserId', isEqualTo: adviserId)
        .orderBy('createdAt', descending: true)
        .getDocuments();
    return querySnapshot;
  }
}
