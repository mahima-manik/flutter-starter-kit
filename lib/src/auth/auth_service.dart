import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authUserChanges => _auth.authStateChanges();

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

  static Future<void> updateUserPhoto(BuildContext context, String photoURL) async {    
      final user = FirebaseAuth.instance.currentUser;
      await user!.updatePhotoURL(photoURL);      
  }

}
