import 'package:e_commerce_project/features/screens/cart/model/cart_item.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => _items.length;
  bool get isEmpty => _items.isEmpty;

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double deliveryFee = 15.0;
  double discount = 0.0;

  double get total => subtotal - (subtotal * discount / 100) + deliveryFee;

  void addProduct(
    ProductModel product, {
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
  }) {
    final newItem = CartItem(
      // id: int.parse(product.productId),
      product: product,
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
    );
    final existingIndex = _items.indexWhere((item) => item == newItem);
    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(newItem);
    }
    notifyListeners();
    // addToCart(newItem);
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity < 1) return;
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void applyPromoCode(double promoDiscount) {
    discount = promoDiscount;
    notifyListeners();
  }

  // void removePromoCode() {
  //   discount = 0.0;
  //   notifyListeners();
  // }

  void clearCart() {
    _items.clear();
    discount = 0.0;
    notifyListeners();
  }
}
