import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cart_tile.dart';
import '../providers/cart_provider.dart';
import 'home_page.dart';
import 'payment_page.dart';

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
          return Column(
            children: [
              Expanded(
                child: cartProvider.totalProducts == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart, size: 50),
                            const SizedBox(height: 20),
                            const Text('Your cart is empty'),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                              },
                              child: const Text('Add Products'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
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
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage()));
                      },
                      child: const Text('Pay Now'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
