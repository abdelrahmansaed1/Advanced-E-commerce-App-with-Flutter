import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/network/api_client.dart';
import 'package:e_commerce_project/core/network/api_endpoints.dart';
import 'package:e_commerce_project/core/network/response_wrapper.dart';
import 'package:e_commerce_project/features/product/model/product_detail_model.dart';

abstract class ProductDetailRemoteDataSource {
  Future<ProductDetailModel> getProductDetail({required String productId});
}

class ProductDetailRemoteDataSourceImpl
    implements ProductDetailRemoteDataSource {
  final ApiConsumer apiClient;

  ProductDetailRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<ProductDetailModel> getProductDetail({
    required String productId,
  }) async {
    final result = await apiClient.get(
      ApiEndpoints.productDetails,
      queryParameters: {'product_id': productId},
    );
    final response = result as ResponseWrapper;

    if (response.statusModel.code == 200 && response.data != null) {
      final data = (response.data as List).first;
      return ProductDetailModel.fromJson(data);
    }
    throw ServerFailure(
      response.statusModel.errorMessages.isNotEmpty
          ? response.statusModel.errorMessages.first
          : 'Failed to load product details',
    );
  }
}
