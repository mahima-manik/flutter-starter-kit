import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../services/payment_service.dart';
import 'cart_page.dart';
import 'order_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentService _paymentService = PaymentService();
  String _message = 'Initializing payment...'; // Default message
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPayment();
    });
  }

  Future<void> _initPayment() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    var cartItems = cartProvider.getCartItems();
    
    try {
      final cartValue = cartProvider.getCartTotal() * 100;
      await _paymentService.initPaymentSheet(cartValue.toInt().toString(), 'USD');
      setState(() {
        _message = 'Payment successful!\n\nRedirecting to order page...';
      });
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrderPage(cartItems: cartItems)),
        ).then((_) => cartProvider.clearCart());
      });
    } catch (e) {
      setState(() {
        _message = 'Payment failed: ${e.toString()}\n\nRedirecting to cart page...';
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
