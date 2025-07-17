import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _favorites = [];
  List<String> _categories = [];

  List<Product> get products => _products;
  List<Product> get favorites => _favorites;
  List<String> get categories => _categories;

  Future<void> fetchProducts([String? category]) async {
    String url = 'https://fakestoreapi.com/products';
    if (category != null && category.isNotEmpty) {
      url = 'https://fakestoreapi.com/products/category/$category';
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _products = data.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      _categories = List<String>.from(json.decode(response.body));
      notifyListeners();
    }
  }

  void toggleFavorite(Product product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
