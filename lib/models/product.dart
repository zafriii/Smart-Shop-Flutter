class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating rating; 
  int quantity; 

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating, 
    this.quantity = 1, 
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: ProductRating.fromJson(json['rating']),
      quantity: 1, 
    );
  }


  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating, 
      quantity: quantity ?? this.quantity,
    );
  }
}

class ProductRating {
  final double rate;
  final int count;

  ProductRating({
    required this.rate,
    required this.count,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }
}
