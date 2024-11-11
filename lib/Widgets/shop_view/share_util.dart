// share_util.dart
import 'package:share_plus/share_plus.dart';

void shareProduct(String productName, String shopName, String imageUrl) {
  final String message =
      'Check out this product: $productName from $shopName! $imageUrl';
  Share.share(message);
}
