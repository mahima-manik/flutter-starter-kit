import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/text_field.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _displayNameController = TextEditingController();
  User? user;
  
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _displayNameController.text = user!.displayName ?? '';
    }
    FirebaseAuth.instance.userChanges().listen((User? user) {
      setState(() {
        this.user = user;
      });
    });
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
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
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
                GestureDetector(
                  onTap: () {
                    // Implement your tap functionality here
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle
                    ),
                    child: Icon(Icons.edit, size: 15, color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
              ],
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
          ],
        ),
      ),
    );
  }
}
