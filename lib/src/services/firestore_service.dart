import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> fetchAllProducts() async* {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      yield querySnapshot.docs.map((doc) {
        return Product(
          name: doc['name'],
          description: doc['description'],
          price: doc['price'].toDouble(),
          rating: doc['rating'].toDouble(),
          images: List<String>.from(doc['images']),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
