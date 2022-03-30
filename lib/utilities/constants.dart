import 'package:flutter/foundation.dart';

class Constants {
  static const String baseUrl = 'https://new.jourikw.com';
  static const String baseAuthUrl = '$baseUrl/wp-json/jwt-auth/v2/token';
  static const String _consumerKey =
      'consumer_key=ck_b4c0cc377a3e60cbe2d5b92bbad823e623c7ac91';
  static const String _consumerSecret =
      'consumer_secret=cs_46facf752beb7a9975da758339adb7059c8d9abb';
  static const String wooAuth = '?$_consumerKey&$_consumerSecret';
  static const String customer = '/wp-json/wc/v3/customers';
  static const String products = '/wp-json/wc/v3/products';
  static const String categories = '/wp-json/wc/v3/products/categories';
  static const String tags = '/wp-json/wc/v3/products/tags';
  static const String attributes = '/wp-json/wc/v3/products/attributes';
  static const String terms = '/terms';
  static const String variations = '/variations';
  static const int colorAttributeId = 1;
  static const int fabricAttributeId = 6;
  static const String productByFabricAttributeTerm =
      'attribute=pa_fabric&attribute_term=';
  static const String mobileBanners = '/wp-json/wp/v2/mobile_banners';
  static const String totalPagesKey = 'x-wp-totalpages';
  static const String termsPageUrl =
      'https://new.jourikw.com/index.php/privacy-policy/';
}
