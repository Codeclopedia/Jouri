class Constants {
  static const String baseUrl = 'https://revamp.jourikw.com/';
  static const String baseAuthUrl = '$baseUrl/wp-json/jwt-auth/v1/token';
  static const String _consumerKey =
      'consumer_key=ck_2ac4be72f6beada4de7f394ddd2781f0d91d886d';
  static const String _consumerSecret =
      'consumer_secret=cs_038521dbeeed0ba40b0e70c9f256553f0b0ea40e';
  static const String wooAuth = '?$_consumerKey&$_consumerSecret';
  static const String customer = '/wp-json/wc/v3/customers';
  static const String products = '/wp-json/wc/v3/products';
  static const String categories = '/wp-json/wc/v3/products/categories';
  static const String tags = '/wp-json/wc/v3/products/tags';
  static const String attributes = '/wp-json/wc/v3/products/attributes';
  static const String terms = '/terms';
  static const String variations = '/variations';
  static const int colorAttributeId = 1;
  static const int fabricAttributeId = 14;
  static const String productByFabricAttributeTerm =
      'attribute=pa_fabric&attribute_term=';
  static const String mobileBanners = '/wp-json/wp/v2/mobile_banners';
  static const String totalPagesKey = 'x-wp-totalpages';
  static const String termsPageUrl =
      'https://new.jourikw.com/index.php/privacy-policy/';
  static const String orders = '/wp-json/wc/v3/orders';
  static const String paymentMethod = '/wp-json/wc/v3/payment_gateways';
  static const String shippingZone = '/wp-json/wc/v3/shipping/zones';
  static const String shippingZoneLocation = '$shippingZone/{id}/locations';
  static const String shippingMethod = '$shippingZone/{id}/methods';
  static const String processing = 'processing';
  static const String completed = 'completed';
  static const String canceled = 'cancelled';
  static const String pending = 'pending';
  static const String refundReq = 'refund-req';
  static const String onHold = 'on-hold';
  static const String refunded = 'refunded';
  static const String failed = 'failed';
}
