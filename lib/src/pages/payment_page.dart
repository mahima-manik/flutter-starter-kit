import 'package:flutter/material.dart';
import '../services/payment_service.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentService _paymentService = PaymentService();

  @override
  void initState() {
    super.initState();
    _initPayment();
  }

  Future<void> _initPayment() async {
    await _paymentService.initPaymentSheet("1000", "USD");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: const Center(
        child: Text('Initializing payment...'),
      ),
    );
  }
}