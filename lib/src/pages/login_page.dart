import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/sample_logo.png',
                width: 200,
                height: 200,
              ),
              const Text(
                'hey there!',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              FormTextField(
                controller: emailController,
                label: 'Email',
                hintText: 'Enter your email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              FormTextField(
                controller: passwordController,
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => loginUser(),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
