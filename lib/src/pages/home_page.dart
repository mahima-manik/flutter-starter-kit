import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'product_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  String? getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.brightness_4), onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          }),
        ],
      ),
  drawer: Drawer(
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              DrawerHeader(
              child: Column(
                children: [
                  Expanded(
                    child: FirebaseAuth.instance.currentUser?.photoURL != null
                      ? CircleAvatar(
                          radius: 30,
                          child: ClipOval(
                            child: Image.network(
                              FirebaseAuth.instance.currentUser!.photoURL!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.person, size: 30),
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('H O M E'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary),
              title: Text('Logout', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context); // Close the drawer
              },
            ),
        ),
      ],
    ),
  ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (getUserEmail() != null) Text('Signed in as ${getUserEmail()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductInfoPage(
                    product: Product(
                      name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
                      description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
                      price: 10,
                      images: ['https://picsum.photos/200/300', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
                    ),
                  )),
                );
              },
              child: const Text('Go to Product Page'),
            ),
        ],
      ),
      )
  );
  }
}
