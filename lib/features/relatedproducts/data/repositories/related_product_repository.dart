import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:e_commerce_project/features/relatedproducts/data/datasource/related_product_remote_data_source.dart';

abstract class RelatedProductsRepository {
  Future<List<ProductModel>> getRelatedProducts({required String productId});
}

class RelatedProductsRepositoryImpl implements RelatedProductsRepository {
  final RelatedProductsRemoteDataSource remoteDataSource;

  RelatedProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductModel>> getRelatedProducts({
    required String productId,
  }) async {
    try {
      return await remoteDataSource.getRelatedProducts(productId: productId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
