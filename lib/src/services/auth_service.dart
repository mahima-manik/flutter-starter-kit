import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'storage_service.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageService _storageService = StorageService();
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Stream<User?> get userChanges => _auth.userChanges();

  static void clearStackAndRedirectToPage(BuildContext context, Widget pageToRedirect) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageToRedirect),
      (Route<dynamic> route) => false, // This predicate will always return false, removing all routes below the new route
    );
  }

  Future<User?> signInWithUsernameAndPassword(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> registerUser(String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<User?> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleUserAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleUserAuth.idToken,
      accessToken: googleUserAuth.accessToken,
    );
    UserCredential result = await _auth.signInWithCredential(credential);
    return result.user;
  }

  Future<void> updateDisplayName(String displayName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(displayName);
    }
  }

  Future<void> updateUserPhoto(BuildContext context, String photoPath) async {    
      final user = FirebaseAuth.instance.currentUser;
      final photoURL = await _storageService.uploadUserDisplayPhoto(user!.uid, photoPath);
      await user.updatePhotoURL(photoURL);
  }

  Future<void> updatePassword(BuildContext context, String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Re-authenticate the user with the current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        // Update the password
        await user.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        throw Exception('Error updating password: ${e.message}');
      }
    }
  }
}
