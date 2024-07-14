import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailService {
  final String _apiKey = dotenv.get('RESEND_API_KEY');

  Future<void> sendEmail(String toEmail, String subject, String htmlContent) async {
    final url = Uri.parse('https://api.resend.com/emails');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };
    final body = jsonEncode({
      'from': dotenv.get('SENDER_EMAIL_ADDRESS'),
      'to': toEmail,
      'subject': subject,
      'html': htmlContent,
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

  Future<void> sendOrderConfirmationEmail(String toEmail, String orderId, double totalAmount) async {
    const subject = 'Order Confirmation';
    final htmlContent = '<h1>Order Confirmation</h1><p>Thank you for your order. Your order ID is $orderId and the total amount is \$${totalAmount.toStringAsFixed(2)}.</p>';
    await sendEmail(toEmail, subject, htmlContent);
  }
}
