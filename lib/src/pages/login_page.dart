import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/alert_dialog.dart';
import '../components/text_field.dart';
import 'auth_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void clearStackAndRedirectToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
      (Route<dynamic> route) => false, // This predicate will always return false, removing all routes below the new route
    );
  }
  
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
      clearStackAndRedirectToHomePage(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the CircularProgressIndicator
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
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage())),
                child: const Text('Not a user? Register now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
