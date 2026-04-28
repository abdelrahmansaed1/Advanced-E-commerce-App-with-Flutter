import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/features/auth/data/repositories/auth_repository.dart';
import 'package:e_commerce_project/features/auth/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show NavigatorState;

enum AuthState { idel, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  AuthState state = AuthState.idel;
  UserModel? user;
  String? errorMessage;

  Future<bool> login({required String email, required String password}) async {
    state = AuthState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      user = await authRepository.login(email: email, password: password);
      state = AuthState.success;
      notifyListeners();
      return true;
    } on Failure catch (e) {
      errorMessage = e.message;
      state = AuthState.error;
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception', ' ');
      state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout(NavigatorState navigator) async {
    state = AuthState.loading;
    notifyListeners();

    await authRepository.logout();
    state = AuthState.idel;
    user = null;
    notifyListeners();
    navigator.pushNamedAndRemoveUntil(AppRoutes.signin, (route) => false);
  }

  Future<void> refreshTokenIfNeeded() async {
    await authRepository.refreshTokenIfNeeded();
  }

  void reset() {
    state = AuthState.idel;
    errorMessage = null;
    notifyListeners();
  }
}
