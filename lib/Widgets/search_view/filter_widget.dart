import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

class FilterWidget extends StatelessWidget {
  final String? text; // Make text nullable
  final IconData? icon;
  final bool isSelected;
  final TextStyle? textStyle;

  const FilterWidget({
    super.key,
    this.text, // Text is no longer required
    this.icon,
    this.isSelected = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6AC092) : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center( // Ensure that the content is centered
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) 
              Icon(icon, color: const Color(0xFF292726)),
            
            // Only show text if it's provided
            if (text != null && text!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 5.0), // Padding only if text exists
                child: Text(
                  text!,
                  style: textStyle ?? GoogleFonts.poppins(
                    color: const Color(0xFF292726),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
