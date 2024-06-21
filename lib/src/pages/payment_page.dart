import 'package:flutter/material.dart';
import '../services/payment_service.dart';

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
    _initPayment();
  }

  Future<void> _initPayment() async {
    try {
      await _paymentService.initPaymentSheet("1000", "USD");
      setState(() {
        _message = 'Payment successful!';
      });
      // Clear the cart here or navigate to a success page
    } catch (e) {
      setState(() {
        _message = 'Payment failed: ${e.toString()}';
      });
      // Handle failure, possibly allowing retry
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        child: Text(_message),
      ),
    );
  }
}
