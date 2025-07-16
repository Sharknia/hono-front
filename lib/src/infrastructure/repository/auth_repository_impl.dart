import 'dart:convert';

import 'dart:convert';

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
      return Token.fromJson(jsonDecode(response.body));
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
    final response = await client.post(
      Uri.parse('$baseUrl/users/check-nickname'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nickname': nickname}),
    );

    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 409) {
      return false;
    } else {
      throw Exception('Failed to check nickname availability');
    }
  }

  @override
  Future<Token> signUp(
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
      return Token.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
