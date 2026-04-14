import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static SharedPreferences? _pref;

  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static const _isLoggedInKey = 'isLoggedIn';
  static const _isFirstTimeKey = 'isFirstTime';

  Future<bool> isFirstTime() async {
    return _pref?.getBool(_isFirstTimeKey) ?? true;
  }

  Future<void> completeOnboarding() async {
    await _pref?.setBool(_isFirstTimeKey, false);
  }

  Future<void> login() async {
    await _pref?.setBool(_isLoggedInKey, true);
  }

  Future<void> logout() async {
    await _pref?.setBool(_isLoggedInKey, false);
  }

  Future<bool> isLoggedIn() async {
    return _pref?.getBool(_isLoggedInKey) ?? false;
  }
}
