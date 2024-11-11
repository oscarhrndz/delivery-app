import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged; // Callback for search query
  final FocusNode focusNode; // FocusNode for managing focus state

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    required this.focusNode, // Add focusNode parameter
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 1, // Set width to 85% of the screen width
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // White with 20% opacity
        borderRadius: BorderRadius.circular(10.0), // 10px corner radius
      ),
      child: TextField(
        onChanged: onChanged, // Call onChanged with the input text
        focusNode: focusNode, // Assign focusNode to the TextField
        style: const TextStyle(color: Colors.white), // Change text color to white for visibility
        decoration: InputDecoration(
          border: InputBorder.none, // Remove the default border
          prefixIcon: const Icon(Icons.search, color: Colors.white), // Search icon on the left
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.white70), // Lighter placeholder text color for contrast
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0), // Vertical padding for the text
        ),
      ),
    );
  }
}
