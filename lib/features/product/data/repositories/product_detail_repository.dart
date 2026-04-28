import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/product/data/datasource/product_detail_remote_data_source.dart';
import 'package:e_commerce_project/features/product/model/product_detail_model.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';

abstract class ProductDetailRepository {
  Future<ProductDetailModel> getProductDetail({required String productId});
}

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource remoteDataSource;

  final Map<String, List<ProductModel>> _cache = {};

  ProductDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductDetailModel> getProductDetail({
    required String productId,
  }) async {
    try {
      return await remoteDataSource.getProductDetail(productId: productId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
