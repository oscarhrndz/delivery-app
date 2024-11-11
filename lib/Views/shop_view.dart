import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliverit/Widgets/shop_view/animated_search_bar.dart'; // Ensure this import matches the actual path of your animated search bar file
import 'package:share_plus/share_plus.dart'; // Import the share_plus package
import 'package:deliverit/Widgets/shop_view/offers_section.dart';
import 'package:deliverit/Widgets/shop_view/products_section.dart'; // Import the ProductSection widget

class ShopDetailView extends StatefulWidget {
  final String name;
  final String imagePath;
  final double deliveryPrice;
  final int deliveryTimeMin;
  final int deliveryTimeMax;
  final int discount;
  final double rating;

  const ShopDetailView({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.deliveryPrice,
    required this.deliveryTimeMin,
    required this.deliveryTimeMax,
    required this.discount,
    required this.rating,
  }) : super(key: key);

  @override
  _ShopDetailViewState createState() => _ShopDetailViewState();
}

class _ShopDetailViewState extends State<ShopDetailView> {
  TextEditingController textController = TextEditingController();
  bool _isSearchBarOpen = false; // Track the state of the search bar
  bool _isShareButtonVisible = true; // Control the visibility of the share button

  // Method to handle the sharing action
  void _shareShop() {
    final String message =
        'Check out ${widget.name}! Delivery from ${widget.deliveryPrice} EUR, estimated time: ${widget.deliveryTimeMin}-${widget.deliveryTimeMax} min. More info: ${widget.imagePath}';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF292726), // Set the background color to black
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with back, share, and search buttons
            Stack(
              children: [
                // Background Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(screenHeight * 0.02)), // Responsive rounded corners
                  child: Image.asset(
                    widget.imagePath,
                    width: double.infinity,
                    height: screenHeight * 0.25, // 25% of the screen height
                    fit: BoxFit.cover,
                  ),
                ),
                // Top Bar with back, share, and search buttons
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      Container(
                        width: screenWidth * 0.1, // Responsive size
                        height: screenWidth * 0.1,
                        decoration: const BoxDecoration(
                          color: Color(0xFF292726),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      // Share and search buttons
                      Row(
                        children: [
                          // Share Button with fade-out animation (controlled by _isShareButtonVisible)
                          AnimatedOpacity(
                            opacity: _isShareButtonVisible ? 1.0 : 0.0, // 1.0 means fully visible, 0.0 means invisible
                            duration: const Duration(milliseconds: 300), // Control how fast the transition happens
                            child: Visibility(
                              visible: _isShareButtonVisible, // Ensures the button is hidden when not needed
                              child: Container(
                                width: screenWidth * 0.1,
                                height: screenWidth * 0.1,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF292726),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.ios_share_rounded, color: Colors.white, size: screenWidth * 0.045,),
                                  onPressed: _shareShop,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          // Search Bar should overlay the share button when open
                          AnimatedSearchBar(
                            textController: textController,
                            onSuffixTap: () {
                              Future.delayed(const Duration(milliseconds: 400), () {
                                setState(() {
                                  textController.clear();
                                  _isSearchBarOpen = false;
                                  _isShareButtonVisible = true; // Reset share button visibility when search bar closes
                                });
                              });
                            },
                            rtl: true, // Open the search bar from right to left
                            onSubmitted: (String value) {
                              debugPrint("onSubmitted value: $value");
                            },
                            textInputAction: TextInputAction.search,
                            searchBarOpen: (int toggleState) {
                              setState(() {
                                _isSearchBarOpen = toggleState == 1;
                                _isShareButtonVisible = !_isSearchBarOpen; // Hide the share button when the search bar opens
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Shop details inside the image
                Positioned(
                  bottom: 0, // Position the card at the bottom of the image
                  left: screenWidth * 0.0,
                  right: screenWidth * 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xA5292726), // Semi-transparent black
                      borderRadius: BorderRadius.circular(screenHeight * 0.02),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05,
                          top: screenWidth * 0.03,
                          right: screenWidth * 0.05,
                          bottom: screenWidth * 0.03), // Add left padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.06, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.local_shipping,
                                      size: 20, color: Color(0xCCFFFFFF)),
                                  SizedBox(width: screenWidth * 0.01),
                                  Text(
                                    'From ${widget.deliveryPrice % 1 == 0 ? widget.deliveryPrice.toInt() : widget.deliveryPrice} Eur',
                                    style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                              SizedBox(width: screenWidth * 0.05),
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      size: 20, color: Color(0xCCFFFFFF)),
                                  SizedBox(width: screenWidth * 0.01),
                                  Text(
                                    '${widget.deliveryTimeMin}-${widget.deliveryTimeMax} min',
                                    style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Offers Section under the image and card
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.0, vertical: screenHeight * 0.0),
              child: OffersSection(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),
            
            // Product Section for showing drinks or main dishes
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.0, vertical: screenHeight * 0.0),
              child: ProductSection(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                placeType: 'bar', // You can pass 'restaurant' or 'shop' based on the context
              ),
            ),

            // Add a SizedBox for bottom margin
            SizedBox(height: screenHeight * 0.03), // Adjust the value as needed
          ],
        ),
      ),
    );
  }
}
