import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/social_login.dart';
import '../providers/auth_provider.dart';
import '../components/alert_dialog.dart';
import '../components/text_field.dart';
import 'auth_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/fsk_logo.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 20),
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
                hintText: 'Re-enter password',
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => registerUser(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    Text('or', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                    assetPath: 'assets/images/google-logo.png', 
                    text: 'Sign up with Google', 
                    onTap: () => signInWithGoogle()
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a user? '),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                    child: Text('Login now', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold)),
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
