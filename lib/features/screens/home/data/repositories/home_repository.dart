import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/screens/home/data/datasource/home_remote_data_source.dart';
import 'package:e_commerce_project/features/screens/home/model/home_model.dart';

abstract class HomeRepository {
  Future<HomeModel> getDashboard();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<HomeModel> getDashboard() async {
    try {
      return await remoteDataSource.getDashboard();
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
