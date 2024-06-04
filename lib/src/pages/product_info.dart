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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ImageGallery(imageUrls: product.images),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: MediaQuery.of(context).size.width * 0.05, // This sets the font size to be 5% of the screen's width.
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      '\$ ${product.price}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    tilePadding: const EdgeInsets.only(left: 0, right: 15),
                    title: const Text('Product Information'),
                    shape: const Border(),
                    controlAffinity: ListTileControlAffinity.trailing,
                    initiallyExpanded: false,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.info_outlined),
                        title: Text(product.description),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
