import 'package:flutter/foundation.dart';

class BaseUrlResolver {
  static String getBaseUrl() {
    if (kIsWeb) {
      final uri = Uri.base;
      // You can use host or query params to decide the backend base URL
      if (uri.host.contains('localhost')) {
        return 'http://localhost:5000/api';
      } else if (uri.host.contains('staging')) {
        return 'https://staging.api.example.com';
      } else {
        return 'https://api.example.com';
      }
    } else {
      // Default for mobile app
      return 'https://api.example.com';
    }
  }
}
