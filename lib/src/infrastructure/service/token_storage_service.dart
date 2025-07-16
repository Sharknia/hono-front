import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) {
  // This is okay for the app, but for tests we will override this.
  return TokenStorageService(
    secureStorage: const FlutterSecureStorage(),
    sharedPreferences: SharedPreferences.getInstance(),
  );
});

class TokenStorageService {
  final FlutterSecureStorage _secureStorage;
  final Future<SharedPreferences> _sharedPreferences;

  TokenStorageService({
    required FlutterSecureStorage secureStorage,
    required Future<SharedPreferences> sharedPreferences,
  })  : _secureStorage = secureStorage,
        _sharedPreferences = sharedPreferences;

  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    if (kIsWeb) {
      final prefs = await _sharedPreferences;
      await prefs.setString(_accessTokenKey, accessToken);
      await prefs.setString(_refreshTokenKey, refreshToken);
    } else {
      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  Future<String?> getAccessToken() async {
    if (kIsWeb) {
      final prefs = await _sharedPreferences;
      return prefs.getString(_accessTokenKey);
    } else {
      return await _secureStorage.read(key: _accessTokenKey);
    }
  }

  Future<void> deleteAllTokens() async {
    if (kIsWeb) {
      final prefs = await _sharedPreferences;
      await prefs.remove(_accessTokenKey);
      await prefs.remove(_refreshTokenKey);
    } else {
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
    }
  }
}
