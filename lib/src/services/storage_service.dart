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
      // Load the file data from the provided photoPath
      final Uint8List file = await loadAsset(photoPath);

      String extension = photoPath.split('.').last;
      String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

      // Create a file name with the current timestamp and original file extension
      String fileName = 'user_uploads/profile/$formattedDate.$extension';

      final Reference photoRef = _storage.ref().child(fileName);
      // Upload the file data to Firebase Storage
      final uploadTask = photoRef.putData(file);

      print('Uploading user display photo to Firebase Storage');
      // Wait for the upload to complete
      final snapshot = await uploadTask.whenComplete(() {
        print('User display photo uploaded to Firebase Storage');
      }).onError((error, stackTrace) {
        // ignore: avoid_print
        print('Failed to upload display photo: $error');
        return Future.error(error as Object);
      });

      // Check if snapshot is not null before getting the URL
      final photoUrl = await snapshot.ref.getDownloadURL();
      print('User display photo URL: $photoUrl');
      return photoUrl;
    } catch (e) {
      print('Failed to upload display photo: $e');
      return null;
    }
  }
}

