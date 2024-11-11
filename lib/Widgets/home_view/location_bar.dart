import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliverit/Views/location_view.dart'; // Import LocationView

class LocationBar extends StatelessWidget {
  final String locationText;

  const LocationBar({super.key, required this.locationText});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Navigate to LocationView when the bar is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationView()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.03), // Responsive padding
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.white),
            const SizedBox(width: 10), // Add margin here
            Text(
              locationText,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: screenWidth * 0.04, // Responsive font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
