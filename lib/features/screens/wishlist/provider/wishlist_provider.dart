import 'package:e_commerce_project/core/helper/wishlist_db_helpers.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistDbHelpers _dbHelper;
  final List<ProductModel> _favorites = [];

  WishlistProvider({required WishlistDbHelpers dbHelper})
    : _dbHelper = dbHelper {
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
    if (index != -1) {
      _favorites.removeAt(index);
      product.isFavorite = false;
      await _dbHelper.deleteWishlistItem(product.productId);
    } else {
      _favorites.add(product);
      product.isFavorite = true;
      await _dbHelper.insertWishlistItem({
        'productId': product.productId,
        'sku': product.sku,
        'name': product.name,
        'price': product.price,
        'special': product.special,
        'thumbnailUrl': product.thumbnailUrl,
        'currency': product.currency,
        'discountPercentage': product.discountPercentage,
        'rating': product.rating,
      });
    }
    notifyListeners();
  }

  void clearWishlist() {
    _favorites.clear();
    notifyListeners();
  }

  Future<void> _loadFromDb() async {
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
    notifyListeners();
  }
}
