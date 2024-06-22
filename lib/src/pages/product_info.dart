import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cart_icon.dart';
import '../components/expandable_text_tile.dart';
import '../components/image_gallery.dart';
import '../components/star_rating.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductInfoPage extends StatefulWidget {
  final Product product;

  const ProductInfoPage({super.key, required this.product});

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  int currentQuantity = 0;

  @override
  void initState() {
    super.initState();
    currentQuantity = context.read<CartProvider>().getProductCount(widget.product.id);
  }

  void incrementQuantity() {
    setState(() {
      currentQuantity++;
    });
    context.read<CartProvider>().addToCart(widget.product, 1);
  }

  void decrementQuantity() {
    setState(() {
      currentQuantity--;
    });
    context.read<CartProvider>().removeFromCart(widget.product.id, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => {},
          ),
          CartIconButton(onCartUpdated: () {
            setState(() {
              currentQuantity = context.read<CartProvider>().getProductCount(widget.product.id);
            });
          },),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox( // This is used to set the maximum height of the ImageGallery to 40% of the screen's height.
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ImageGallery(imageUrls: widget.product.images),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StarRating(rating: widget.product.rating),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.name,
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
                        '\$ ${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return currentQuantity == 0
                            ? ElevatedButton(
                                onPressed: () {
                                  incrementQuantity();
                                },
                                child: const Text('Add'),
                              )
                            : Row(
                                children: [
                                  IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  decrementQuantity();
                                },
                              ),
                                Text('$currentQuantity'),
                                IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  incrementQuantity();
                                },
                              ),
                          ],
                        );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ExpandableTextTile(
                    title: 'Product Description',
                    text: widget.product.description,
                    icon: Icons.info_outline,
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
