
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, Product> _cartItems = {}; 

  Map<int, Product> get cartItems {
    return {..._cartItems}; 
  }

  int get itemCount {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return _cartItems.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
        product.id,
        (existingProduct) => existingProduct.copyWith(
          quantity: existingProduct.quantity + 1,
        ),
      );
    } else {
    
      _cartItems.putIfAbsent(
        product.id,
        () => product.copyWith(quantity: 1), 
      );
    }
    notifyListeners(); 
  }

  void removeFromCart(int productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    if (_cartItems.containsKey(productId)) {
      if (newQuantity <= 0) {
        _cartItems.remove(productId);
      } else {
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
