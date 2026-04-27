import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/product/data/repositories/product_detail_repository.dart';
import 'package:e_commerce_project/features/product/model/product_detail_model.dart';
import 'package:flutter/material.dart';

enum ProductDetailState { idle, loading, error, success }

class ProductDetailProvider extends ChangeNotifier {
  final ProductDetailRepository repository;

  ProductDetailProvider({required this.repository});

  ProductDetailState state = ProductDetailState.idle;
  ProductDetailModel? product;
  String? errorMessage;

  String? selectedSize;
  int quantity = 1;

  Future<void> loadProduct({required String productId}) async {
    state = ProductDetailState.loading;
    errorMessage = null;
    product = null;
    selectedSize = null;
    quantity = 1;
    notifyListeners();

    try {
      product = await repository.getProductDetail(productId: productId);
      if (product!.sizes.isNotEmpty) {
        final firstAvailable = product!.sizes.firstWhere(
          (s) => s.isAvailable,
          orElse: () => product!.sizes.first,
        );
        selectedSize = firstAvailable.label;
      }
      state = ProductDetailState.success;
    } on Failure catch (e) {
      errorMessage = e.message;
      state = ProductDetailState.error;
    } catch (e) {
      errorMessage = e.toString();
      state = ProductDetailState.error;
    }
    notifyListeners();
  }

  void selectSize(String size) {
    selectedSize = size;
    notifyListeners();
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void reset() {
    state = ProductDetailState.idle;
    product = null;
    errorMessage = null;
    selectedSize = null;
    quantity = 1;
    notifyListeners();
  }
}
