import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/network/api_client.dart';
import 'package:e_commerce_project/core/network/api_endpoints.dart';
import 'package:e_commerce_project/core/network/response_wrapper.dart';
import 'package:e_commerce_project/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<String> refreshToken({required String token});
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

  @override
  Future<void> logout() async {
    final result = await apiClient.post(ApiEndpoints.logout);
    final response = result as ResponseWrapper;
    if (response.statusModel.code != 200) {
      debugPrint('Logout API returned: ${response.statusModel.message}');
    }
  }

  @override
  Future<String> refreshToken({required String token}) async {
    final result = await apiClient.post(
      ApiEndpoints.refreshToken,
      queryParameters: {'token': token},
    );
    final response = result as ResponseWrapper;
    if (response.statusModel.code == 200 && response.data != null) {
      final data = (response.data as List).first;
      return data['customer_token'] ?? '';
    }
    throw AuthFailure('Failed to refresh token');
  }
}
