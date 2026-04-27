import 'package:e_commerce_project/features/product/model/product_model.dart';

class CartItem {
  // final int id;
  final ProductModel product;
  int quantity;
  String? selectedSize;
  String? selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
    // required this.id,
  });

  double get totalPrice => product.priceAsDouble * quantity;

  // للمقارنة عند إضافة نفس المنتج مرة أخرى
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          product.productId == other.product.productId &&
          selectedSize == other.selectedSize &&
          selectedColor == other.selectedColor;

  @override
  int get hashCode =>
      product.name.hashCode ^ selectedSize.hashCode ^ selectedColor.hashCode;
}
