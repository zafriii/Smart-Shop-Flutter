import 'package:flutter/material.dart';
import '../models/product.dart'; // Assuming your Product model is here

class DiscountCard extends StatelessWidget {
  final Product product;
  final double discountPercentage; // e.g., 0.20 for 20%

  const DiscountCard({
    Key? key,
    required this.product,
    this.discountPercentage = 0.20, // Default to 20% if not specified
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate discounted price (though not displayed on the card itself, useful for logic)
    // final double discountedPrice = product.price * (1 - discountPercentage);

    return Container(
      width: 160, // Fixed width for each discount card
      margin: const EdgeInsets.only(right: 12.0), // Space between cards
      decoration: BoxDecoration(
        color: Colors.white, // White background for the card
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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12), // Rounded corners for the entire card
            child: Image.network(
              product.image,
              height: 200, // Fixed height for the image to fill the card
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[200],
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey[600]),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.purple, // Pink background for the discount badge
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                '-${(discountPercentage * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import '../models/product.dart'; // Ensure this path is correct

// class DiscountCard extends StatelessWidget {
//   final Product product;
//   final double discountPercentage; // e.g., 0.20 for 20%

//   const DiscountCard({
//     Key? key,
//     required this.product,
//     this.discountPercentage = 0.20, // Default to 20%
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final discountedPrice = product.price * (1 - discountPercentage);

//     return Card(
//       color: theme.cardColor, // Use theme's card color
//       elevation: 0, // No elevation as per image
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: theme.dividerColor.withOpacity(0.5)), // Subtle border
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Container(
//         height: 180, // Fixed height for consistent look
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Product Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 product.image,
//                 width: 90, // Fixed width for image
//                 height: 90, // Fixed height for image
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   width: 90,
//                   height: 90,
//                   color: theme.splashColor, // Theme-aware error background
//                   child: Center(
//                     child: Icon(Icons.broken_image, size: 40, color: theme.colorScheme.onSurface.withOpacity(0.5)), // Theme-aware icon color
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 12),
//             // Product Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     product.title,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                       color: theme.textTheme.titleMedium?.color, // Theme-aware text color
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     '${(discountPercentage * 100).toStringAsFixed(0)}% OFF',
//                     style: TextStyle(
//                       color: Colors.red, // Discount percentage always red
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(
//                         '\$${discountedPrice.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: theme.primaryColor,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         '\$${product.price.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           decoration: TextDecoration.lineThrough,
//                           color: theme.textTheme.bodySmall?.color, // Theme-aware text color
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle adding to cart or viewing product
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: theme.primaryColor,
//                       foregroundColor: theme.colorScheme.onPrimary, // Ensures button text is readable
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       minimumSize: Size(double.infinity, 30), // Make button take full width
//                     ),
//                     child: Text('Add to Cart', style: TextStyle(fontSize: 12)),
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