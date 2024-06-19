import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../pages/cart_page.dart';

class CartIconButton extends StatelessWidget {
  final Function() onCartUpdated;
  const CartIconButton({super.key, required this.onCartUpdated});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Cart',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                ).then((value) => {
                  onCartUpdated()
                });
              },
            ),
            if (cart.totalItems > 0)
              CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Text(
                  cart.totalItems.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
