// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/cart_provider.dart';
// import '../models/product.dart';

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     final cartItems = cartProvider.cartItems.values.toList();

//     return Scaffold(
//       appBar: AppBar(title: Text('My Cart')),
//       body: cartItems.isEmpty
//           ? Center(child: Text('Your cart is empty'))
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: cartItems.length,
//                     itemBuilder: (ctx, i) {
//                       final product = cartItems[i];
//                       return ListTile(
//                         leading: Image.network(product.image, width: 50),
//                         title: Text(product.title),
//                         subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
//                         trailing: IconButton(
//                           icon: Icon(Icons.remove_circle),
//                           onPressed: () => cartProvider.removeFromCart(product.id),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () => cartProvider.clearCart(),
//                         child: Text('Clear Cart'),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//     );
//   }
// }














// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/cart_provider.dart';
// import '../models/product.dart';
// import 'home_screen.dart'; // Import HomeScreen for navigation

// class CartScreen extends StatelessWidget {
//   final double _shippingCharge = 2.00; // Fixed shipping charge

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     final theme = Theme.of(context);
//     final cartItems = cartProvider.cartItems.values.toList();

//     double subTotal = cartProvider.totalPrice;
//     double totalWithShipping = subTotal + _shippingCharge;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: theme.textTheme.headlineSmall?.color,
//       ),
//       body: cartItems.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text(
//                     'Your cart is empty',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => HomeScreen()),
//                       );
//                     },
//                     icon: Icon(Icons.arrow_back),
//                     label: Text('Back to Shop'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: theme.primaryColor,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: EdgeInsets.all(16),
//                     itemCount: cartItems.length,
//                     itemBuilder: (ctx, i) {
//                       final product = cartItems[i];
//                       return Card(
//                         margin: EdgeInsets.only(bottom: 12),
//                         elevation: 0, // Flat card design
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Product Image
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   product.image,
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Container(
//                                     width: 80,
//                                     height: 80,
//                                     color: Colors.grey[200],
//                                     child: Icon(Icons.broken_image, color: Colors.grey),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               // Product Details (Name, Size, Price)
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       product.title,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color: theme.textTheme.bodyLarge?.color,
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       'Size: L', // Placeholder for size
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       '\$${product.price.toStringAsFixed(2)}',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color: theme.primaryColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               // Quantity Controls and Checkmark
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // Checkmark Icon
//                                   Icon(Icons.check_circle, color: theme.primaryColor, size: 24),
//                                   SizedBox(height: 16), // Spacing
//                                   // Quantity Controls
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[200],
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           icon: Icon(Icons.remove, size: 18),
//                                           onPressed: () {
//                                             if (product.quantity > 1) {
//                                               cartProvider.updateQuantity(product.id, product.quantity - 1);
//                                             } else {
//                                               cartProvider.removeFromCart(product.id);
//                                             }
//                                           },
//                                           visualDensity: VisualDensity.compact,
//                                         ),
//                                         Text(
//                                           product.quantity.toString(),
//                                           style: TextStyle(
//                                               fontSize: 16, fontWeight: FontWeight.bold),
//                                         ),
//                                         IconButton(
//                                           icon: Icon(Icons.add, size: 18),
//                                           onPressed: () {
//                                             cartProvider.updateQuantity(product.id, product.quantity + 1);
//                                           },
//                                           visualDensity: VisualDensity.compact,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 // Summary Section
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       _buildSummaryRow(
//                           'Sub-total', '\$${subTotal.toStringAsFixed(2)}', theme),
//                       SizedBox(height: 8),
//                       _buildSummaryRow('Shipping Charge',
//                           '\$${_shippingCharge.toStringAsFixed(2)}', theme),
//                       Divider(height: 24, thickness: 1, color: Colors.grey[300]),
//                       _buildSummaryRow(
//                           'Total', '\$${totalWithShipping.toStringAsFixed(2)}', theme,
//                           isTotal: true),
//                       SizedBox(height: 20),
//                       // Action Buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextButton(
//                             onPressed: () => cartProvider.clearCart(),
//                             style: TextButton.styleFrom(
//                               foregroundColor: theme.primaryColor,
//                             ),
//                             child: Text(
//                               'Clear',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(builder: (_) => HomeScreen()),
//                               );
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: theme.primaryColor,
//                             ),
//                             child: Text(
//                               'Back to Shop',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Implement checkout logic here
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Proceeding to Checkout!')),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.purple.shade700, // Purple color
//                             foregroundColor: Colors.white,
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: Text(
//                             'Proceed to Checkout',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   // Helper widget to build summary rows
//   Widget _buildSummaryRow(String label, String value, ThemeData theme,
//       {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isTotal ? 18 : 16,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: isTotal
//                 ? theme.textTheme.headlineSmall?.color
//                 : theme.textTheme.bodyMedium?.color,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 18 : 16,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: isTotal ? theme.primaryColor : theme.textTheme.bodyMedium?.color,
//           ),
//         ),
//       ],
//     );
//   }
// }





















//4th

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/cart_provider.dart';
// import '../models/product.dart';
// import 'home_screen.dart'; // Import HomeScreen for navigation

// class CartScreen extends StatelessWidget {
//   final double _shippingCharge = 2.00; // Fixed shipping charge

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     final theme = Theme.of(context);
//     final cartItems = cartProvider.cartItems.values.toList();

//     double subTotal = cartProvider.totalPrice;
//     double totalWithShipping = subTotal + _shippingCharge;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: theme.textTheme.headlineSmall?.color,
//       ),
//       body: cartItems.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text(
//                     'Your cart is empty',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => HomeScreen()),
//                       );
//                     },
//                     icon: Icon(Icons.arrow_back),
//                     label: Text('Back to Shop'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: theme.primaryColor,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: EdgeInsets.all(16),
//                     itemCount: cartItems.length,
//                     itemBuilder: (ctx, i) {
//                       final product = cartItems[i];
//                       return Card(
//                         margin: EdgeInsets.only(bottom: 12),
//                         elevation: 0, // Flat card design
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Product Image
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   product.image,
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Container(
//                                     width: 80,
//                                     height: 80,
//                                     color: Colors.grey[200],
//                                     child: Icon(Icons.broken_image, color: Colors.grey),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               // Product Details (Name, Size, Price)
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       product.title,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color: theme.textTheme.bodyLarge?.color,
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     SizedBox(height: 4),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       '\$${product.price.toStringAsFixed(2)}',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         // color: theme.primaryColor,
//                                         color: theme.brightness == Brightness.dark
//                                         ? Colors.white
//                                         : theme.primaryColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               // Quantity Controls and Delete Button
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // Delete Button (removed checkmark)
//                                   GestureDetector(
//                                     onTap: () => cartProvider.removeFromCart(product.id),
//                                     child: Container(
//                                       padding: EdgeInsets.all(4),
//                                       decoration: BoxDecoration(
//                                         color: Colors.red.withOpacity(0.1), // Light red background
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Icon(Icons.delete_outline, color: Colors.red, size: 20),
//                                     ),
//                                   ),
//                                   SizedBox(height: 16), // Spacing
//                                   // Quantity Controls
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[200],
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           icon: Icon(Icons.remove, size: 18),
//                                           onPressed: () {
//                                             if (product.quantity > 1) {
//                                               cartProvider.updateQuantity(product.id, product.quantity - 1);
//                                             } else {
//                                               cartProvider.removeFromCart(product.id);
//                                             }
//                                           },
//                                           visualDensity: VisualDensity.compact,
//                                         ),
//                                         Text(
//                                           (product.quantity).toString(),
//                                           style: TextStyle(
//                                               fontSize: 16, fontWeight: FontWeight.bold),
//                                         ),
//                                         IconButton(
//                                           icon: Icon(Icons.add, size: 18),
//                                           onPressed: () {
//                                             cartProvider.updateQuantity(product.id, product.quantity + 1);
//                                           },
//                                           visualDensity: VisualDensity.compact,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 // Summary Section
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       _buildSummaryRow(
//                           'Sub-total', '\$${subTotal.toStringAsFixed(2)}', theme),
//                       SizedBox(height: 8),
//                       _buildSummaryRow('Shipping Charge',
//                           '\$${_shippingCharge.toStringAsFixed(2)}', theme),
//                       Divider(height: 24, thickness: 1, color: Colors.grey[300]),
//                       _buildSummaryRow(
//                           'Total', '\$${totalWithShipping.toStringAsFixed(2)}', theme,
//                           isTotal: true),
//                       SizedBox(height: 20),
//                       // Action Buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextButton(
//                             onPressed: () => cartProvider.clearCart(),
//                             style: TextButton.styleFrom(
//                               foregroundColor: theme.primaryColor,
//                             ),
//                             child: Text(
//                               'Clear',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(builder: (_) => HomeScreen()),
//                               );
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: theme.primaryColor,
//                             ),
//                             child: Text(
//                               'Back to Shop',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Implement checkout logic here
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Proceeding to Checkout!')),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.purple.shade700, // Purple color
//                             foregroundColor: Colors.white,
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: Text(
//                             'Proceed to Checkout',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   // Helper widget to build summary rows
//   Widget _buildSummaryRow(String label, String value, ThemeData theme,
//       {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isTotal ? 18 : 16,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: isTotal
//                 ? theme.textTheme.headlineSmall?.color
//                 : theme.textTheme.bodyMedium?.color,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 18 : 16,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: isTotal ? theme.primaryColor : theme.textTheme.bodyMedium?.color,
//           ),
//         ),
//       ],
//     );
//   }
// }














import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import 'home_screen.dart'; // Import HomeScreen for navigation

class CartScreen extends StatelessWidget {
  final double _shippingCharge = 2.00; // Fixed shipping charge

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final theme = Theme.of(context);
    final cartItems = cartProvider.cartItems.values.toList();

    double subTotal = cartProvider.totalPrice;
    double totalWithShipping = subTotal + _shippingCharge;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.textTheme.headlineSmall?.color,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Back to Shop'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, i) {
                      final product = cartItems[i];
                      // Determine colors based on theme for quantity controls
                      final isDarkMode = theme.brightness == Brightness.dark;
                      final quantityContainerColor = isDarkMode ? Colors.grey[800] : Colors.grey[200];
                      final quantityTextColor = isDarkMode ? Colors.white : Colors.black;
                      final quantityIconColor = isDarkMode ? Colors.white : Colors.black;

                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        elevation: 0, // Flat card design
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  product.image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[200],
                                    child: Icon(Icons.broken_image, color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              // Product Details (Name, Size, Price)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: theme.textTheme.bodyLarge?.color,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    // Text(
                                    //   'Size: L', // Placeholder for size
                                    //   style: TextStyle(
                                    //     fontSize: 14,
                                    //     color: Colors.grey[600],
                                    //   ),
                                    // ),
                                    SizedBox(height: 8),
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        // color: theme.primaryColor,
                                        color: theme.brightness == Brightness.dark
                                        ? Colors.white
                                        : theme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              // Quantity Controls and Delete Button
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Delete Button
                                  GestureDetector(
                                    onTap: () => cartProvider.removeFromCart(product.id),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.1), // Light red background
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                    ),
                                  ),
                                  SizedBox(height: 16), // Spacing
                                  // Quantity Controls
                                  Container(
                                    decoration: BoxDecoration(
                                      color: quantityContainerColor, // Dynamic background color
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.purple.shade700, width: 1.0), // Added purple border
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove, size: 18, color: quantityIconColor), // Dynamic icon color
                                          onPressed: () {
                                            if (product.quantity > 1) {
                                              cartProvider.updateQuantity(product.id, product.quantity - 1);
                                            } else {
                                              cartProvider.removeFromCart(product.id);
                                            }
                                          },
                                          visualDensity: VisualDensity.compact,
                                        ),
                                        Text(
                                          (product.quantity).toString(),
                                          style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold, color: quantityTextColor), // Dynamic text color
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add, size: 18, color: quantityIconColor), // Dynamic icon color
                                          onPressed: () {
                                            cartProvider.updateQuantity(product.id, product.quantity + 1);
                                          },
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Summary Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSummaryRow(
                          'Sub-total', '\$${subTotal.toStringAsFixed(2)}', theme),
                      SizedBox(height: 8),
                      _buildSummaryRow('Shipping Charge',
                          '\$${_shippingCharge.toStringAsFixed(2)}', theme),
                      Divider(height: 24, thickness: 1, color: Colors.grey[300]),
                      _buildSummaryRow(
                          'Total', '\$${totalWithShipping.toStringAsFixed(2)}', theme,
                          isTotal: true),
                      SizedBox(height: 20),
                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => cartProvider.clearCart(),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.primaryColor,
                            ),
                            child: Text(
                              'Clear',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: theme.primaryColor,
                            ),
                            child: Text(
                              'Back to Shop',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement checkout logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Proceeding to Checkout!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade700, // Purple color
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Helper widget to build summary rows
  Widget _buildSummaryRow(String label, String value, ThemeData theme,
      {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? theme.textTheme.headlineSmall?.color // Label color for total
                : theme.textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? (theme.brightness == Brightness.dark ? Colors.white : theme.primaryColor) // Total value color
                : theme.textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
