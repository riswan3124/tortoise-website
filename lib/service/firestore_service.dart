import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class FirestoreService {
  final CollectionReference _productsRef = FirebaseFirestore.instance
      .collection('products');

  Future<List<Product>> getAllProducts() async {
    final snapshot = await _productsRef.get();
    return snapshot.docs
        .map(
          (doc) =>
              Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final snapshot = await _productsRef
        .where('category', isEqualTo: category)
        .get();
    return snapshot.docs
        .map(
          (doc) =>
              Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  Future<List<Product>> getProductsByBrand(String brand) async {
    final snapshot = await _productsRef.where('brand', isEqualTo: brand).get();
    return snapshot.docs
        .map(
          (doc) =>
              Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }
}
