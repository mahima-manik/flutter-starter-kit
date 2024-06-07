import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/text_field.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _displayNameController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  void initState() {
    super.initState();
    if (user != null) {
      _displayNameController.text = user!.displayName ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            user?.photoURL != null
              ? CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: Image.network(
                      user!.photoURL!,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(Icons.person, size: 30, color: Theme.of(context).colorScheme.onSecondary),
                ),
            const SizedBox(height: 20),
            FormTextField(
                controller: _displayNameController,
                label: 'Name',
                hintText: 'Enter your full name',
                obscureText: false,
                keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
