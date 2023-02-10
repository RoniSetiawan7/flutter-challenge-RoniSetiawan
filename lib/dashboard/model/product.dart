class Product {
  final int id;
  final String title;
  final String? description;
  final int price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String brand;
  final String category;
  final String? thumbnail;
  final List<String>? images;

  Product({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    required this.brand,
    required this.category,
    this.thumbnail,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'],
      description: json['description'] as String,
      price: json['price'] as int,
      discountPercentage: json['discountPercentage'] as double,
      rating: json['rating'] as double,
      stock: json['stock'] as int,
      brand: json['brand'] as String,
      category: json['category'] as String,
      thumbnail: json['thumbnail'] as String,
      images: List<String>.from(json['images'].map((x) => x)),
    );
  }
}
