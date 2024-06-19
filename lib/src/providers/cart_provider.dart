import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _itemsMap = {};

  // Adds a product to the cart or increases its quantity if it already exists
  void addToCart(Product product, int quantity) {
    if (_itemsMap.containsKey(product.id)) {
      _itemsMap[product.id]!.quantity += quantity;
    } else {
      _itemsMap[product.id] = CartItem(product, quantity: quantity);
    }
    notifyListeners();
  }

  // Removes a specific quantity of a product from the cart or the entire product if the quantity to remove is all or more
  void removeFromCart(String productId, int quantity) {
    if (_itemsMap.containsKey(productId)) {
      if (_itemsMap[productId]!.quantity > quantity) {
        _itemsMap[productId]!.quantity -= quantity;
      } else {
        _itemsMap.remove(productId);
      }
      notifyListeners();
    }
  }

  // Returns the total count of all items in the cart
  int get totalItems => _itemsMap.values.fold(0, (total, item) => total + item.quantity);

  // Returns the total count of unique products in the cart
  int get totalProducts => _itemsMap.length;

  double get totalAmount => _itemsMap.values.fold(0, (total, item) => total + item.product.price * item.quantity);

  // Checks if a product exists in the cart and returns its count
  int getProductCount(String productId) {
    return _itemsMap.containsKey(productId) ? _itemsMap[productId]!.quantity : 0;
  }

  // Retrieves a CartItem by product ID
  CartItem? getCartItemById(String productId) {
    return _itemsMap[productId];
  }

  // Retrieves a Product by product ID
  Product? getProductById(String productId) {
    return _itemsMap.containsKey(productId) ? _itemsMap[productId]!.product : null;
  }

  // Retrieves a product by index, useful for item builders
  Product? getProductByIndex(int index) {
    if (index >= 0 && index < _itemsMap.length) {
      return _itemsMap.values.elementAt(index).product;
    }
    return null;
  }

  // Retrieves all cart items as a list, useful for item builders
  List<CartItem> getCartItems() {
    return _itemsMap.values.toList();
  }
}
