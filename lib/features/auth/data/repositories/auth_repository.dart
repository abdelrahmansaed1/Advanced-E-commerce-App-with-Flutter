import 'dart:convert';
import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce_project/features/auth/model/user_model.dart';
import 'package:e_commerce_project/core/error/failures.dart';
import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<void> refreshTokenIfNeeded();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.appPreferences,
  });
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      // Save token and user data locally
      await appPreferences.setToken(user.customerToken);
      await appPreferences.setAuthenticated(true);
      await appPreferences.setUserEmail(user.email);
      await appPreferences.setUserName(user.name);
      return user;
    } catch (e) {
      if (e is Failure) {
        throw ServerFailure(e.message);
      }
      throw ServerFailure("Un Known Failure: ${e.toString()}");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      debugPrint('Logout API error: $e');
    } finally {
      await appPreferences.logout();
    }
  }

  @override
  Future<void> refreshTokenIfNeeded() async {
    try {
      final currentToken = appPreferences.getToken();
      if (currentToken == null || currentToken.isEmpty) return;

      if (_isTokenExpired(currentToken)) {
        debugPrint('Token expired — attempting refresh');
        final newToken = await remoteDataSource.refreshToken(
          token: currentToken,
        );
        if (newToken.isNotEmpty) {
          await appPreferences.setToken(newToken);
          debugPrint('Token refreshed successfully');
        }
      }
    } on AuthFailure catch (e) {
      // ✅ Don't logout on refresh failure — just log it
      // The user can still use the app until they get a real 401
      debugPrint('Token refresh failed: ${e.message} — keeping existing token');
    } catch (e) {
      debugPrint('Token refresh failed: $e — logging out');
      await appPreferences.logout();
    }
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      String payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }

      final decode = utf8.decode(base64Url.decode(payload));
      final Map<String, dynamic> josn = jsonDecode(decode);

      final exp = josn['exp'];
      if (exp == null) return true;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiryDate.subtract(Duration(minutes: 5)));
    } catch (e) {
      return true;
    }
  }
}
