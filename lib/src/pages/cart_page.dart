import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_tile.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () => {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: context.read<CartProvider>().totalItems,
        itemBuilder: (context, index) {
          return ProductTile(product: context.read<CartProvider>().getProductByIndex(index));
        },
      ),
    );
  }
}
