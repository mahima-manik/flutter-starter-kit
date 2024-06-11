import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/src/models/product.dart';

import '../pages/product_info.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductInfoPage(product: product)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              product.images[0],
              width: 100,
              height: 100,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Text(product.name),
                  Text(product.price.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
