import 'package:flutter/material.dart';
import '../models/product.dart'; // Assuming your Product model is here

class TrendingCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final String? statusLabel; // Added for "New", "Sale", "Hot"

  const TrendingCard({
    Key? key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    this.statusLabel, // Optional status label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We will explicitly set the card color to white as requested,
    // so theme.cardColor is not strictly needed for the card's background.
    // final theme = Theme.of(context);

    return Container(
      width: 160, // Fixed width for each trending card
      margin: const EdgeInsets.only(right: 12.0), // Space between cards
      decoration: BoxDecoration(
        color: Colors.white70, // Explicitly set card background to white
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding( // Add padding around the image
            padding: const EdgeInsets.all(8.0), // White space around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Slightly rounded corners for the image
              child: AspectRatio( // Use AspectRatio for consistent image sizing
                aspectRatio: 1, // Make image square (e.g., 140x140)
                child: Image.network(
                  product.image,
                  // The height will be determined by the AspectRatio and the parent's width
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Icon(Icons.broken_image, size: 40, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Padding for text content
            child: Row( // Use a Row directly here to manage the bottom content
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Count with Purple Heart (Bottom Left)
                Row(
                  children: [
                    Text(
                      '${product.rating.count}', // Use product.rating.count
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.favorite, color: Colors.purple, size: 16), // Purple heart icon
                  ],
                ),
                // Status Label ("New", "Sale", "Hot") with Fire Icon (Bottom Right)
                if (statusLabel != null && statusLabel!.isNotEmpty)
                  Row( // Use a Row to place text and icon together
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 16), // Fire icon
                      SizedBox(width: 4),
                      Text(
                        statusLabel!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // SizedBox(height: 8), // Add a small space at the very bottom of the card if needed for overall height
        ],
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import '../models/product.dart'; // Ensure this path is correct

// class TrendingCard extends StatelessWidget {
//   final Product product;
//   final bool isFavorite;
//   final VoidCallback onFavoriteToggle;
//   final VoidCallback onAddToCart; // This is still required by the constructor
//   final String? statusLabel; // Optional label for "Hot," "New," "Sale"

//   const TrendingCard({
//     Key? key,
//     required this.product,
//     required this.isFavorite,
//     required this.onFavoriteToggle,
//     required this.onAddToCart, // Keep this as required
//     this.statusLabel,
//   }) : super(key: key);

//   void _showProductModal(BuildContext context) {
//     final theme = Theme.of(context);
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: theme.cardColor, // Use theme's cardColor
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (ctx) => Padding(
//         padding: MediaQuery.of(ctx).viewInsets,
//         child: Container(
//           padding: EdgeInsets.all(16),
//           height: MediaQuery.of(ctx).size.height * 0.6,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 5,
//                   margin: EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: theme.brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[400], // Dark mode adjust
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     product.image,
//                     height: 180,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (ctx, err, st) => Icon(Icons.broken_image, size: 60, color: theme.colorScheme.onSurface.withOpacity(0.5)), // Dark mode adjust
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12),
//               Text(
//                 product.title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: theme.textTheme.bodyLarge?.color, // Use theme text color
//                 ),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   RatingBarIndicator(
//                     rating: product.rating.rate,
//                     itemCount: 5,
//                     itemSize: 20,
//                     direction: Axis.horizontal,
//                     itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     product.rating.rate.toStringAsFixed(1),
//                     style: TextStyle(fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color), // Use theme text color
//                   ),
//                   SizedBox(width: 4),
//                   Text(
//                     '(${product.rating.count})',
//                     style: TextStyle(fontSize: 14, color: theme.textTheme.bodySmall?.color), // Use theme text color
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Text(
//                     product.description,
//                     style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color), // Use theme text color
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '\$${product.price.toStringAsFixed(2)}',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: theme.primaryColor,
//                     ),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       onAddToCart();
//                     },
//                     icon: Icon(Icons.shopping_cart),
//                     label: Text("Add to Cart"),
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                       backgroundColor: theme.primaryColor,
//                       foregroundColor: theme.colorScheme.onPrimary, // Ensures button text is readable
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       width: 140, // Slightly smaller width for trending cards
//       margin: EdgeInsets.only(right: 16, bottom: 8), // Adjusted margin
//       decoration: BoxDecoration(
//         color: theme.cardColor, // Use theme's card color
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: theme.shadowColor.withOpacity(0.1), // Use theme's shadowColor
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () => _showProductModal(context),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                   child: Image.network(
//                     product.image,
//                     height: 100, // Adjusted height for image
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       height: 100,
//                       color: theme.splashColor, // Theme-aware error background
//                       child: Center(
//                         child: Icon(Icons.broken_image, size: 40, color: theme.colorScheme.onSurface.withOpacity(0.5)), // Theme-aware icon color
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (statusLabel != null)
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: theme.primaryColor, // Use theme primary color
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         statusLabel!,
//                         style: TextStyle(
//                           color: theme.colorScheme.onPrimary, // Text color based on primary color
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: onFavoriteToggle,
//                     child: Container(
//                       padding: EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: theme.cardColor, // Use theme's cardColor for the background
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: theme.shadowColor.withOpacity(0.1), // Theme-aware shadow
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : theme.iconTheme.color, // Theme-aware icon color
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.title,
//                     maxLines: 1, // Limit to one line
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12, // Smaller font size
//                       color: theme.textTheme.titleMedium?.color, // Theme-aware text color
//                     ),
//                   ),
//                   SizedBox(height: 4), // Smaller spacing
//                   Row(
//                     children: [
//                       RatingBarIndicator(
//                         rating: product.rating.rate,
//                         itemCount: 5,
//                         itemSize: 12, // Smaller stars
//                         direction: Axis.horizontal,
//                         itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
//                       ),
//                       SizedBox(width: 4),
//                       Text(
//                         product.rating.rate.toStringAsFixed(1),
//                         style: TextStyle(fontSize: 10, color: theme.textTheme.bodySmall?.color), // Smaller font, theme-aware
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '\$${product.price.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 14, // Smaller font size
//                           fontWeight: FontWeight.bold,
//                           color: theme.primaryColor,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: onAddToCart,
//                         borderRadius: BorderRadius.circular(20),
//                         child: Container(
//                           padding: EdgeInsets.all(6),
//                           decoration: BoxDecoration(
//                             color: theme.primaryColor,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: theme.primaryColor.withOpacity(0.3),
//                                 spreadRadius: 1,
//                                 blurRadius: 4,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Icon(Icons.add_shopping_cart, size: 18, color: theme.colorScheme.onPrimary), // Smaller icon, theme-aware
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

