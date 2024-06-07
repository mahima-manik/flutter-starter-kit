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

  void updateDisplayName() async {
    String displayName = _displayNameController.text;
    if (displayName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name is required')));
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await user!.updateDisplayName(displayName);
      await user!.reload();
      user = FirebaseAuth.instance.currentUser;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
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
              onPressed: updateDisplayName,
              child: const Text('Update'),
            ),
            const SizedBox(height: 20),
            Text(user?.displayName ?? 'No name yet'),
          ],
        ),
      ),
    );
  }
}
