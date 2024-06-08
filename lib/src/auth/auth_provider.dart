import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class UserAuthProvider extends ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  UserAuthProvider() {
    _authService.authUserChanges.listen(_onAuthUserChanged);
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
}
