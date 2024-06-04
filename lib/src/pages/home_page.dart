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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.brightness_4), onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          })
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductInfoPage(
                    product: Product(
                      name: 'Product 1', 
                      description: 'Description 1',
                      price: 100,
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
