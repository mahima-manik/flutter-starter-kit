import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class OrderPage extends StatelessWidget {
  final List<CartItem> cartItems;

  const OrderPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item.product.images.first, width: 50, height: 50),
                  title: Text(item.product.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          const Divider(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
