import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/product.dart'; // Ensure this path is correct

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  }) : super(key: key);

  void _showProductModal(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: MediaQuery.of(ctx).viewInsets,
        child: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(ctx).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag indicator
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
              SizedBox(height: 12),

              // Product Title
              Text(
                product.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 8),

              // Rating
              Row(
                children: [
                  RatingBarIndicator(
                    rating: product.rating.rate, // Corrected: Access the 'rate' property
                    itemCount: 5,
                    itemSize: 20,
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                  ),
                  SizedBox(width: 8),
                  Text(
                    product.rating.rate.toStringAsFixed(1), // Corrected: Access the 'rate' property
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 4), // Add a small space
                  Text(
                    '(${product.rating.count})', // Now you can safely display the count!
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Description
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    product.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
              ),
              SizedBox(height: 12),

              // Price + Add to Cart Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // close modal
                      onAddToCart(); // add to cart
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 100, // Adjusted width
      height: 100, // Added fixed height to make it smaller
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showProductModal(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image + rating + fav
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.0, // Keeping it square for the image itself
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    (progress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(Icons.broken_image, size: 40, color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Reduced padding
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.purple.shade700),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14), // Smaller icon
                          SizedBox(width: 3), // Reduced space
                          Text(
                            product.rating.rate.toStringAsFixed(1),
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), // Smaller font
                          ),
                          SizedBox(width: 3), // Reduced space
                          Text(
                            '(${product.rating.count})',
                            style: TextStyle(fontSize: 10, color: Colors.grey[600]), // Smaller font
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        padding: EdgeInsets.all(5), // Reduced padding
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 18, // Smaller icon
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Title, Price, Add
              Padding(
                padding: EdgeInsets.all(8), // Reduced padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13, // Further reduced font size
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6), // Reduced space
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 15, // Further reduced font size
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: onAddToCart,
                          borderRadius: BorderRadius.circular(20), // Adjusted borderRadius
                          child: Container(
                            padding: EdgeInsets.all(6), // Reduced padding
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
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
                            child: Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.white), // Smaller icon
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import '../models/product.dart'; // Ensure this path is correct

// class ProductCard extends StatelessWidget {
//   final Product product;
//   final bool isFavorite;
//   final VoidCallback onFavoriteToggle;
//   final VoidCallback onAddToCart;

//   const ProductCard({
//     Key? key,
//     required this.product,
//     required this.isFavorite,
//     required this.onFavoriteToggle,
//     required this.onAddToCart,
//   }) : super(key: key);

//   void _showProductModal(BuildContext context) {
//     final theme = Theme.of(context);

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       // Use theme's cardColor for modal background
//       backgroundColor: theme.cardColor,
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
//               // Drag indicator
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

//               // Product Image
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

//               // Product Title
//               Text(
//                 product.title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: theme.textTheme.bodyLarge?.color, // Use theme text color
//                 ),
//               ),
//               SizedBox(height: 8),

//               // Rating
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

//               // Description
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Text(
//                     product.description,
//                     style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color), // Use theme text color
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12),

//               // Price + Add to Cart Button
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
//                       Navigator.pop(context); // close modal
//                       onAddToCart(); // add to cart
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
//       width: 150,
//       height: 250,
//       child: Card(
//         // Use theme.cardColor for the card background
//         color: theme.cardColor,
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         clipBehavior: Clip.antiAlias,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () => _showProductModal(context),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image + rating + fav
//               Stack(
//                 children: [
//                   AspectRatio(
//                     aspectRatio: 1.0,
//                     child: Image.network(
//                       product.image,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, progress) {
//                         if (progress == null) return child;
//                         return Center(
//                           child: CircularProgressIndicator(
//                             value: progress.expectedTotalBytes != null
//                                 ? progress.cumulativeBytesLoaded /
//                                     (progress.expectedTotalBytes ?? 1)
//                                 : null,
//                             color: theme.primaryColor, // Use theme color for loading indicator
//                           ),
//                         );
//                       },
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         color: theme.splashColor, // Use a theme-aware color for error background
//                         child: Center(
//                           child: Icon(Icons.broken_image, size: 40, color: theme.colorScheme.onSurface.withOpacity(0.5)), // Theme-aware icon color
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: theme.cardColor, // Use theme's cardColor for the background
//                         border: Border.all(color: theme.primaryColor), // Use theme's primary color for border
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.star, color: Colors.amber, size: 14),
//                           SizedBox(width: 3),
//                           Text(
//                             product.rating.rate.toStringAsFixed(1),
//                             style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color), // Use theme text color
//                           ),
//                           SizedBox(width: 3),
//                           Text(
//                             '(${product.rating.count})',
//                             style: TextStyle(fontSize: 10, color: theme.textTheme.bodySmall?.color), // Use theme text color
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: GestureDetector(
//                       onTap: onFavoriteToggle,
//                       child: Container(
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           color: theme.cardColor, // Use theme's cardColor for the background
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: theme.shadowColor.withOpacity(0.2), // Use theme's shadowColor
//                               blurRadius: 4,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           isFavorite ? Icons.favorite : Icons.favorite_border,
//                           color: isFavorite ? Colors.red : theme.iconTheme.color, // Use theme's icon color
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // Title, Price, Add
//               Padding(
//                 padding: EdgeInsets.all(8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       product.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         height: 1.3,
//                         color: theme.textTheme.titleMedium?.color, // Use theme text color for titles
//                       ),
//                     ),
//                     SizedBox(height: 6),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '\$${product.price.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: theme.primaryColor,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: onAddToCart,
//                           borderRadius: BorderRadius.circular(20),
//                           child: Container(
//                             padding: EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: theme.primaryColor,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: theme.primaryColor.withOpacity(0.3),
//                                   spreadRadius: 1,
//                                   blurRadius: 4,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Icon(Icons.shopping_bag_outlined, size: 20, color: theme.colorScheme.onPrimary), // Use theme's onPrimary color for icon
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }