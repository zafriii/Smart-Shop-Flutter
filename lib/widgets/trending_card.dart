import 'package:flutter/material.dart';
import '../models/product.dart'; 

class TrendingCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final String? statusLabel;

  const TrendingCard({
    Key? key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    this.statusLabel, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 160, 
      margin: const EdgeInsets.only(right: 12.0), 
      decoration: BoxDecoration(
        color: Colors.white70, 
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
          Padding( 
            padding: const EdgeInsets.all(8.0), 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), 
              child: AspectRatio( 
                aspectRatio: 1, 
                child: Image.network(
                  product.image,
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), 
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${product.rating.count}',
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.favorite, color: Colors.purple, size: 16), 
                  ],
                ),

                if (statusLabel != null && statusLabel!.isNotEmpty)
                  Row( 
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 16), 
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
        
        ],
      ),
    );
  }
}

