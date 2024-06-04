import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductInfoPage extends StatelessWidget {
  final Product product;

  const ProductInfoPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.images.length,
              itemBuilder: (context, index) {
                return Image.network(product.images[index]);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(product.name),
                Text(product.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
