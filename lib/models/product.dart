class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String imageUrl;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
    );
  }
}
