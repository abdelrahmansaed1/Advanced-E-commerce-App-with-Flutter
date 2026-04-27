import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/auth/data/repositories/auth_repository.dart';
import 'package:e_commerce_project/features/auth/data/model/user_model.dart';
import 'package:flutter/foundation.dart';

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

  void reset() {
    state = AuthState.idel;
    errorMessage = null;
    notifyListeners();
  }
}
