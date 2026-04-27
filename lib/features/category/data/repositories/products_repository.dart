import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/category/data/datasources/products_remote_data_source.dart';
import 'package:e_commerce_project/features/product/model/products_response_model.dart';

abstract class ProductsRepository {
  Future<ProductsResponseModel> getProducts({
    required int categoryId,
    required int page,
  });
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductsResponseModel> getProducts({
    required int categoryId,
    required int page,
  }) async {
    try {
      return await remoteDataSource.getProducts(
        categoryId: categoryId,
        page: page,
      );
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
