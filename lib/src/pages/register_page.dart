import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/alert_dialog.dart';
import '../components/text_field.dart';
import 'auth_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void clearStackAndRedirectToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
      (Route<dynamic> route) => false, // This predicate will always return false, removing all routes below the new route
    );
  }

  void registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return;
    }
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => const CustomAlertDialog(
          title: 'Password mismatch',
          message: 'The password and confirm password fields do not match. Please try again.',
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      clearStackAndRedirectToHomePage(context);
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
                'let\'s get started!',
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
              const SizedBox(height: 20),
              FormTextField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hintText: 'Reenter password',
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => registerUser(),
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                child: const Text('Already a user? Login now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
