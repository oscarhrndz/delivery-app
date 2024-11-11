import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Define screenWidth here

    return Container(
      height: screenWidth * 0.13, // Responsive height based on screen width
      color: Colors.black.withOpacity(0.7), // Background color with 30% opacity
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavButton(0, Icons.home, context),       // Home Icon
          _buildBottomNavButton(1, Icons.search, context),     // Search Icon
          _buildBottomNavButton(2, Icons.favorite, context),   // Like Icon
          _buildBottomNavButton(3, Icons.person, context),     // Profile Icon
        ],
      ),
    );
  }

  Widget _buildBottomNavButton(int index, IconData icon, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width; // Define screenWidth here
  double iconSize = 24; // Set a standard icon size

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02), // Responsive padding
    child: Column(
      mainAxisSize: MainAxisSize.min, // Keep the size of the column minimal
      children: [
        Container(
          width: screenWidth * 0.15, // Responsive width for the button background
          height: screenWidth * 0.09, // Responsive height for the button background
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? const Color(0xFF6AC092) // Highlight color for selected tab
                : Colors.transparent, // Otherwise transparent
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center, // Center the icon within the container
          child: IconButton(
            onPressed: () {
              if (selectedIndex != index) {
                onItemSelected(index); // Notify parent to change index
              } else {
                Navigator.of(context).popUntil((route) => route.isFirst); // Go to the main page
              }
            },
            icon: Icon(
              icon,
              color: Colors.white, // Icon color based on selection
              size: iconSize, // Set icon size
            ),
            padding: EdgeInsets.zero, // Remove padding to ensure centering
          ),
        ),
      ],
    ),
  );
}
}