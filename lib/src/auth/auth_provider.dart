import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class UserAuthProvider extends ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  UserAuthProvider() {
    _authService.authStateChanges.listen(_onAuthUserChanged);
    _authService.userChanges.listen(_onAuthUserChanged);
  }

  void _onAuthUserChanged(User? user) {
    _user = user;
    notifyListeners();
  }

  User? get user => _user;

  Future<void> registerUser(String email, String password) async {
    _user = await _authService.registerUser(email, password);
    notifyListeners();
  }

  Future<void> signInWithUsernameAndPassword(String email, String password) async {
    _user = await _authService.signInWithUsernameAndPassword(email, password);
    notifyListeners();
  }

  Future<void> googleSignIn() async {
    _user = await _authService.googleSignIn();
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> updateDisplayName(String displayName) async {
    await _authService.updateDisplayName(displayName);
    await _user!.reload();
    notifyListeners();
  }

  Future<void> updateUserPhoto(BuildContext context, String photoURL) async {
    await _authService.updateUserPhoto(context, photoURL);
    await _user!.reload();
    notifyListeners();
  }

  Future<void> updatePassword(BuildContext context, String currentPassword, String newPassword) async {
    await _authService.updatePassword(context, currentPassword, newPassword);
    notifyListeners();
  }

  Future<void> deleteUserAndData() async {
    await _authService.deleteUserAndData();
    _user = null;
    notifyListeners();
  }
}
