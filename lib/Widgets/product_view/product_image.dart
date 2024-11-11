import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String productImage;
  final Function() onShare;
  final Function() onClose;

  const ProductImage({
    Key? key,
    required this.productImage,
    required this.onShare,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(productImage),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 16,
          child: Row(
            children: [
              GestureDetector(
                onTap: onShare,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF292726),
                  child: Icon(Icons.ios_share_outlined, color: Colors.white),
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: onClose,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF292726),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
