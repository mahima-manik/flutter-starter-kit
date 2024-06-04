import 'package:flutter/material.dart';
import '../components/image_gallery.dart';
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
            flex: 1,
            child: ImageGallery(imageUrls: product.images),
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
