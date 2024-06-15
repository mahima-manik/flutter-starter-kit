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
        Product product = Product(
          id: doc.id,
          name: doc['name'],
          description: doc['description'],
          price: doc['price'].toDouble(),
          rating: doc['rating'].toDouble(),
          images: imageUrls,
        );
        products.add(product);
      }
      yield products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
