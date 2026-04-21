import 'package:e_commerce_project/models/cart_item.dart';
import 'package:e_commerce_project/models/products_model.dart';
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

  void addToCart(CartItem newItem) {
    final existingIndex = _items.indexWhere((item) => item == newItem);

    if (existingIndex != -1) {
      _items[existingIndex].quantity += newItem.quantity;
    } else {
      _items.add(newItem);
    }
    notifyListeners();
  }

  void addProduct(
    ProductsModel product, {
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
  }) {
    final newItem = CartItem(
      product: product,
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
    );

    addToCart(newItem);
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

  void removePromoCode() {
    discount = 0.0;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    discount = 0.0;
    notifyListeners();
  }
}
