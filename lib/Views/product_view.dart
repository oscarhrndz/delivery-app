import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus
import 'package:deliverit/Widgets/product_view/notes_actions.dart';
import 'package:deliverit/Widgets/product_view/product_image.dart';
import 'package:deliverit/Widgets/product_view/product_details.dart';
import 'package:deliverit/Widgets/product_view/product_tags.dart';

class ProductView extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productDescription;
  final double productPrice;
  final int? productSales;
  final int? productDiscount;
  final int? productWeight;

  const ProductView({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productPrice,
    this.productSales,
    this.productDiscount,
    this.productWeight,
  }) : super(key: key);

  void _shareProduct() {
    // Share the product details
    Share.share(
      'Check out this product: $productName\nPrice: \$${productPrice.toStringAsFixed(2)}\n$productDescription',
      subject: 'Amazing Product: $productName',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF414141),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Padding for keyboard
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(
              productImage: productImage,
              onShare: _shareProduct, // Use the share functionality here
              onClose: () {
                Navigator.of(context).pop(); // Close the product view
              },
            ),
            ProductDetails(
              productName: productName,
              productPrice: productPrice,
              productWeight: productWeight,
              productDescription: productDescription,
            ),
            Tags(productSales: productSales, productDiscount: productDiscount),
            NotesAndActions(
              onAddToCart: (quantity) {
                // Add functionality to add the product to the cart
              },
              productPrice: productPrice, // Pass productPrice here
            ),
          ],
        ),
      ),
    );
  }
}
