import 'package:flutter/material.dart';

class ProductInfoPage extends StatelessWidget {

  const ProductInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Info'),
      ),
      body: 
        const Center(
          child: Column(
            children: [
              Text('Product Info'),
            ],
          ),
        ),
      
    );
  }
}
