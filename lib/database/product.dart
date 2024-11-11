class Product {
  final String name;
  final String description;
  final double price;
  final double ?priceOffer; // New field for the offer price
  final String photo;
  final int ?discount;
  final String ingredients;
  final int ?sales;
  final int ?weight;

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.priceOffer, // Include the new field in the constructor
    required this.photo,
    this.discount,
    required this.ingredients,
    this.sales,
    this.weight
  });
}

// Sample list of products
final List<Product> products = [
  Product(
    name: "Straciatella Gelato",
    description: "Description for Product 1",
    price: 9.99,
    priceOffer: 7.99, // Offer price
    photo: "assets/images/gelato_image.jpg", // Update with actual asset path
    discount: 10,
    ingredients: "Gatuli"
  ),
  Product(
    name: "Pizza Napolitano Style",
    description: "Description for Product 2, description, description, description, description, description, description, description, description, description, description, description",
    price: 19.99,
    priceOffer: 15.99, // Offer price
    photo: "assets/images/pizza_image.jpg", // Update with actual asset path
    discount: 20,
    ingredients: "Gatuli",
    sales: 40,
    weight: 350,
  ),
  Product(
    name: "Un cafe",
    description: "Description for Product 3",
    price: 29.99,
    priceOffer: 24.99, // Offer price
    photo: "assets/images/cafe.jpg", // Update with actual asset path
    discount: 15,
    ingredients: "Gatuli"
  ),
  // Add more products as needed

  Product(
    name: "Gatuli roasted with pilmeni",
    description: "Description for Product 1",
    price: 100.99,
    photo: "assets/images/gelato_image.jpg", // Update with actual asset path
    ingredients: "Gatuli"
  ),
  Product(
    name: "Empanada",
    description: "Description for Product 2",
    price: 100.99,
    photo: "assets/images/pizza_image.jpg", // Update with actual asset path
    ingredients: "Gatuli",
    sales: 22
  ),
  Product(
    name: "Durum triple meat double sauce with chips and soda",
    description: "Description for Product 3",
    price: 100.99,
    photo: "assets/images/cafe.jpg", // Update with actual asset path
    ingredients: "Gatuli"
  ),
];
