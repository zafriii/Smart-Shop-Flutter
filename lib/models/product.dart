// // lib/models/product.dart
// class Product {
//   final int id;
//   final String title;
//   final double price;
//   final String description;
//   final String category;
//   final String image;
//   final double rating;
//   int quantity; // Added quantity to the Product model

//   Product({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.category,
//     required this.image,
//     required this.rating,
//     this.quantity = 1, // Default quantity to 1 when a product is created
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       title: json['title'],
//       price: (json['price'] as num).toDouble(),
//       description: json['description'],
//       category: json['category'],
//       image: json['image'],
//       rating: (json['rating']['rate'] as num).toDouble(),
//       quantity: 1, // Initialize quantity to 1 when parsed from JSON for cart
//     );
//   }

//   // Method to create a copy of the product with updated quantity
//   Product copyWith({int? quantity}) {
//     return Product(
//       id: id,
//       title: title,
//       price: price,
//       description: description,
//       category: category,
//       image: image,
//       rating: rating,
//       quantity: quantity ?? this.quantity,
//     );
//   }
// }












// lib/models/product.dart

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating rating; // Changed from double to ProductRating
  int quantity; // Added quantity to the Product model

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating, // Now requires ProductRating object
    this.quantity = 1, // Default quantity to 1 when a product is created
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      // Correctly parse the nested 'rating' JSON object into a ProductRating instance
      rating: ProductRating.fromJson(json['rating']),
      quantity: 1, // Initialize quantity to 1 when parsed from JSON for cart
    );
  }

  // Method to create a copy of the product with updated quantity
  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating, // Keep the existing rating object
      quantity: quantity ?? this.quantity,
    );
  }
}

// New class to represent the nested 'rating' object from the API
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