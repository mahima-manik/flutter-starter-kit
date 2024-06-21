import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import '../services/payment_service.dart';
import 'cart_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentService _paymentService = PaymentService();
  String _message = 'Initializing payment...'; // Default message
  final CartProvider cartProvider = CartProvider();

  @override
  void initState() {
    super.initState();
    _initPayment();
  }

  Future<void> _initPayment() async {
    try {
      await _paymentService.initPaymentSheet("1000", "USD");
      setState(() {
        _message = 'Payment successful!';
      });
      cartProvider.clearCart();
    } catch (e) {
      setState(() {
        _message = 'Payment failed: ${e.toString()}. Redirecting to cart page.';
      });
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CartPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Text(_message),
        ),
      ),
    );
  }
}
