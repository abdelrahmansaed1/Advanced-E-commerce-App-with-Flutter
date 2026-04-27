import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/network/api_client.dart';
import 'package:e_commerce_project/core/network/api_endpoints.dart';
import 'package:e_commerce_project/core/network/response_wrapper.dart';
import 'package:e_commerce_project/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response =
        await apiClient.post(
              ApiEndpoints.login,
              queryParameters: {'email': email, 'password': password},
            )
            as ResponseWrapper;
    if (response.statusModel.code == 200 && response.data != null) {
      final data = (response.data as List).first;
      return UserModel.fromJson(data);
    }

    throw ServerFailure(
      response.statusModel.errorMessages.isNotEmpty
          ? response.statusModel.errorMessages.first
          : response.statusModel.message.isNotEmpty
          ? response.statusModel.message
          : "Login failed ",
    );
  }
}
