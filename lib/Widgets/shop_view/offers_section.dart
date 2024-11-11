import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliverit/database/product.dart'; // Import the products file
import 'package:deliverit/Views/product_view.dart'; // Import the product_view.dart file

class OffersSection extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const OffersSection({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter products to include only those with a discount (priceOffer is not null)
    final discountedProducts = products.where((product) => product.priceOffer != null).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Reduced vertical padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Offers" text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Offers",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // "View All" with Arrow
                Row(
                  children: [
                    Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: screenWidth * 0.04,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02), // Space between title and list

            // Horizontal scrollable list of product cards with names and prices
            SizedBox(
              height: screenHeight * 0.25, // Adjust height for the Offers Section
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: discountedProducts.length, // Use the filtered list for count
                itemBuilder: (context, index) {
                  final product = discountedProducts[index]; // Use the filtered product list
                  return GestureDetector(
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index == discountedProducts.length - 1 ? 0 : screenWidth * 0.05, // Space between items except the last one
                      ),
                      child: Container(
                        width: screenWidth * 0.3, // Width of each product card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
                          children: [
                            // Product Card with Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15), // Rounded corners
                              child: Container(
                                height: screenHeight * 0.13, // Height for the card
                                decoration: BoxDecoration(
                                  // Background color for the card
                                  image: DecorationImage(
                                    image: AssetImage(product.photo), // Product image
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    // Discount Square with Rounded Corners
                                    Positioned(
                                      top: 8, // Adjust the position from the top
                                      left: 8, // Adjust the position from the left
                                      child: Container(
                                        width: screenWidth * 0.1, // Set the width for the square
                                        height: screenWidth * 0.06, // Set the height for the square (equal to width)
                                        decoration: BoxDecoration(
                                          color: Color(0xCC6AC092), // Background color with 80% opacity
                                          borderRadius: BorderRadius.circular(10), // Rounded corners
                                        ),
                                        alignment: Alignment.center, // Center the text inside the square
                                        child: Text(
                                          '-${product.discount}%', // Display discount percentage
                                          style: GoogleFonts.poppins(
                                            fontSize: screenWidth * 0.025, // Adjust font size
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Offer Price in Red
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 10), // Space between image and offer price
                              child: Text(
                                "${product.priceOffer?.toStringAsFixed(2)} EUR", // Offer price
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  color: Color(0xFFF56969),
                                ),
                              ),
                            ),
                            // Product Prices
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 10), // Align to the start
                              child: Text(
                                "${product.price.toStringAsFixed(2)} EUR", // Original price
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  color: Color(0xCCFFFFFF),
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color(0x99FFFFFF), // Strike-through for original price
                                ),
                              ),
                            ),
                            // Product Name aligned to the left
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 10), // Space between offer price and name
                              child: Text(
                                product.name,
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  color: Color(0xCCFFFFFF),
                                ),
                                maxLines: 2, // Limit to 2 lines
                                overflow: TextOverflow.ellipsis, // Show ellipsis if the text overflows
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
