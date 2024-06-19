import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_icon.dart';
import '../components/custom_drawer.dart';
import '../components/product_tile.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';
import '../providers/theme_provider.dart';

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
          CartIconButton(onCartUpdated: () {}),
          // IconButton(icon: const Icon(Icons.view_list), onPressed: () {
          //   setState(() {
          //     _isListView = !_isListView;
          //   });
          // }),
        ],
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder<List<Product>>(
        stream: FirestoreService().fetchAllProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final products = snapshot.data ?? [];
          return Center(
            child: _isListView ? _buildListView(products) : _buildGridView(products),
          );
        },
      ),
    );
  }
  
  Widget _buildListView(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductTile(product: products[index]);
      },
    );
  }

  Widget _buildGridView(List<Product> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductTile(
          product: products[index],
          isGridView: true,
        );
      },
    );
  }
}
