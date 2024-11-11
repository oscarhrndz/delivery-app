
class Shop {
  final String name;
  final String imagePath;
  final int deliveryTimeMin;
  final int deliveryTimeMax;
  final double deliveryPrice;
  final bool hasDiscount;
  final int discount;
  final double rating;
  final String category; // New property for category

  Shop({
    required this.name,
    required this.imagePath,
    required this.deliveryTimeMin,
    required this.deliveryTimeMax,
    required this.deliveryPrice,
    required this.hasDiscount,
    this.discount = 0,
    required this.rating,
    required this.category, // Include category in constructor
  });

  // Method to determine if discount badge should be shown
  bool showDiscountBadge() {
    return hasDiscount && discount > 0;
  }

  // Method to determine if rating badge should be shown
  bool showRatingBadge() {
    return rating >= 1.0; // Adjust based on your criteria for showing the rating badge
  }
}

// Sample list of shops
final List<Shop> shops = [
  Shop(
    name: "Local Diner",
    imagePath: "assets/images/bar_image.jpg",
    deliveryTimeMin: 30,
    deliveryTimeMax: 45,
    deliveryPrice: 2,
    hasDiscount: true,
    discount: 10,
    rating: 4.5,
    category: "Eastern European", // Category for the shop
  ),
  Shop(
    name: "Pizza Place",
    imagePath: "assets/images/pizza_image.jpg",
    deliveryTimeMin: 20,
    deliveryTimeMax: 35,
    deliveryPrice: 3,
    hasDiscount: false,
    rating: 4.0,
    category: "Mediterranean", // Assign category
  ),
  Shop(
    name: "Sushi Corner",
    imagePath: "assets/images/pilmeni.jpg",
    deliveryTimeMin: 25,
    deliveryTimeMax: 40,
    deliveryPrice: 5,
    hasDiscount: true,
    discount: 15,
    rating: 4.7,
    category: "Latin American", // Assign category
  ),
  Shop(
    name: "Sushi Corner",
    imagePath: "assets/images/pilmeni.jpg",
    deliveryTimeMin: 25,
    deliveryTimeMax: 40,
    deliveryPrice: 5,
    hasDiscount: true,
    discount: 15,
    rating: 4.7,
    category: "Latin American", // Assign category
  ),
  Shop(
    name: "Sushi Corner",
    imagePath: "assets/images/pilmeni.jpg",
    deliveryTimeMin: 25,
    deliveryTimeMax: 40,
    deliveryPrice: 5,
    hasDiscount: true,
    discount: 15,
    rating: 4.7,
    category: "Latin American", // Assign category
  ),
  // Add more shops with their respective categories
];
