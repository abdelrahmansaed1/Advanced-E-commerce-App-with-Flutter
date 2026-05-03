// import 'package:e_commerce_project/core/helper/cart_db_helpers.dart';
// import 'package:e_commerce_project/features/screens/cart/model/cart_item.dart';
// import 'package:e_commerce_project/features/product/model/product_model.dart';
// import 'package:flutter/material.dart';

// class CartProvider extends ChangeNotifier {
//   final CartDbHelper _dbHelper;
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;
//   int get itemCount => _items.length;
//   bool get isEmpty => _items.isEmpty;

//   double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
//   double deliveryFee = 15.0;
//   double discount = 0.0;

//   CartProvider({required CartDbHelper dbHelper}) : _dbHelper = dbHelper {
//     _loadFromDb();
//   }

//   double get total => subtotal - (subtotal * discount / 100) + deliveryFee;

//   // void addProduct(
//   //   ProductModel product, {
//   //   int quantity = 1,
//   //   String? selectedSize,
//   //   String? selectedColor,
//   // }) async {
//   //   final newItem = CartItem(
//   //     product: product,
//   //     quantity: quantity,
//   //     selectedSize: selectedSize,
//   //     selectedColor: selectedColor,
//   //   );
//   //   final existingIndex = _items.indexWhere((item) => item == newItem);
//   //   if (existingIndex != -1) {
//   //     _items[existingIndex].quantity += quantity;
//   //     await _dbHelper.updateCartItem(_itemToMap(_items[existingIndex]));
//   //   } else {
//   //     _items.add(newItem);
//   //     await _dbHelper.insertCartItem(_itemToMap(newItem));
//   //   }
//   //   notifyListeners();
//     // addToCart(newItem);
//   // }
//   void addProduct(
//   ProductModel product, {
//   int quantity = 1,
//   String? selectedSize,
//   String? selectedColor,
// }) async {
//   final newItem = CartItem(
//     product: product,
//     quantity: quantity,
//     selectedSize: selectedSize,
//     selectedColor: selectedColor,
//   );

//   final existingIndex = _items.indexWhere((item) => item == newItem);

//   try {
//     if (existingIndex != -1) {
//       // Update existing item
//       _items[existingIndex].quantity += quantity;
//       await _dbHelper.updateCartItem(_itemToMap(_items[existingIndex]));
//     } else {
//       // Add new item
//       _items.add(newItem);
//       await _dbHelper.insertCartItem(_itemToMap(newItem));
//     }

//     // Reload from database to be safe
//     await _loadFromDb();

//     notifyListeners();
//     print("✅ Item added/updated successfully in database");
//   } catch (e) {
//     print("❌ Error saving to cart database: $e");
//   }
// }

//   void updateQuantity(CartItem item, int newQuantity) {
//     if (newQuantity < 1) return;
//     final index = _items.indexOf(item);
//     if (index != -1) {
//       _items[index].quantity = newQuantity;
//       _dbHelper.updateCartItem(_itemToMap(_items[index]));
//       notifyListeners();
//     }
//   }

//   void removeItem(CartItem item) {
//     _items.remove(item);
//     _dbHelper.deleteCartItem(item.product.productId);
//     notifyListeners();
//   }

//   void applyPromoCode(double promoDiscount) {
//     discount = promoDiscount;
//     notifyListeners();
//   }

//   // void removePromoCode() {
//   //   discount = 0.0;
//   //   notifyListeners();
//   // }

//   void clearCart() {
//     _items.clear();
//     discount = 0.0;
//     notifyListeners();
//   }

//   Future<void> _loadFromDb() async {
//     final rows = await _dbHelper.getCartItems();
//     _items.clear();
//     for (final row in rows) {
//       final product = ProductModel(
//         productId: row['productId'],
//         sku: '',
//         name: row['name'],
//         price: row['price'],
//         special: row['special'],
//         thumbnailUrl: row['thumbnail'],
//         image: [],
//         currency: row['currency'] ?? '',
//         discountPercentage: row['discountPercentage'] ?? '',
//         description: '',
//         showLabel: false,
//         labels: [],
//         rating: '',
//       );
//       _items.add(
//         CartItem(
//           product: product,
//           quantity: row['quantity'] ?? 1,
//           selectedSize: row['selectedSize'],
//           selectedColor: row['selectedColor'],
//         ),
//       );
//     }
//     //logging message
//     print("Loaded ${ _items.length } items from database");
//     notifyListeners();
//   }

//   Map<String, dynamic> _itemToMap(CartItem item) {
//     return {
//       'productId': item.product.productId,
//       'name': item.product.name,
//       'price': item.product.price,
//       'special': item.product.special,
//       'thumbnail': item.product.thumbnailUrl,
//       'currency': item.product.currency,
//       'discountPercentage': item.product.discountPercentage,
//       'quantity': item.quantity,
//       'selectedSize': item.selectedSize,
//       'selectedColor': item.selectedColor,
//     };
//   }
// }

// lib/features/screens/cart/provider/cart_provider.dart

// ignore_for_file: avoid_print

import 'package:e_commerce_project/core/helper/db_helpers.dart';
import 'package:e_commerce_project/features/screens/cart/model/cart_item.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final DbHelper _dbHelper;
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => _items.length;
  bool get isEmpty => _items.isEmpty;

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double deliveryFee = 15.0;
  double discount = 0.0;

  double get total => subtotal - (subtotal * discount / 100) + deliveryFee;

  CartProvider({required DbHelper dbHelper}) : _dbHelper = dbHelper {
    _loadFromDb();
  }

  // ================== Add to Cart ==================
  Future<void> addProduct(
    ProductModel product, {
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
    int? maxQuantity,
  }) async {
    final newItem = CartItem(
      product: product,
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
      maxQuantity: maxQuantity = 10,
    );

    final existingIndex = _items.indexWhere((item) => item == newItem);

    try {
      if (existingIndex != -1) {
        // Item already exists → increase quantity
        // _items[existingIndex].quantity += quantity;
        final existing = _items[existingIndex];
        final newQty = existing.quantity + quantity;
        // ✅ Cap at max available quantity
        if (newQty > existing.maxQuantity) {
          existing.quantity = existing.maxQuantity;
        } else {
          existing.quantity = newQty;
        }

        await _dbHelper.updateCartItem(_itemToMap(_items[existingIndex]));

        print("✅ Quantity updated for ${product.name}");
      } else {
        // New item
        newItem.quantity = quantity.clamp(1, maxQuantity);
        _items.add(newItem);
        await _dbHelper.insertCartItem(_itemToMap(newItem));
        print("✅ New item added to cart: ${product.name}");
      }

      await _loadFromDb(); // Always reload from DB to stay in sync
      notifyListeners();
    } catch (e) {
      print("❌ Error adding to cart: $e");
    }
  }

  // ✅ Returns true if quantity was increased, false if at max
  bool canIncrement(CartItem item) {
    return item.quantity < item.maxQuantity;
  }

  // ================== Increment ==================
  Future<bool> incrementQuantity(CartItem item) async {
    final index = _items.indexWhere((i) => i == item);
    if (index == -1) return false;

    final current = _items[index];

    // ✅ Check against max available stock
    if (current.quantity >= current.maxQuantity) {
      return false; // signal to UI: can't add more
    }

    try {
      current.quantity += 1;
      await _dbHelper.updateCartItem(_itemToMap(current));
      await _loadFromDb();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('❌ Error incrementing: $e');
      return false;
    }
  }

  // ================== Decrement — returns 'removed' signal ==================
  /// Returns true if item was removed (quantity reached 0)
  /// Returns false if quantity was just decremented
  Future<bool> decrementQuantity(CartItem item) async {
    final index = _items.indexWhere((i) => i == item);
    if (index == -1) return false;

    final current = _items[index];

    if (current.quantity <= 1) {
      // ✅ Signal to UI to show confirmation dialog
      return true; // means: "ask user to confirm removal"
    }

    try {
      current.quantity -= 1;
      await _dbHelper.updateCartItem(_itemToMap(current));
      await _loadFromDb();
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint('❌ Error decrementing: $e');
      return false;
    }
  }

  // ================== Update Quantity ==================
  Future<void> updateQuantity(CartItem item, int newQuantity) async {
    if (newQuantity < 1) return;

    final index = _items.indexOf(item);
    if (index != -1) {
      try {
        _items[index].quantity = newQuantity;
        await _dbHelper.updateCartItem(_itemToMap(_items[index]));
        await _loadFromDb();
        notifyListeners();
      } catch (e) {
        print("❌ Error updating quantity: $e");
      }
    }
  }

  // ================== Remove Item ==================
  Future<void> removeItem(CartItem item) async {
    try {
      _items.remove(item);
      await _dbHelper.deleteCartItem(item.product.productId);
      await _loadFromDb();
      notifyListeners();
      print("✅ Item removed from cart");
    } catch (e) {
      print("❌ Error removing item: $e");
    }
  }

  void applyPromoCode(double promoDiscount) {
    discount = promoDiscount;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    discount = 0.0;
    notifyListeners();
    _dbHelper.clearCart();
  }

  // ================== Load from Database ==================
  Future<void> _loadFromDb() async {
    try {
      final rows = await _dbHelper.getCartItems();
      _items.clear();

      for (final row in rows) {
        final product = ProductModel(
          productId: row['productId'] ?? '',
          sku: '',
          name: row['name'] ?? '',
          price: row['price'] ?? '0',
          special: row['special'] ?? '',
          thumbnailUrl: row['thumbnail'] ?? '',
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
      print("📊 Loaded ${_items.length} items from cart database");
      notifyListeners();
    } catch (e) {
      print("❌ Error loading cart from database: $e");
    }
  }

  // Helper to convert CartItem → Map
  Map<String, dynamic> _itemToMap(CartItem item) {
    return {
      'productId': item.product.productId,
      'name': item.product.name,
      'price': item.product.price,
      'special': item.product.special,
      'thumbnail': item.product.thumbnailUrl,
      'quantity': item.quantity,
      'currency': item.product.currency,
      'discountPercentage': item.product.discountPercentage,
      'selectedSize': item.selectedSize,
      'selectedColor': item.selectedColor,
    };
  }
}
