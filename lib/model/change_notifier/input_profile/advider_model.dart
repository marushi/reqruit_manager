import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reqruit_manager/model/firebase/user/firestore_user_api_service.dart';
import 'package:reqruit_manager/model/firestorage/firestorage_api_service.dart';
import 'package:reqruit_manager/model/main_model/adviser.dart';
import 'package:reqruit_manager/model/shared_preferences/shared_preferences_service.dart';

class AdviserModel extends ChangeNotifier {
  Adviser adviser = Adviser(
    id: SharedPreferencesServices().getUserId(),
  );
  FileImage fileImage;
  File file;

  void selectProfileImage() async {
    final PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 5);
    file = File(image.path);
    fileImage = FileImage(file);
    notifyListeners();
  }

  Future<void> getFireStoreData(String userId) async {
    adviser = await FireStoreUserApiService().getAdviserData(userId);
  }

  Future<bool> searchAdviser() async {
    final QuerySnapshot querySnapshot =
        await FireStoreUserApiService().searchAdviser(adviser.adminId);
    return querySnapshot.documents.length != 0;
  }

  Future<void> saveFireStore() async {
    adviser.imageUrl = await FireStorageApiService().uploadProfileImage();
    adviser.fcmToken = SharedPreferencesServices().getFcmToken();
    await FireStoreUserApiService().setAdviserData(adviser);
  }
}
