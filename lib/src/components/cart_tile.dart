import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartTile({
    Key? key,
    required this.cartItem,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(cartItem.product.images[0], width: 50, height: 50),
      title: Text(cartItem.product.name),
      subtitle: Text('${cartItem.quantity} item(s)'),
      trailing: Container(
        width: 120,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: onRemove,
            ),
            Text('\$${cartItem.totalPrice.toStringAsFixed(2)}'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
