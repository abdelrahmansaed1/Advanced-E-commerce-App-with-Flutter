// lib/models/product/product_detail_model.dart

class SizeVariant {
  final String label;
  final String price;
  final String optionId;
  final String availableQuantity;

  SizeVariant({
    required this.label,
    required this.price,
    required this.optionId,
    required this.availableQuantity,
  });

  bool get isAvailable =>
      int.tryParse(availableQuantity) != null &&
      int.parse(availableQuantity) > 0;

  factory SizeVariant.fromJson(Map<String, dynamic> json) => SizeVariant(
    label: json['label'] ?? '',
    price: json['price_variance']?.toString() ?? '0',
    optionId: json['option_id']?.toString() ?? '',
    availableQuantity: json['available_quantity']?.toString() ?? '0',
  );
}

class ProductOption {
  final String name;
  final String optionId;
  final List<SizeVariant> variants;

  ProductOption({
    required this.name,
    required this.optionId,
    required this.variants,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
    name: json['name'] ?? '',
    optionId: json['product_option_id']?.toString() ?? '',
    variants: (json['variants'] as List? ?? [])
        .map((e) => SizeVariant.fromJson(e))
        .toList(),
  );
}

class ProductDetailModel {
  final String productId;
  final String sku;
  final String name;
  final String price;
  final String special;
  final String discountPercentage;
  final String currency;
  final String description;
  final List<String> images;
  final List<ProductOption> options;
  final bool isNew;
  final bool isBestseller;
  final bool isOutOfStock;
  final double rating;
  final int reviews;
  final String shareUrl;
  final String sizeGuide;
  bool isFavorite;

  ProductDetailModel({
    required this.productId,
    required this.sku,
    required this.name,
    required this.price,
    required this.special,
    required this.currency,
    required this.description,
    required this.images,
    required this.options,
    required this.isNew,
    required this.isBestseller,
    required this.isOutOfStock,
    required this.rating,
    required this.reviews,
    required this.shareUrl,
    required this.sizeGuide,
    this.isFavorite = false,
    required this.discountPercentage,
  });

  bool get hasSale => discountPercentage.isNotEmpty;
  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  double? get specialAsDouble => hasSale ? double.tryParse(special) : null;

  // Get sizes from first option (usually "Sizes")
  List<SizeVariant> get sizes =>
      options.isNotEmpty ? options.first.variants : [];
  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    String rawDesc = json['description'] ?? '';
    // Remove HTML tags and table
    final tableIndex = rawDesc.indexOf('<table');
    String cleanDesc = tableIndex != -1
        ? rawDesc.substring(0, tableIndex).trim()
        : rawDesc.trim();

    // Remove any remaining HTML tags
    cleanDesc = cleanDesc
        .replaceAll(RegExp(r'<[^>]*>'), '') // remove HTML tags
        .replaceAll(RegExp(r'\r\n|\n'), ' ') // replace newlines
        .trim();

    final String discountPercentage =
        json['discount_percentage']?.toString() ?? '';
    final String price = json['price']?.toString() ?? '0';
    final String baseCurrencyPrice =
        json['base_currency_price']?.toString() ?? '0';

    // Sale logic:
    // - discount_percentage is not empty = has sale
    // - base_currency_price is the ORIGINAL price
    // - price is the SALE price (but can be 0 if product is free/old)
    final bool hasSale =
        discountPercentage.isNotEmpty &&
        discountPercentage != '' &&
        baseCurrencyPrice != '0';

    return ProductDetailModel(
      productId: json['product_id']?.toString() ?? '',
      sku: json['sku'] ?? '',
      name: json['name'] ?? '',
      price: hasSale ? price : baseCurrencyPrice, // sale price or normal price
      special: hasSale ? baseCurrencyPrice : '0', // original price if on sale
      currency: json['currency'] ?? '',
      description: cleanDesc,
      discountPercentage: discountPercentage,
      images: (json['images'] as List? ?? [])
          .map((e) => e['url']?.toString() ?? '')
          .where((url) => url.isNotEmpty)
          .toList(),
      options: (json['options'] as List? ?? [])
          .map((e) => ProductOption.fromJson(e))
          .toList(),
      isNew: json['is_new'] ?? false,
      isBestseller: json['is_bestseller'] ?? false,
      isOutOfStock: json['is_out_of_stock'] ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviews: json['reviews'] ?? 0,
      shareUrl: json['share_url'] ?? '',
      sizeGuide: json['size_guide'] ?? '',
    );
  }
}
