import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliverit/Widgets/home_view/promotion_card.dart'; // Import RestaurantCard
import 'package:deliverit/Widgets/home_view/shop_card.dart';
import 'package:deliverit/Views/view_all.dart'; // Import View All screen
import 'package:deliverit/Widgets/home_view/location_bar.dart'; // Import LocationBar
import 'package:card_swiper/card_swiper.dart';
import 'package:deliverit/Widgets/search_view/shop_list.dart'; // Import the shop data

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  
  @override
  _HomeViewState createState() => _HomeViewState();
}

  final List<Map<String, dynamic>> promotions = [
    {
      'image': 'assets/images/image.png',
    },
    {
      'image': 'assets/images/image.png',
    },
    {
      'image': 'assets/images/image.png',
    },
  ];

class _HomeViewState extends State<HomeView> {
  final String locationText = 'Your Location';

  final SwiperController _swiperController = SwiperController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Shop> bestSellers = shops.where((shop) => shop.rating >= 4.5).toList();
    List<Shop> promotionalOffers = shops.where((shop) => shop.hasDiscount).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF292726), // Keep the AppBar color constant 
        scrolledUnderElevation: 0.0,
        title: const SizedBox.shrink(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01), // 5% horizontal padding
            child: LocationBar(locationText: locationText),
          ),
        ),
      ),
    
    body: Container(
      color: const Color(0xFF292726), // Set the desired color here
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.02), // Responsive padding
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.0), // Responsive space at the top

              Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.25, // Responsive height for swiper
                    child: Swiper(
                      controller: _swiperController,
                      itemCount: promotions.length,
                      autoplay: true,
                      duration: 500,
                      onIndexChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return RestaurantCard(
                          imagePath: promotions[index]['image'],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01), // Responsive space

                  // Custom pagination dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(promotions.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: _currentIndex == index ? 8.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.white.withOpacity(0.2)
                              : Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      );
                    }),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03), // Space between swiper and promotional offers

              // Section "Promotional Offers" and "View All"
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05), // Responsive padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Promotional Offers",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045, // Responsive font size
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ViewAllScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04, // Responsive font size
                              color: Colors.white,
                            ),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.01), // Responsive space

              // Promotional Cards
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...promotionalOffers.map((shop) {
                        return Padding(
                          padding: EdgeInsets.only(right: 0, left: screenWidth * 0.05),
                          child: PromotionalCard(shop: shop), // Pass the shop object
                        );
                      }).toList(),
                    ],
                  ),
                ),

              SizedBox(height: screenHeight * 0.04), // Responsive space

              // Section "Best Sellers" and "View All"
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05), // Responsive padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Sellers",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045, // Responsive font size
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ViewAllScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04, // Responsive font size
                              color: Colors.white,
                            ),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.01), // Responsive space

              // Best Seller Cards
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...bestSellers.map((shop) {
                        return Padding(
                          padding: EdgeInsets.only(right: 0, left: screenWidth * 0.05),
                          child: PromotionalCard(shop: shop), // Pass the shop object
                        );
                      }).toList(),
                    ],
                  ),
                ),

              SizedBox(height: screenHeight * 0.04), // Responsive space

              // Section "Best Sellers" and "View All"
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05), // Responsive padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Sellers",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045, // Responsive font size
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ViewAllScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04, // Responsive font size
                              color: Colors.white,
                            ),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.01), // Responsive space

              // Best Seller Cards
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...bestSellers.map((shop) {
                        return Padding(
                          padding: EdgeInsets.only(right: 0, left: screenWidth * 0.05),
                          child: PromotionalCard(shop: shop), // Pass the shop object
                        );
                      }).toList(),
                    ],
                  ),
                ),

              SizedBox(height: screenHeight * 0.04), // Responsive space

              // Section "Best Sellers" and "View All"
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05), // Responsive padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Sellers",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045, // Responsive font size
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ViewAllScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.04, // Responsive font size
                              color: Colors.white,
                            ),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.01), // Responsive space

              // Best Seller Cards
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...bestSellers.map((shop) {
                        return Padding(
                          padding: EdgeInsets.only(right: 0, left: screenWidth * 0.05),
                          child: PromotionalCard(shop: shop), // Pass the shop object
                        );
                      }).toList(),
                    ],
                  ),
                ),

              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    ),
    );
  }
}






















