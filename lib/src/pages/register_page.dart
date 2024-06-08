import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_provider.dart';
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

  void clearStackAndRedirectToPage(Widget pageToRedirect) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageToRedirect),
      (Route<dynamic> route) => false, // This predicate will always return false, removing all routes below the new route
    );
  }
  Future<void> registerUser() async {
    // Check email and password
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty || confirmPasswordController.text.trim().isEmpty) {
      return;
    }
    // Check if password and confirm password match
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      showDialog(
        context: context,
        builder: (context) => const CustomAlertDialog(
          title: 'Some error occurred',
          message: 'The two password fields didn\'t match',
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await context.read<UserAuthProvider>().registerUser(emailController.text.trim(), passwordController.text.trim());
      if (!mounted) return;
      if (context.read<UserAuthProvider>().user == null) { 
        Navigator.pop(context);
        return;
      }
      clearStackAndRedirectToPage(const AuthPage());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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

  Future<void> signInWithGoogle() async {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await context.read<UserAuthProvider>().googleSignIn();
      if (!mounted) return;
      if (context.read<UserAuthProvider>().user == null) { 
        Navigator.pop(context);
        return;
      }
      clearStackAndRedirectToPage(const AuthPage());
    } catch (e) {
      if (!mounted) return;
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Or continue with', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => signInWithGoogle(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Theme.of(context).colorScheme.surface),
                      child: Image.asset(
                        'assets/images/google-logo.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Theme.of(context).colorScheme.surface),
                    child: Image.asset(
                      'assets/images/facebook-logo.png',
                      width: 35,
                      height: 35,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a user? '),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                    child: const Text('Login now', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
