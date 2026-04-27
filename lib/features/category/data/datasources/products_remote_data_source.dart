import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/network/api_client.dart';
import 'package:e_commerce_project/core/network/api_endpoints.dart';
import 'package:e_commerce_project/core/network/response_wrapper.dart';
import 'package:e_commerce_project/features/product/model/products_response_model.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsResponseModel> getProducts({
    required int categoryId,
    required int page,
  });
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiConsumer apiClient;

  ProductsRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<ProductsResponseModel> getProducts({
    required int categoryId,
    required int page,
  }) async {
    final result = await apiClient.get(
      ApiEndpoints.categoryProducts,
      queryParameters: {
        'category_id': categoryId.toString(),
        'page': page.toString(),
        'list_type': 3,
        'currency_code': 'SAR',
      },
    );
    // final response = result as ResponseWrapper;

    // if (response.statusModel.code == 200 && response.data != null) {
    //   final List data = (response.data as List).first;
    //   if (data.isEmpty) {
    //     throw ServerFailure('No products found');
    //   }
    //   final first = data.first;
    //   final productsList = first['products'] as List;
    //   return ProductsResponseModel.fromJson({
    //     'products': productsList,
    //     'hasMore': first['has_more'] ?? false,
    //   });
    // }

    // throw ServerFailure(
    //   response.statusModel.errorMessages.isNotEmpty
    //       ? response.statusModel.errorMessages.first
    //       : 'Failed to load products',
    // );
    final response = result as ResponseWrapper;

    if (response.statusModel.code == 200 && response.data != null) {
      dynamic data = response.data;

      // إذا كانت List
      if (data is List) {
        if (data.isEmpty) {
          throw ServerFailure('No data');
        }
        return ProductsResponseModel.fromJson(data.first);
      }

      // إذا كانت Map
      if (data is Map<String, dynamic>) {
        return ProductsResponseModel.fromJson(data);
      }

      throw ServerFailure('Unexpected data format');
    }
    throw ServerFailure(
      response.statusModel.errorMessages.isNotEmpty
          ? response.statusModel.errorMessages.first
          : 'Failed to load products',
    );
  }
}
