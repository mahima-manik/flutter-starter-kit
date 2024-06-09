import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/auth_provider.dart';
import '../components/text_field.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _displayNameController = TextEditingController();

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
      await context.read<UserAuthProvider>().updateDisplayName(displayName);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
    }
  }

  void updateDisplayPhoto() async {
    final ImagePicker _picker = ImagePicker();
    // Open the image picker
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        // Use the selected image's path
        await context.read<UserAuthProvider>().updateUserPhoto(context, image.path);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile picture updated successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
      } finally {
        Navigator.pop(context); // Ensure the progress dialog is closed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuthProvider>(context).user;
    if (user != null) {
      _displayNameController.text = user.displayName ?? '';
    }
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
                CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: context.read<UserAuthProvider>().user?.photoURL != null
                      ? Image.network(
                          context.read<UserAuthProvider>().user!.photoURL!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 30, color: Theme.of(context).colorScheme.onSecondary),
                        )
                      : Icon(Icons.person, size: 30, color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
                GestureDetector(
                  onTap: updateDisplayPhoto,
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
            Consumer<UserAuthProvider>(
              builder: (context, value, child) => FormTextField(
                controller: _displayNameController,
                label: 'Name',
                hintText: 'Enter your full name',
                obscureText: false,
                keyboardType: TextInputType.name,
              ),
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
