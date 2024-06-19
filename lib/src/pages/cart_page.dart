import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cart_tile.dart';
import '../providers/cart_provider.dart';
import 'home_page.dart';

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
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
          )
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.totalProducts,
            itemBuilder: (context, index) {
              final cartItem = cartProvider.getCartItems()[index];
              return CartTile(
                cartItem: cartItem,
                onAdd: () {
                  cartProvider.addToCart(cartItem.product, 1);
                },
                onRemove: () {
                  cartProvider.removeFromCart(cartItem.product.id, 1);
                },
              );
            },
          );
        },
      ),
    );
  }
}
