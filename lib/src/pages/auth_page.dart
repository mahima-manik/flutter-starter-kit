import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/src/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserAuthProvider>().user;

    return Scaffold(
      body: user == null ? LoginPage() : const HomePage(),
    );
  }
}
