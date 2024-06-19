import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../pages/product_info.dart';
import '../providers/cart_provider.dart';
import 'star_rating.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final bool isGridView;

  const ProductTile({super.key, required this.product, this.isGridView = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfoPage(product: product))),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicHeight(
          child: isGridView ? _buildGridContent(context) : _buildListContent(context),
        ),
      ),
    );
  }

  Widget _buildListContent(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.images.first,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                product.name,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              StarRating(rating: product.rating),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      int productCount = cartProvider.getProductCount(product.id);
                      return productCount == 0
                      ? ElevatedButton(
                        onPressed: () {
                          cartProvider.addToCart(product, 1);
                        },
                        child: const Text('Add'),
                      )
                      : Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Theme.of(context).colorScheme.primary),
                              onPressed: () {
                                cartProvider.removeFromCart(product.id, 1);
                              },
                            ),
                            Text('$productCount'),
                            IconButton(onPressed: () {
                              cartProvider.addToCart(product, 1);
                            }, icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary))
                          ],
                        );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
    ],
  );
}

  Widget _buildGridContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Changed to center the content
      children: <Widget>[
        Expanded(
          flex: 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.images.first,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline, color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          ),
        ),
        Flexible(
          child: Column(
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      int productCount = cartProvider.getProductCount(product.id);
                      return productCount == 0
                      ? ElevatedButton(
                        onPressed: () {
                          cartProvider.addToCart(product, 1);
                        },
                        child: const Text('Add'),
                      )
                      : Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Theme.of(context).colorScheme.primary),
                              onPressed: () {
                                cartProvider.removeFromCart(product.id, 1);
                              },
                            ),
                            Text('$productCount'),
                            IconButton(
                              icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
                              onPressed: () {
                                cartProvider.addToCart(product, 1);
                              },
                            ),
                          ],
                        );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
