class ProductsModel {
  final String id;
  final String title;
  final double price;
  final double? oldPrice;
  final bool hasSale;
  final List<String>? image;
  bool isAdded;
  final String? description;
  bool isFavorite;
  final double? rating;

  ProductsModel({
    required this.title,
    required this.price,
    this.oldPrice,
    required this.hasSale,
    this.image,
    this.isAdded = false,
    this.description,
    this.isFavorite = false,
    this.rating = 4.2,
    required this.id,
  });
}
