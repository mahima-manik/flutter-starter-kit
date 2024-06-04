import 'package:flutter/material.dart';

import '../components/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
