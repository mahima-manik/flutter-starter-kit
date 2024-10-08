class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final List<String> images;

  Product({
    required this.id,
    required this.name, 
    required this.description, 
    required this.price, 
    this.rating = 0.0,
    List<String>? images
  }) : images = images ?? ['assets/images/default_product_image.png'];
}
