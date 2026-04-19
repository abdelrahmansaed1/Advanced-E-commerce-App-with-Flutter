class ProductsModel {
  final String title;
  final double price;
  final double? oldPrice;
  final bool hasSale;
  final String? image;
  final bool isAdded;
  final String? description;

  ProductsModel({
    required this.title,
    required this.price,
    this.oldPrice,
    required this.hasSale,
    this.image,
    this.isAdded = false,
    this.description,
  });
}
