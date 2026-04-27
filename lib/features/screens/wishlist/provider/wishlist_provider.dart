import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  // Start with products that are already marked as favorite in dummy data
  // final List<ProductModel> _favorites = DummyData.allProducts
  //     .where((product) => product?.isFavorite == true)
  //     .toList();
  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  bool isFavorite(ProductModel product) {
    return _favorites.any((p) => p.productId == product.productId);
  }

  void toggleFavorite(ProductModel product) {
    final index = _favorites.indexWhere(
      (p) => p.productId == product.productId,
    );
    if (index != -1) {
      _favorites.removeAt(index);
      product.isFavorite = false;
    } else {
      _favorites.add(product);
      product.isFavorite = true;
    }
    notifyListeners();
  }

  void clearWishlist() {
    _favorites.clear();
    notifyListeners();
  }
}
