import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/profile_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                child: Column(
                  children: [
                    Expanded(
                      child: user?.photoURL != null
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
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Edit Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ],
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
                leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                title: Text('Logout', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context); // Close the drawer
                },
              ),
          ),
        ],
      ),
    );
  }
}