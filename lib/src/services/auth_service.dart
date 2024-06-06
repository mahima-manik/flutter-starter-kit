import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../components/alert_dialog.dart';

class AuthService {

  static void clearStackAndRedirectToPage(BuildContext context, Widget pageToRedirect) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageToRedirect),
      (Route<dynamic> route) => false, // This predicate will always return false, removing all routes below the new route
    );
  }

  static Future<void> signInWithUsernameAndPassword(BuildContext context, String email, String password, Widget pageToRedirect) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      clearStackAndRedirectToPage(context, pageToRedirect);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          if (e.code == 'user-not-found') {
            return const CustomAlertDialog(
              title: 'User not found',
              message: 'The email you entered does not exist. Please try again.',
            );
          } else if (e.code == 'wrong-password') {
            return const CustomAlertDialog(
              title: 'Wrong password',
              message: 'The password you entered is incorrect. Please try again.',
            );
          } else {
            return CustomAlertDialog(
              title: 'Some error occurred',
              message: e.message ?? 'An error occurred while logging in. Please try again.',
            );
          }
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Some error occurred',
          message: e.toString(),
        ),
      );
    }
  }

  static Future<void> registerUser(BuildContext context, String email, String password, Widget pageToRedirect) async {
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      clearStackAndRedirectToPage(context, pageToRedirect);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the CircularProgressIndicator
      showDialog(
        context: context,
        builder: (context) {
          if (e.code == 'email-already-in-use') {
            return const CustomAlertDialog(
              title: 'Email already in use',
              message: 'The email you entered is already in use. Please try with a different email.',
            );
          } else if (e.code == 'weak-password') {
            return const CustomAlertDialog(
              title: 'Weak password',
              message: 'The password you entered is too weak.'
            );
          } else {
            return CustomAlertDialog(
              title: 'Some error occurred',
              message: e.message ?? 'An error occurred while logging in. Please try again.',
            );
          }
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Some error occurred',
          message: e.toString(),
        ),
      );
    }
  }

  static Future<void> googleSignIn(BuildContext context, Widget pageToRedirect) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      Navigator.pop(context);
      return;
    }
    final GoogleSignInAuthentication? googleUserAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleUserAuth?.idToken,
      accessToken: googleUserAuth?.accessToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    clearStackAndRedirectToPage(context, pageToRedirect);
  }
}
