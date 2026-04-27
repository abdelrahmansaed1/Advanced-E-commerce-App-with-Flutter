import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/network/api_client.dart';
import 'package:e_commerce_project/core/network/api_endpoints.dart';
import 'package:e_commerce_project/core/network/response_wrapper.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';

abstract class RelatedProductsRemoteDataSource {
  Future<List<ProductModel>> getRelatedProducts({required String productId});
}

class RelatedProductsRemoteDataSourceImpl
    implements RelatedProductsRemoteDataSource {
  final ApiConsumer apiClient;

  RelatedProductsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getRelatedProducts({
    required String productId,
  }) async {
    final result = await apiClient.get(
      ApiEndpoints.relatedProducts,
      queryParameters: {'prod_id': productId},
    );
    final response = result as ResponseWrapper;

    if (response.statusModel.code == 200 && response.data != null) {
      final data = response.data as List;
      return data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw ServerFailure(
      response.statusModel.errorMessages.isNotEmpty
          ? response.statusModel.errorMessages.first
          : 'Failed to load related products',
    );
  }
}
