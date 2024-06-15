import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/auth_provider.dart';
import '../components/text_field.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();


  Future<void> updateProfileFields() async {
    final user = context.read<UserAuthProvider>().user;
    // Check if the user has changed
    if (user?.displayName != _displayNameController.text) {
      updateDisplayName();
    }

    // Check if the user has changed the password
    if (_newPasswordController.text.isNotEmpty && _currentPasswordController.text.isNotEmpty) {
      updatePassword();
    }
  }

  void updatePassword() async {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Current password is required')));
      return;
    }
    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New password is required')));
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await context.read<UserAuthProvider>().updatePassword(context, currentPassword, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password updated successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update password: $e')));
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

  void deleteUser() async {
    final bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm action', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    ) ?? false;

    if (confirmDelete) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      try {
        await context.read<UserAuthProvider>().deleteUserAndData();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account deleted successfully')));
        Navigator.of(context).popUntil((route) => route.isFirst);
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete account: $e')));
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
                  radius: 60,
                  child: ClipOval(
                    child: context.read<UserAuthProvider>().user?.photoURL != null
                      ? Image.network(
                          context.read<UserAuthProvider>().user!.photoURL!,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
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
            // Field for existing password
            FormTextField(
              controller: _currentPasswordController,
              label: 'Current Password',
              hintText: 'Enter your current password',
              obscureText: true,
              keyboardType: TextInputType.text,
            ),
            // Field for new password
            const SizedBox(height: 20),
            FormTextField(
              controller: _newPasswordController,
              label: 'New Password',
              hintText: 'Enter your new password',
              obscureText: true,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateProfileFields,
              child: const Text('Update'),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Joined on: ${DateFormat('dd MMMM yyyy').format(user?.metadata.creationTime?.toLocal() ?? DateTime.now())}'),
                  GestureDetector(
                    onTap: deleteUser,
                    child: const Text(
                      'Delete', 
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
      ),
    );
  }
}
