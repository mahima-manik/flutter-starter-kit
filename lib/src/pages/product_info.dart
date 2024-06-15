import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/image_gallery.dart';
import '../components/quantity_selector.dart';
import '../components/star_rating.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductInfoPage extends StatelessWidget {
  final Product product;

  const ProductInfoPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox( // This is used to set the maximum height of the ImageGallery to 40% of the screen's height.
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ImageGallery(imageUrls: product.images),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StarRating(rating: product.rating),
                  const SizedBox(height: 10),
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: MediaQuery.of(context).size.width * 0.05, // This sets the font size to be 5% of the screen's width.
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${product.price}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuantitySelector(
                        initialQuantity: quantity,
                        onQuantityChanged: (int newQuantity) {
                          quantity = newQuantity;
                          context.read<CartProvider>().addToCart(CartItem(product, quantity: quantity));
                        },
                      ),
                    ],
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
          ],
        ),
      ),
    );
  }
}
