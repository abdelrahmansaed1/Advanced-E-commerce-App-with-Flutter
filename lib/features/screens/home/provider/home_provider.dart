import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/features/screens/home/data/repositories/home_repository.dart';
import 'package:e_commerce_project/features/screens/home/model/home_model.dart';
import 'package:flutter/foundation.dart';

enum HomeState { idle, loading, success, error }

class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository;

  HomeProvider({required this.homeRepository});

  HomeState state = HomeState.idle;
  HomeModel? homeData;
  String? errorMessage;

  Future<void> loadDashboard() async {
    state = HomeState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      homeData = await homeRepository.getDashboard();
      state = HomeState.success;
    } on Failure catch (e) {
      errorMessage = e.message;
      state = HomeState.error;
    } catch (e) {
      errorMessage = e.toString();
      state = HomeState.error;
    }
    notifyListeners();
  }
}
