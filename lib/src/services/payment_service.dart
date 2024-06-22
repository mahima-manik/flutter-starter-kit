import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'email_service.dart';

class PaymentService {
  final EmailService _emailService = EmailService();

  Future<void> initPaymentSheet(String amount, String currency, String userEmail, String userName, String userAddress) async {
    // Create a customer
    final customerData = await _createStripeCustomer(userEmail, userName, userAddress);
    final customerId = customerData['id'];
    
    // Create payment intent
    final paymentIntentData = await _createPaymentIntent(amount, currency, customerId);
    
    // Check if payment intent is successful
    if (paymentIntentData.containsKey('error')) {
      throw Exception('Payment intent failed: ${paymentIntentData['error']}');
    }

    // Initialize the payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData['client_secret'],
        merchantDisplayName: dotenv.env['MERCHANT_NAME'],
        customerId: customerId,
        customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
        googlePay: PaymentSheetGooglePay(
          currencyCode: currency,
          merchantCountryCode: 'US',
          testEnv: true,
          label: 'Test Payment',
          amount: amount,
        ),
        style: ThemeMode.system,
      ),
    );

    // Present the payment sheet
    await Stripe.instance.presentPaymentSheet().then((value) {
      print('Payment succeeded: $value');
      // Assuming you have access to necessary order details here
    _emailService.sendOrderConfirmationEmail(userEmail, 'orderId', double.parse(amount)/100).catchError((emailError) {
      print('Failed to send confirmation email: $emailError');
    });
    }).catchError((error) {
      print('Error presenting payment sheet: $error');
      throw Exception('Payment cancelled or failed');
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
  }
}
