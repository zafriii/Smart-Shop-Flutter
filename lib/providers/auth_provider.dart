// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthProvider with ChangeNotifier {
//   bool _isLoggedIn = false;

//   bool get isLoggedIn => _isLoggedIn;

//   Future<void> checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//     notifyListeners();
//   }

//   Future<void> login() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//     _isLoggedIn = true;
//     notifyListeners();
//   }

//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     _isLoggedIn = false;
//     notifyListeners();
//   }
// }













import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail');
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // You can add validation logic here or API call
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}
