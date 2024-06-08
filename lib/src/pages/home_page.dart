import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auth_provider.dart';
import '../components/custom_drawer.dart';
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
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuthProvider>(context, listen: true).user;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.brightness_4), onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          }),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.displayName != null) Text('Welcome, ${user?.displayName}'),
            if (user?.email != null) Text('Signed in as ${user?.email}'),
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
