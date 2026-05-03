// ignore_for_file: avoid_print
import 'package:e_commerce_project/core/helper/db_helpers.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final DbHelper _dbHelper;
  final List<ProductModel> _favorites = [];

  WishlistProvider({required DbHelper dbHelper}) : _dbHelper = dbHelper {
    _loadFromDb();
  }

  List<ProductModel> get favorites => _favorites;

  bool isFavorite(ProductModel product) {
    return _favorites.any((p) => p.productId == product.productId);
  }

  void toggleFavorite(ProductModel product) async {
    final index = _favorites.indexWhere(
      (p) => p.productId == product.productId,
    );
    try {
      if (index != -1) {
        _favorites.removeAt(index);
        product.isFavorite = false;
        await _dbHelper.deleteWishlistItem(product.productId);
        print("❤️ Removed from wishlist: ${product.name}");
      } else {
        _favorites.add(product);
        product.isFavorite = true;
        await _dbHelper.insertWishlistItem({
          'productId': product.productId,
          'sku': product.sku,
          'name': product.name,
          'price': product.price,
          'special': product.special,
          'thumbnail': product.thumbnailUrl,
          'currency': product.currency,
          'discountPercentage': product.discountPercentage,
          'rating': product.rating,
        });
        print("❤️ Added to wishlist: ${product.name}");
      }
      await _loadFromDb();
      notifyListeners();
    } catch (e) {
      print("❌ Error toggling favorite: $e");
    }
  }

  void clearWishlist() {
    _favorites.clear();
    notifyListeners();
    _dbHelper.clearWishlist();
  }

  Future<void> _loadFromDb() async {
    try {
      final rows = await _dbHelper.getWishlistItems();
      _favorites.clear();
      for (final row in rows) {
        final product = ProductModel(
          productId: row['productId'] ?? '',
          sku: row['sku'] ?? '',
          name: row['name'] ?? '',
          price: row['price'] ?? '',
          special: row['special'] ?? '',
          thumbnailUrl: row['thumbnail'] ?? '',
          image: [],
          currency: row['currency'] ?? '',
          discountPercentage: row['discountPercentage'] ?? '',
          description: '',
          showLabel: false,
          labels: [],
          rating: row['rating'] ?? '',
          isFavorite: true,
        );
        _favorites.add(product);
      }
      print("Loaded ${favorites.length} items from wishlist database");
      notifyListeners();
    } catch (e) {
      print("Error loading wishlist from database: $e");
    }
  }
}
