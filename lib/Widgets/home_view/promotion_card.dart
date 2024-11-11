import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantCard extends StatelessWidget {
  final String imagePath;

  const RestaurantCard({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
        top: screenHeight * 0.02, // 2% of screen height for top margin
        bottom: screenHeight * 0.02, // 2% of screen height for bottom margin
        right: screenWidth * 0.05,  // 5% of screen width for right margin
        left: screenWidth * 0.05,  // 5% of screen width for right margin
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDB67),
        borderRadius: BorderRadius.circular(screenWidth * 0.05), // Dynamic corner radius
      ),
      height: screenHeight * 0.2, // Dynamic height (20% of screen height)
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.1, // 10% of screen width for left padding
              top: screenHeight * 0.02, // 2% of screen height for top padding
              right: screenWidth * 0.02, // 2% of screen width for right padding
            ),
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.35, // 35% of screen width for the image
              height: screenHeight * 0.15, // 15% of screen height for the image
            ),
          ),
          // Use Flexible for dynamic text layout
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.03), // Dynamic left padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order from Local",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035, // Dynamic font size
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF292726),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    "Restaurants",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF292726),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: screenHeight * 0.01), // Dynamic space between texts
                  Text(
                    "The best orders",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.03,
                      color: const Color(0xFF292726).withOpacity(0.8),
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: screenHeight * 0.02), // Dynamic space between text and button
                  TextButton(
                    onPressed: () {
                      // Add your action here
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04, // Dynamic horizontal padding
                        vertical: screenHeight * 0.01,  // Dynamic vertical padding
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                    ),
                    child: Text(
                      "View All",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.028,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
