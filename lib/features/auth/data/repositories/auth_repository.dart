import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce_project/features/auth/data/model/user_model.dart';
import 'package:e_commerce_project/core/error/failures.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String email, required String password});
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
}
