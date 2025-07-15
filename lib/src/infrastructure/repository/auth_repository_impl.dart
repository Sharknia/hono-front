import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/repository/auth_repository.dart';
import '../../domain/model/token.dart';

class AuthRepositoryImpl implements AuthRepository {
  final http.Client _client;
  final String _baseUrl = 'https://hono-be.furychick0.workers.dev';

  AuthRepositoryImpl({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<Token> login(String email, String password) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Token(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
      );
    } else {
      throw Exception('Failed to login');
    }
  }
}
