import 'package:flutter/material.dart';
import '../models/product.dart'; 

class DiscountCard extends StatelessWidget {
  final Product product;
  final double discountPercentage; 

  const DiscountCard({
    Key? key,
    required this.product,
    this.discountPercentage = 0.20, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, 
      margin: const EdgeInsets.only(right: 12.0), 
      decoration: BoxDecoration(
        color: Colors.white, 
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
            borderRadius: BorderRadius.circular(12), 
            child: Image.network(
              product.image,
              height: 200, 
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
                color: Colors.purple, 
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
