import 'dart:async';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Uint8List> loadAsset(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  Future<String?> uploadUserDisplayPhoto(String userId, String photoPath) async {
    try {
      final Uint8List file = await loadAsset(photoPath);
      String extension = photoPath.split('.').last;
      String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String fileName =
          'user_uploads/profile/$userId/$formattedDate.$extension';

      final Reference photoRef = _storage.ref().child(fileName);
      // Creates a new file in the storage with the given name and data
      final uploadTask = photoRef.putData(file);

      // Await the upload task and handle errors
      final TaskSnapshot snapshot = await uploadTask;

      final photoUrl = await snapshot.ref.getDownloadURL();
      return photoUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteUserPhotos(String userId) async {
    final userPhotosRef = _storage.ref().child('user_uploads/profile/$userId/');
    
    // Check if there are any photos to delete
    final ListResult result = await userPhotosRef.listAll();
    if (result.items.isEmpty) {
      return;
    }

    // Iterate over the files and delete each one
    for (var photoRef in result.items) {
      await photoRef.delete();
    }
  }

  Future<List<String>> getProductImages(String productId) async {
    final productImagesRef = _storage.ref().child('products/$productId/');

    try {
      final ListResult result = await productImagesRef.listAll();
      List<String> imageUrls = [];
      for (var item in result.items) {
        String url = await item.getDownloadURL();
        imageUrls.add(url);
      }
      return imageUrls;
    } catch (e) {
      return [];
    }
  }
}
