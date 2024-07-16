import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import 'storage_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> fetchAllProducts() {
    final StreamController<List<Product>> controller = StreamController();
    List<Product> products = [];

    _firestore.collection('products').snapshots().listen((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        List<String> imageUrls =
            await StorageService().getProductImages(doc.id);
        if (imageUrls.isEmpty) {
          imageUrls.add(await StorageService().getDefaultProductImage());
        }

        double? price = _parseDouble(doc['price']);
        double? rating = _parseDouble(doc['rating']) ?? 0.0;

        if (price == null) {
          continue; // Skip this entry if price cannot be converted to double
        }

        Product product = Product(
          id: doc.id,
          name: doc['name'],
          description: doc['description'],
          price: price,
          rating: rating,
          images: imageUrls,
        );
        products.add(product);
        controller.add(List.from(
            products)); // Add a copy of the current list to the stream
      }
    }, onError: (e) {
      controller.addError('Failed to fetch products: $e');
    });

    return controller.stream;
  }

  double? _parseDouble(dynamic value) {
    try {
      if (value is String) {
        return double.parse(value);
      } else if (value is num) {
        return value.toDouble();
      }
    } catch (e) {
      print('Failed to parse value to double: $e');
    }
    return null;
  }
}
