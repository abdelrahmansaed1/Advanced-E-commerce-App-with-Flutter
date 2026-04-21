import 'package:e_commerce_project/core/data/dummy_data.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  // Start with products that are already marked as favorite in dummy data
  final List<ProductsModel> _favorites = DummyData.allProducts
      .where((product) => product.isFavorite == true)
      .toList();

  List<ProductsModel> get favorites => _favorites;

  bool isFavorite(ProductsModel product) {
    return _favorites.any((p) => p.id == product.id);
  }

  void toggleFavorite(ProductsModel product) {
    final index = _favorites.indexWhere((p) => p.id == product.id);
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
