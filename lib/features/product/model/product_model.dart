class LabelModel {
  final String text;
  final String backgroundColor;
  final String textColor;

  LabelModel({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  factory LabelModel.fromJson(Map<String, dynamic> json) => LabelModel(
    text: json['text'] ?? '',
    backgroundColor: json['background_color'] ?? '',
    textColor: json['text_color'] ?? '',
  );
}

class ProductImageModel {
  final String url;

  ProductImageModel({required this.url});

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      ProductImageModel(url: json['url'] ?? '');
}

class ProductModel {
  final String productId;
  final String sku;
  final String name;
  final String price;
  final String special; // sale price, "0" means no sale
  final String thumbnailUrl;
  final List<ProductImageModel> image;
  final String currency;
  final String discountPercentage;
  final String description;
  final bool isNew;
  final bool isBestseller;
  final bool showLabel;
  final List<LabelModel> labels;
  final String rating;
  bool isFavorite;

  ProductModel({
    required this.productId,
    required this.sku,
    required this.name,
    required this.price,
    required this.special,
    required this.thumbnailUrl,
    required this.image,
    required this.currency,
    required this.discountPercentage,
    required this.description,
    this.isNew = false,
    this.isBestseller = false,
    required this.showLabel,
    required this.labels,
    required this.rating,
    this.isFavorite = false,
  });

  bool get hasSale =>
      discountPercentage.isNotEmpty && discountPercentage != '0';
  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  double? get specialAsDouble => hasSale ? double.tryParse(special) : null;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: json['product_id']?.toString() ?? '',
    sku: json['sku'] ?? '',
    name: json['name'] ?? '',
    price: json['price']?.toString() ?? '0',
    special: json['special']?.toString() ?? '0',
    thumbnailUrl:
        json['thumbnail_url']?.toString() ?? json['image']?.toString() ?? '',
    image: (json['images'] as List? ?? [])
        .map((e) => ProductImageModel.fromJson(e))
        .toList(),
    currency: json['currency'] ?? '',
    discountPercentage: json['discount_percentage']?.toString() ?? '',
    description: json['description'] ?? '',
    isNew: json['is_new'] ?? false,
    isBestseller: json['is_bestseller'] ?? false,
    showLabel: json['show_label'] ?? false,
    labels: (json['label'] as List? ?? [])
        .map((e) => LabelModel.fromJson(e))
        .toList(),
    rating: json['rating']?.toString() ?? '',
  );
}
