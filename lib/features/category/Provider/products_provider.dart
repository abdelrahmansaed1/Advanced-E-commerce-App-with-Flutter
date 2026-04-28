import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/category/data/repositories/products_repository.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/foundation.dart';

enum ProductsState { idel, loading, loadingMore, success, error }

class ProductsProvider extends ChangeNotifier {
  final ProductsRepository productsRepository;

  ProductsProvider({required this.productsRepository});
  ProductsState state = ProductsState.idel;
  List<ProductModel> products = [];
  String? errorMessage;
  bool hasMore = true;
  int currentPage = 1;
  int categoryId = 0;

  //filterd lsit for home sections
  List<ProductModel> get newArrivals => products.where((p) => p.isNew).toList();
  List<ProductModel> get bestSellers =>
      products.where((p) => p.isBestseller).toList();
  List<ProductModel> get onSale => products.where((p) => p.hasSale).toList();

  List<ProductModel> get featured => products.toList();

  // load first page
  Future<void> loadProducts({int catId = 0, bool forceRefresh = false}) async {
    if (!forceRefresh &&
        products.isNotEmpty &&
        categoryId == catId &&
        state == ProductsState.success) {
      return;
    }

    categoryId = catId;
    currentPage = 1;
    products = [];
    hasMore = true;
    state = ProductsState.loading;
    errorMessage = null;

    notifyListeners();

    try {
      final response = await productsRepository.getProducts(
        categoryId: categoryId,
        page: currentPage,
      );
      products = response.products;
      hasMore = response.hasMore;
      state = ProductsState.success;
    } on Failure catch (e) {
      errorMessage = e.message;
      state = ProductsState.error;
    } catch (e) {
      errorMessage = e.toString();
      state = ProductsState.error;
    }
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (!hasMore || state == ProductsState.loadingMore) return;
    state = ProductsState.loadingMore;
    notifyListeners();
    try {
      currentPage++;
      final response = await productsRepository.getProducts(
        categoryId: categoryId,
        page: currentPage,
      );
      products.addAll(response.products);
      hasMore = response.hasMore;
      state = ProductsState.success;
      notifyListeners();
    } on Failure catch (e) {
      errorMessage = e.message;
      state = ProductsState.error;
      currentPage--;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      currentPage--;
      state = ProductsState.error;
      notifyListeners();
    }
  }
}
