import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserAuthProvider>().user;

    return Scaffold(
      body: user == null ? const LoginPage() : const HomePage(),
    );
  }
}
