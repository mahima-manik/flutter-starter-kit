import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  void addToCart(Product product, int quantity) {
    if (_items.containsKey(product.id)) {
      // Increase quantity if item already exists
      _items[product.id]!.quantity += quantity;
    } else {
      // Add new item if it does not exist
      _items[product.id] = CartItem(product, quantity: quantity);
    }
    notifyListeners();
  }

  void removeFromCart(String productId, int quantity) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > quantity) {
        _items[productId]!.quantity -= quantity;
      } else {
        _items.remove(productId);
      }
    }
    notifyListeners();
  }

  int get totalItems => _items.values.fold(0, (total, item) => total + item.quantity);

  int getProductCount(String productId) {
    return _items.containsKey(productId) ? _items[productId]!.quantity : 0;
  }
}
