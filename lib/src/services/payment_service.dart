import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<void> initPaymentSheet(String amount, String currency) async {
    // Create a customer
    final customerData = await _createStripeCustomer('test@gmail.com', 'Test User', 'Test Address');
    final customerId = customerData['id'];
    
    // Create payment intent
    final paymentIntentData = await _createPaymentIntent(amount, 'USD', customerId);

    // Initialize the payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData['client_secret'],
        merchantDisplayName: dotenv.env['MERCHANT_NAME'],
        customerId: customerId,
        customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
      ),
    );

    // Present the payment sheet
    await Stripe.instance.presentPaymentSheet().then((value) {
      print('Payment succeeded: $value');
    }).catchError((error) {
      print('Error presenting payment sheet: $error');
      throw Exception('Payment cancelled or failed'); // Throw an exception if payment is cancelled or fails
    });
  }

  Future<Map<String, dynamic>> _createStripeCustomer(String email, String name, String address) async {
    var body = {
      'email': email,
      'name': name,
      'address[line1]': address,
      'address[city]': 'San Francisco',
      'address[state]': 'CA',
      'address[postal_code]': '94101',
      'address[country]': 'US',
      'phone': '+1234567890',
    };

    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/customers'),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _createPaymentIntent(String amount, String currency, String customerId) async {
    try {
      // Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'customer': customerId,
        'description': 'Payment for the test project services'
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
