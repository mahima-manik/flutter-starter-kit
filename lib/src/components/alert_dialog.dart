import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  const CustomAlertDialog({super.key, required this.title, required this.message});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
      content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
