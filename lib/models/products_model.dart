class ProductsModel {
  final String title;
  final double price;
  final double? oldPrice;
  final bool hasSale;
  final String? image;
  final bool isAdded;

  ProductsModel({
    required this.title,
    required this.price,
    this.oldPrice,
    required this.hasSale,
    this.image,
    this.isAdded = false,
  });
}
