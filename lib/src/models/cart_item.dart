import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, {required this.quantity});

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }

  double get totalPrice => quantity * product.price;
}
