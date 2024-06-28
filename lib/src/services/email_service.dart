import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailService {
  final String _apiKey = dotenv.get('RESEND_API_KEY');

  Future<void> sendOrderConfirmationEmail(String toEmail, String orderId, double totalAmount) async {
    final url = Uri.parse('https://api.resend.com/emails');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };
    final body = jsonEncode({
      'from': dotenv.get('SENDER_EMAIL_ADDRESS'),
      'to': toEmail,
      'subject': 'Order Confirmation',
      'html': '<h1>Order Confirmation</h1><p>Thank you for your order. Your order ID is $orderId and the total amount is \$${totalAmount.toStringAsFixed(2)}.</p>',
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode != 200) {
        throw Exception('Failed to send email: ${response.body}');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
