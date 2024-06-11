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
  bool _isListView = true;
  
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
          IconButton(icon: const Icon(Icons.view_list), onPressed: () {
            setState(() {
              _isListView = !_isListView;
            });
          }),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: _isListView ? _buildListView() : _buildGridView(),
      ),
  );
  }
  Widget _buildListView() {
    return ListView(
      children: <Widget>[
        ProductTile(product: Product(
          name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
          description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
          price: 10,
          images: ['https://picsum.photos/200/300', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
        )),
      ],
    );
  }

  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      children: <Widget>[
        ProductTile(
          product: Product(
            name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
            description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
            price: 10,
            images: ['https://picsum.photos/200/300', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
          ),
          isGridView: true,
        ),
        ProductTile(
          product: Product(
            name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
            description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
            price: 10,
            images: ['https://picsum.photos/300', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
          ),
          isGridView: true,
        ),
        ProductTile(
          product: Product(
            name: 'Dettol Skincare Handwash - Moisturizing and Hydrating', 
            description: 'Dettol Skincare Handwash is our Signature product and is bestseller',
            price: 10,
            images: ['https://picsum.photos/400', 'https://picsum.photos/300', 'https://picsum.photos/400/300'],
          ),
          isGridView: true,
        ),
      ],
    );
  }
}
