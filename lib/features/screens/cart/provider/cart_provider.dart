import 'package:e_commerce_project/core/helper/cart_db_helpers.dart';
import 'package:e_commerce_project/features/screens/cart/model/cart_item.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final CartDbHelper _dbHelper;
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => _items.length;
  bool get isEmpty => _items.isEmpty;

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double deliveryFee = 15.0;
  double discount = 0.0;

  CartProvider({required CartDbHelper dbHelper}) : _dbHelper = dbHelper {
    _loadFromDb();
  }

  double get total => subtotal - (subtotal * discount / 100) + deliveryFee;

  void addProduct(
    ProductModel product, {
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
  }) async {
    final newItem = CartItem(
      product: product,
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
    );
    final existingIndex = _items.indexWhere((item) => item == newItem);
    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
      await _dbHelper.updateCartItem(_itemToMap(_items[existingIndex]));
    } else {
      _items.add(newItem);
      await _dbHelper.insertCartItem(_itemToMap(newItem));
    }
    notifyListeners();
    // addToCart(newItem);
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity < 1) return;
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = newQuantity;
      _dbHelper.updateCartItem(_itemToMap(_items[index]));
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    _dbHelper.deleteCartItem(item.product.productId);
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

  Future<void> _loadFromDb() async {
    final rows = await _dbHelper.getCartItems();
    _items.clear();
    for (final row in rows) {
      final product = ProductModel(
        productId: row['productId'],
        sku: '',
        name: row['name'],
        price: row['price'],
        special: row['special'],
        thumbnailUrl: row['thumbnail'],
        image: [],
        currency: row['currency'] ?? '',
        discountPercentage: row['discountPercentage'] ?? '',
        description: '',
        showLabel: false,
        labels: [],
        rating: '',
      );
      _items.add(
        CartItem(
          product: product,
          quantity: row['quantity'] ?? 1,
          selectedSize: row['selectedSize'],
          selectedColor: row['selectedColor'],
        ),
      );
    }
    notifyListeners();
  }

  Map<String, dynamic> _itemToMap(CartItem item) {
    return {
      'productId': item.product.productId,
      'name': item.product.name,
      'price': item.product.price,
      'special': item.product.special,
      'thumbnail': item.product.thumbnailUrl,
      'currency': item.product.currency,
      'discountPercentage': item.product.discountPercentage,
      'quantity': item.quantity,
      'selectedSize': item.selectedSize,
      'selectedColor': item.selectedColor,
    };
  }
}
