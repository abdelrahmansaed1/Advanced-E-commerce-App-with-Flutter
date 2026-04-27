import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:e_commerce_project/features/relatedproducts/data/repositories/related_product_repository.dart';
import 'package:flutter/material.dart';

enum RelatedProductsState { idle, loading, error, success }

class RelatedProductsProvider extends ChangeNotifier {
  final RelatedProductsRepository repository;

  RelatedProductsProvider({required this.repository});

  List<ProductModel> products = [];
  RelatedProductsState state = RelatedProductsState.idle;
  String? errorMessage;
  String? _lastLoadedId;

  Future<void> loadRelatedProducts({required String productId}) async {
    if (_lastLoadedId == productId && products.isNotEmpty) return;

    state = RelatedProductsState.loading;
    errorMessage = null;
    products = [];
    notifyListeners();
    try {
      products = await repository.getRelatedProducts(productId: productId);
      _lastLoadedId = productId;
      state = RelatedProductsState.success;
    } on Failure catch (e) {
      errorMessage = e.message;
      state = RelatedProductsState.error;
    } catch (e) {
      errorMessage = e.toString();
      state = RelatedProductsState.error;
    }
    notifyListeners();
  }

  void clear() {
    products = [];
    _lastLoadedId = null;
    state = RelatedProductsState.idle;
    notifyListeners();
  }
}
