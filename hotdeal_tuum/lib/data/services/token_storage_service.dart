import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // In-memory storage for session-only tokens
  String? _sessionAccessToken;
  String? _sessionRefreshToken;
  bool _isRememberMe = false;

  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _rememberMeKey = 'rememberMe';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required bool rememberMe,
  }) async {
    _isRememberMe = rememberMe;
    await _secureStorage.write(key: _rememberMeKey, value: rememberMe.toString());

    if (rememberMe) {
      await _secureStorage.write(key: _accessTokenKey, value: accessToken);
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
      _clearSessionTokens();
    } else {
      _sessionAccessToken = accessToken;
      _sessionRefreshToken = refreshToken;
      await _clearPersistentTokens();
    }
  }

  Future<String?> getAccessToken() async {
    if (_isRememberMe) {
      return await _secureStorage.read(key: _accessTokenKey);
    }
    return _sessionAccessToken;
  }

  Future<String?> getRefreshToken() async {
    if (_isRememberMe) {
      return await _secureStorage.read(key: _refreshTokenKey);
    }
    return _sessionRefreshToken;
  }

  Future<bool> isRememberMeEnabled() async {
    final rememberMeValue = await _secureStorage.read(key: _rememberMeKey);
    _isRememberMe = rememberMeValue == 'true';
    return _isRememberMe;
  }

  Future<void> clearTokens() async {
    await _clearPersistentTokens();
    _clearSessionTokens();
  }

  Future<void> _clearPersistentTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _secureStorage.delete(key: _rememberMeKey);
  }

  void _clearSessionTokens() {
    _sessionAccessToken = null;
    _sessionRefreshToken = null;
  }
}
