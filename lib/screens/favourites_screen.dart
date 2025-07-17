// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // For dynamic star rating

// import '../providers/product_provider.dart';
// import '../providers/cart_provider.dart';

// class FavouritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final cartProvider = Provider.of<CartProvider>(context);
//     final favorites = productProvider.favorites;
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Favourites', style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: theme.textTheme.headlineSmall?.color,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Dynamic Favourite Count
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Text(
//               favorites.isEmpty
//                   ? 'No favourite products yet.'
//                   : 'You have ${favorites.length} item${favorites.length > 1 ? 's' : ''} in your favourites.',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: theme.textTheme.bodyMedium?.color,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           SizedBox(height: 10), // Spacing below the count

//           Expanded(
//             child: favorites.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.favorite_border, size: 80, color: Colors.grey),
//                         SizedBox(height: 16),
//                         Text(
//                           'Add items to your favourites!',
//                           style: TextStyle(fontSize: 18, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: EdgeInsets.all(16),
//                     itemCount: favorites.length,
//                     itemBuilder: (ctx, i) {
//                       final product = favorites[i];
//                       return Card(
//                         margin: EdgeInsets.only(bottom: 12),
//                         elevation: 0, // Flat card design
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically in center
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
//                               // Product Details (Name, Price, Rating)
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
//                                     SizedBox(height: 8),
//                                     // Dynamic Rating Display
//                                     Row(
//                                       children: [
//                                         RatingBarIndicator(
//                                           rating: product.rating,
//                                           itemBuilder: (context, _) =>
//                                               Icon(Icons.star, color: Colors.amber),
//                                           itemSize: 18.0, // Match home screen size
//                                           unratedColor: Colors.amber.withAlpha(80),
//                                         ),
//                                         SizedBox(width: 6),
//                                         Text(
//                                           product.rating.toStringAsFixed(1),
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: theme.textTheme.bodyMedium?.color,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               // Cart Icon (replaces add to cart button)
//                               GestureDetector(
//                                 onTap: () {
//                                   cartProvider.addToCart(product);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text('Added to cart')),
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: theme.primaryColor, // Use primary color for cart icon background
//                                     shape: BoxShape.circle,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: theme.primaryColor.withOpacity(0.3),
//                                         spreadRadius: 1,
//                                         blurRadius: 4,
//                                         offset: Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Icon(Icons.shopping_bag_outlined, size: 22, color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }




















import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // For dynamic star rating

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart'; // Ensure you import your Product model here!

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favorites = productProvider.favorites;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourites', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.textTheme.headlineSmall?.color,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dynamic Favourite Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              favorites.isEmpty
                  ? 'No favourite products yet.'
                  : 'You have ${favorites.length} item${favorites.length > 1 ? 's' : ''} in your favourites.',
              style: TextStyle(
                fontSize: 16,
                color: theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10), // Spacing below the count

          Expanded(
            child: favorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Add items to your favourites!',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: favorites.length,
                    itemBuilder: (ctx, i) {
                      final product = favorites[i];
                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        elevation: 0, // Flat card design
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically in center
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
                              // Product Details (Name, Price, Rating)
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
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: theme.brightness == Brightness.dark
                                            ? Colors.white
                                            : theme.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    // Dynamic Rating Display
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: product.rating.rate, // Corrected: Access the 'rate' property
                                          itemBuilder: (context, _) =>
                                              Icon(Icons.star, color: Colors.amber),
                                          itemSize: 18.0, // Match home screen size
                                          unratedColor: Colors.amber.withAlpha(80),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          product.rating.rate.toStringAsFixed(1), // Corrected: Access the 'rate' property
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: theme.textTheme.bodyMedium?.color,
                                          ),
                                        ),
                                        SizedBox(width: 4), // Add space for count
                                        Text(
                                          '(${product.rating.count})', // Display the count here
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: theme.textTheme.bodyMedium?.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              // Cart Icon (replaces add to cart button)
                              GestureDetector(
                                onTap: () {
                                  cartProvider.addToCart(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Added to cart')),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor, // Use primary color for cart icon background
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.primaryColor.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(Icons.shopping_bag_outlined, size: 22, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
