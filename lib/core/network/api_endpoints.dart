class ApiEndpoints {
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth
  static const String login = '/rest/V1/ktpl/account/login?___store=en';

  static const String dashboard = '/rest/V1/ktpl/home/dashboard?___store=en';

  // Products
  static const String categoryProducts =
      '/rest/V1/ktpl/getCategoryProducts?___store=en';

  static const String relatedProducts =
      '/rest/V1/ktpl/product/related?___store=en&currency_code=SAR';

  static const String productDetails =
      '/rest/V1/ktpl/getProduct?___store=en&currency_code=SAR&version_number=167';

  static const String logout = '/rest/V1/ktpl/account/logout?___store=en';
  static const String refreshToken = '/rest/V1/ktpl/account/refreshToken';
}
