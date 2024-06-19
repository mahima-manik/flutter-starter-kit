import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<void> initPaymentSheet(String amount, String currency) async {
    try {
      // 1. create payment intent on the server
      final paymentIntentData = await _createPaymentIntent(amount, currency);
      print(paymentIntentData);
    } catch (e) {
      print(e);
    }
  }
  Future<Map<String, dynamic>> _createPaymentIntent(String amount, String currency) async {
    try {
      // Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      // Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
