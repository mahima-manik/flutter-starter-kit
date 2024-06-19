import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartTile({
    super.key,
    required this.cartItem,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        horizontalTitleGap: 10,
        leading: Image.network(cartItem.product.images[0], width: 50, height: 50),
        title: Text(cartItem.product.name),
        subtitle: Text('\$${cartItem.product.price.toStringAsFixed(2)}'),
        trailing: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onRemove,
              ),
              Text(cartItem.quantity.toString(), style: Theme.of(context).textTheme.titleMedium),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onAdd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
