import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  final String productName;
  final double productPrice;
  final int? productWeight;
  final String productDescription;

  const ProductDetails({
    Key? key,
    required this.productName,
    required this.productPrice,
    this.productWeight,
    required this.productDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: GoogleFonts.poppins(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10), // Margin between product name and price
          Text(
            '${productPrice.toStringAsFixed(2)} EUR',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 0), // Margin between price and weight
          if (productWeight != null)
            Text(
              'Weight: $productWeight g',
              style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8)),
            ),
          SizedBox(height: 15), // Margin between weight and description
          Text(
            productDescription,
            style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
