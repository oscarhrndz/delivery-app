import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tags extends StatelessWidget {
  final int? productSales;
  final int? productDiscount;

  const Tags({
    Key? key,
    this.productSales,
    this.productDiscount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 25, bottom: 30), // Set only left margin to 50
      child: Row(
        children: [
          if (productSales != null && productSales! > 20) ...[
            // Popular tag
            Container(
              width: 80,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                'Popular',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
              ),
            ),
            SizedBox(width: 15), // Space between Popular and Offer tags
          ],
          if (productDiscount != null && productDiscount! > 0) ...[
            // Offer tag
            Container(
              width: 60,
              height: 25,
              decoration: BoxDecoration(
                color: Color(0xFF6AC092),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                'Offer',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
