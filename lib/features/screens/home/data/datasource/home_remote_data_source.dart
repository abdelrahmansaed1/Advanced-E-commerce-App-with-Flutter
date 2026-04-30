import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/network/api_client.dart';
import 'package:e_commerce_project/core/network/api_endpoints.dart';
import 'package:e_commerce_project/core/network/response_wrapper.dart';
import 'package:e_commerce_project/features/screens/home/model/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getDashboard();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<HomeModel> getDashboard() async {
    final result = await apiClient.get(
      ApiEndpoints.dashboard,
      queryParameters: {
        'currency_code': 'SAR',
        'version_number': '167',
        // 'platform': 'android',
      },
    );
    final response = result as ResponseWrapper;

    if (response.statusModel.code == 200 && response.data != null) {
      final data = (response.data as List).first;
      return HomeModel.fromJson(data);
    }

    throw ServerFailure(
      response.statusModel.errorMessages.isNotEmpty
          ? response.statusModel.errorMessages.first
          : 'Failed to load home data',
    );
  }
}
