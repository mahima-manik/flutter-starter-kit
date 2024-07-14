import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import 'storage_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> fetchAllProducts() async* {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      List<Product> products = [];
      for (var doc in querySnapshot.docs) {
        List<String> imageUrls = await StorageService().getProductImages(doc.id);
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
      }
      yield products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
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
