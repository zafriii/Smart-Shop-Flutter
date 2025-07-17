// import 'package:flutter/material.dart';
// import '../models/product.dart';

// class CartProvider with ChangeNotifier {
//   final Map<int, Product> _cartItems = {};

//   Map<int, Product> get cartItems => _cartItems;

//   void addToCart(Product product) {
//     _cartItems[product.id] = product;
//     notifyListeners();
//   }

//   void removeFromCart(int productId) {
//     _cartItems.remove(productId);
//     notifyListeners();
//   }

//   double get totalPrice {
//     return _cartItems.values.fold(0.0, (sum, item) => sum + item.price);
//   }

//   int get itemCount => _cartItems.length;

//   void clearCart() {
//     _cartItems.clear();
//     notifyListeners();
//   }
// }





import 'package:flutter/foundation.dart';
import '../models/product.dart'; // Ensure your Product model has the 'quantity' field

class CartProvider with ChangeNotifier {
  // Using a Map where key is product ID and value is the Product object
  // This allows direct access and modification of product quantities in the cart
  final Map<int, Product> _cartItems = {}; // Changed key type to int for product ID

  Map<int, Product> get cartItems {
    return {..._cartItems}; // Return a copy to prevent external modification
  }

  // Calculate total number of items (sum of all quantities)
  int get itemCount {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  // Calculate total price (price * quantity for each item)
  double get totalPrice {
    return _cartItems.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      // If product already in cart, update its quantity
      _cartItems.update(
        product.id,
        (existingProduct) => existingProduct.copyWith(
          quantity: existingProduct.quantity + 1,
        ),
      );
    } else {
      // If product not in cart, add it with quantity 1
      _cartItems.putIfAbsent(
        product.id,
        () => product.copyWith(quantity: 1), // Ensure new product starts with quantity 1
      );
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void removeFromCart(int productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  // New method to update the quantity of an item in the cart
  void updateQuantity(int productId, int newQuantity) {
    if (_cartItems.containsKey(productId)) {
      if (newQuantity <= 0) {
        // If new quantity is 0 or less, remove the item from the cart
        _cartItems.remove(productId);
      } else {
        // Update the quantity of the existing product
        _cartItems.update(
          productId,
          (existingProduct) => existingProduct.copyWith(quantity: newQuantity),
        );
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
