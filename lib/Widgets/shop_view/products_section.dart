import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliverit/database/product.dart'; // Import the Product class
import 'package:deliverit/Views/product_view.dart'; // Import the ProductView page

class ProductSection extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String placeType; // The type of place (e.g., 'bar', 'restaurant', 'shop')

  const ProductSection({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.placeType, // Keeping placeType for category title
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.0,
        horizontal: screenWidth * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for Main Category (e.g., "Drinks" for a bar)
          Text(
            placeType == 'bar'
                ? 'Drinks'
                : placeType == 'restaurant'
                    ? 'Main Dishes'
                    : 'Popular Products',
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),

          // List of products
          Column(
            children: List.generate(products.length, (index) {
              final product = products[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows the bottom sheet to be full height if needed
    builder: (context) {
      return ProductView(
        productName: product.name,
        productImage: product.photo,
        productDescription: product.description,
        productPrice: product.price,
        productSales: product.sales,
        productDiscount: product.discount,
        productWeight: product.weight,
      );
    },
  );
},
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.13, // Increase height to make it larger
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0, vertical: screenHeight * 0.005),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left part for product name, ingredients, and price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Labels for "Popular" and "Offer"
                                  Row(
                                    children: [
                                      if (product.sales != null && product.sales! > 20)
                                        Container(
                                          width: 80,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFDB67),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Popular',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Color(0xFF292726),
                                            ),
                                          ),
                                        ),
                                      // Add spacing between "Popular" and "Offer" labels
                                      if (product.sales != null && product.sales! > 20 && product.priceOffer != null)
                                        SizedBox(width: 8),
                                      if (product.priceOffer != null)
                                        Container(
                                          width: 80,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xCC6AC092),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Offer',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 6),

                                  // Product name with a max of 2 lines
                                  Text(
                                    product.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.04,
                                      color: Color(0xCCFFFFFF),
                                    ),
                                    maxLines: 2, // Limit to 2 lines
                                    overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                  ),
                                  SizedBox(height: 4),

                                  // Display ingredients
                                  Text(
                                    product.ingredients,
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.03,
                                      color: Color(0xCCFFFFFF),
                                    ),
                                  ),
                                  SizedBox(height: 4),

                                  // Display pricing
                                  product.priceOffer != null
                                      ? Row(
                                          children: [
                                            Text(
                                              '${product.price.toStringAsFixed(2)} EUR',
                                              style: GoogleFonts.poppins(
                                                fontSize: screenWidth * 0.04,
                                                color: Color(0xCCFFFFFF),
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              '${product.priceOffer!.toStringAsFixed(2)} EUR',
                                              style: GoogleFonts.poppins(
                                                fontSize: screenWidth * 0.04,
                                                color: Color(0xFFF56969),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          '${product.price.toStringAsFixed(2)} EUR',
                                          style: GoogleFonts.poppins(
                                            fontSize: screenWidth * 0.045,
                                            color: Color(0xCCFFFFFF),
                                          ),
                                        ),
                                ],
                              ),
                            ),

                            // Right part for product image
                            Container(
                              height: screenHeight * 0.18,
                              width: screenHeight * 0.11,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(product.photo),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (index < products.length - 1)
                    Divider(
                      color: Color(0x1AFFFFFF),
                      thickness: 1,
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
