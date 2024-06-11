import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_provider.dart';
import '../components/custom_drawer.dart';
import '../components/product_tile.dart';
import '../models/product.dart';
import '../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.brightness_4), onPressed: () {
            context.read<ThemeProvider>().toggleTheme();
          }),
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {
            
          }),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ProductTile(product: Product(
              name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
              description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
              price: 10,
              images: ['https://picsum.photos/200/300', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
            )),
            const SizedBox(height: 10),
            ProductTile(product: Product(
              name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
              description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
              price: 10,
              images: ['https://picsum.photos/300', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
            )),
            const SizedBox(height: 10),
            ProductTile(product: Product(
              name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
              description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
              price: 10,
              images: ['https://picsum.photos/400', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
            )),
          ],
        ),
      ),
  );
  }
}
