class CartItem {
  final String productId;
  int quantity;
  double price;

  CartItem({required this.productId, required this.quantity, required this.price});

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }

  double get totalPrice => quantity * price;
}
