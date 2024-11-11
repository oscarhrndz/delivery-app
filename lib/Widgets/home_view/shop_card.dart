import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliverit/Widgets/search_view/shop_list.dart'; // Import Shop class

class PromotionalCard extends StatelessWidget {
  final Shop shop; // Change to accept a Shop object

  const PromotionalCard({
    super.key,
    required this.shop, // Accept a Shop object
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.05), // 5% of screen width for margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(shop.imagePath), // Access imagePath from Shop
                    fit: BoxFit.cover,
                  ),
                ),
                width: screenWidth * 0.5,  // 50% of screen width
                height: screenHeight * 0.15, // 15% of screen height
                padding: const EdgeInsets.all(16.0),
                child: Container(),
              ),
              if (shop.showDiscountBadge()) // Check if discount should be shown
                Positioned(
                  top: 5.0,
                  left: 5.0,
                  child: _buildRoundedSquare('-${shop.discount}%', const Color(0xCC6AC092)),
                ),
              Positioned(
                bottom: 5.0,
                right: 5.0,
                child: _buildRatingSquare(shop.rating), // Pass rating from Shop
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01), // Dynamic space
          SizedBox(
            width: screenWidth * 0.5, // Match card width
            child: Text(
              shop.name, // Display shop name
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.04, // Dynamic font size
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.005), // Dynamic space
          SizedBox(
            width: screenWidth * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_shipping, size: 16.0, color: Colors.white),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      "From ${shop.deliveryPrice} Eur", // Display delivery price from Shop
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.03, // Dynamic font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16.0, color: Colors.white),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      "${shop.deliveryTimeMin}-${shop.deliveryTimeMax} min", // Display delivery time from Shop
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.03, // Dynamic font size
                        color: Colors.white.withOpacity(0.8),
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

  Widget _buildRoundedSquare(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      width: 40.0,
      height: 24.0,
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 10.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRatingSquare(double rating) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: rating >= 4.5 ? const Color(0xCCFFDB67) : Colors.white.withOpacity(0.8),
      ),
      width: 40.0,
      height: 24.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            rating >= 4.5 ? Icons.star_border : Icons.star,
            color: const Color(0xFF292726),
            size: 11.0,
          ),
          const SizedBox(width: 2.0),
          Text(
            rating.toString(),
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
