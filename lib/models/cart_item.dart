import 'package:e_commerce_project/models/products_model.dart';

class CartItem {
  final ProductsModel product;
  int quantity;
  String? selectedSize;
  String? selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
  });

  double get totalPrice => product.price * quantity;

  // للمقارنة عند إضافة نفس المنتج مرة أخرى
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          product.title == other.product.title &&
          selectedSize == other.selectedSize &&
          selectedColor == other.selectedColor;

  @override
  int get hashCode =>
      product.title.hashCode ^ selectedSize.hashCode ^ selectedColor.hashCode;
}
