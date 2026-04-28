import 'package:e_commerce_project/features/category/Provider/products_provider.dart';
import 'package:e_commerce_project/features/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';

class AppInitProvider extends ChangeNotifier {
  final HomeProvider homeProvider;
  final ProductsProvider productsProvider;

  bool isInitialized = false;

  AppInitProvider({
    required this.homeProvider,
    required this.productsProvider,
  });

  Future<void> init() async {
    // Both load at the same time — total time = slowest one, not sum of both
    await Future.wait([
      homeProvider.loadDashboard(),
      productsProvider.loadProducts(),
    ]);
    isInitialized = true;
    notifyListeners();
  }
}