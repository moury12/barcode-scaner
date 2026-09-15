import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyUserRole = 'user_role';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  String? get accessToken => _prefs.getString(_keyAccessToken);
  String? get refreshToken => _prefs.getString(_keyRefreshToken);

  Future<bool> saveTokens(String accessToken, String refreshToken) async {
    await _prefs.setString(_keyAccessToken, accessToken);
    return await _prefs.setString(_keyRefreshToken, refreshToken);
  }

  Future<bool> clear() async {
    await _prefs.remove(_keyAccessToken);
    await _prefs.remove(_keyRefreshToken);
    await _prefs.remove(_keyUserRole);
    return true;
  }

  bool get isOnboardingCompleted => _prefs.getBool(_keyOnboardingCompleted) ?? false;

  Future<bool> setOnboardingCompleted(bool value) async {
    return await _prefs.setBool(_keyOnboardingCompleted, value);
  }

  String? get userRole => _prefs.getString(_keyUserRole);

  Future<bool> saveUserRole(String role) async {
    return await _prefs.setString(_keyUserRole, role);
  }
}

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('localStorageServiceProvider must be overridden in ProviderScope');
});
