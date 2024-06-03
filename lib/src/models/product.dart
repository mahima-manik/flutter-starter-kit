// create a model to store product details
class Product {
  final String name;
  final String description;
  final double price;
  final List<String> images;

  Product({
    required this.name, 
    required this.description, 
    required this.price, 
    List<String>? images
  }) : images = images ?? ['assets/images/default_product_image.png'];
}
