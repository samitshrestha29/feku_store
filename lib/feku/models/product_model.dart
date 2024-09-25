class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int count;
  bool isFavorite;
  final int quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
    this.isFavorite = false, // Initialize as not favorite

    this.quantity = 1, // default quantity is 1
  });

  // Factory method to create a Product from a JSON object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rate: json['rating']['rate'].toDouble(),
      count: json['rating']['count'],
      quantity: 1, // default quantity
    );
  }
}
