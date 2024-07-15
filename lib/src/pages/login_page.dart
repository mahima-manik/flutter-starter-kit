import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../components/alert_dialog.dart';
import '../components/social_login.dart';
import '../components/text_field.dart';
import 'auth_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void clearStackAndRedirectToPage(Widget pageToRedirect) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageToRedirect),
      (Route<dynamic> route) => false, // This predicate will always return false, removing all routes below the new route
    );
  }

  Future<void> signInWithUsernameAndPassword() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const CustomAlertDialog(
          title: 'Something went wrong',
          message: 'Please enter your email and password.',
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await context.read<UserAuthProvider>().signInWithUsernameAndPassword(emailController.text.trim(), passwordController.text.trim());
      clearStackAndRedirectToPage(const AuthPage());
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
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
      if (!mounted) return;
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
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/fsk_logo.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Flutter Starter Kit',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        'Forgot password?', 
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => signInWithUsernameAndPassword(),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    child: Text('Login', style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),),
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
                children: [
                  SocialLoginButton(
                    assetPath: 'assets/images/google-logo.png', 
                    text: 'Sign in with Google', 
                    onTap: () => signInWithGoogle()
                  ),
                ],
              ),
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a user? '),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())),
                    child: Text('Sign up', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),),
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
