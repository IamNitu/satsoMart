
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  const ApiEndpoints._();

  static const products = 'products/';

  // Helper method to construct the full image URL
  static String imageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    final imageHost = dotenv.env['API_IMAGE'] ?? 'https://api.sastotools.store/api/public/images/';
    final cleanHost = imageHost.endsWith('/') ? imageHost : '$imageHost/';
    var cleanPath = path.startsWith('/') ? path.substring(1) : path;

    if(cleanHost.contains('public/images/') && cleanPath.startsWith('public/images/')){
      cleanPath =cleanPath.replaceFirst('public/images', "");
    }
    return '$cleanHost$cleanPath';
  }
}