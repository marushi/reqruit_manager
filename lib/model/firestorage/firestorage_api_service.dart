import 'package:firebase_storage/firebase_storage.dart';
import 'package:reqruit_manager/model/change_notifier/change_notifier_model.dart';

class FireStorageApiService {
  final fireStorage = FirebaseStorage.instance;

  Future<String> uploadProfileImage() async {
    final String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final StorageReference storageReference =
        FirebaseStorage().ref().child('userImage/$timeStamp');

    try {
      StorageUploadTask uploadTask =
          storageReference.putFile(ChangeNotifierModel.adviserModel.file);

      await uploadTask.onComplete;

      final fileUrl = await storageReference.getDownloadURL();

      return fileUrl.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
