import 'package:e_commerce_project/features/product/model/product_model.dart';

class ProductsResponseModel {
  final List<ProductModel> products;
  final int total;
  final int productsTotal;
  final int numberOfPages;
  final bool hasMore;

  ProductsResponseModel({
    required this.products,
    required this.total,
    required this.productsTotal,
    required this.numberOfPages,
    required this.hasMore,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductsResponseModel(
        products: (json['products'] as List? ?? [])
            .map((e) => ProductModel.fromJson(e))
            .toList(),
        total: json['total'] ?? 0,
        productsTotal: json['products_total'] ?? 0,
        numberOfPages: json['number_of_pages'] ?? 1,
        hasMore: json['has_more'] ?? false,
      );
}
