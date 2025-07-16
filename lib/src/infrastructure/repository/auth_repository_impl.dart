import 'dart:convert';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/domain/repository/auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  final http.Client client;
  final String baseUrl;

  AuthRepositoryImpl({required this.client, required this.baseUrl});

  @override
  Future<Token> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      debugPrint('Login Response Body: ${response.body}'); // 디버그 로그 추가
      try {
        return Token.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse token from login response: $e');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<bool> checkEmailAvailability(String email) async {
    final response = await client.post(
      Uri.parse('$baseUrl/users/check-email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 409) {
      return false;
    } else {
      throw Exception('Failed to check email availability');
    }
  }

  @override
  Future<bool> checkNicknameAvailability(String nickname) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users/check/nickname/$nickname'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['isAvailable'] ?? false;
    } else {
      throw Exception('Failed to check nickname availability');
    }
  }

  @override
  Future<void> signUp(
      {required String email,
      required String password,
      required String nickname}) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode({'email': email, 'password': password, 'nickname': nickname}),
    );

    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 409) {
      final data = jsonDecode(response.body);
      throw Exception(data['error'] ?? 'Failed to sign up');
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
