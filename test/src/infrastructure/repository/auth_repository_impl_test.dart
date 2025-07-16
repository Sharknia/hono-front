import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/infrastructure/repository/auth_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthRepositoryImpl authRepository;
  late MockClient mockClient;
  final baseUrl = 'https://hono-be.furychick0.workers.dev/api';

  setUp(() {
    mockClient = MockClient();
    authRepository = AuthRepositoryImpl(client: mockClient, baseUrl: baseUrl);
  });

  group('login', () {
    const email = 'test@example.com';
    const password = 'password';
    final uri = Uri.parse('$baseUrl/auth/login');

    test('로그인 성공 시 Token 객체를 반환해야 한다', () async {
      // Arrange
      when(mockClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
          '{"accessToken": "test_access_token", "refreshToken": "test_refresh_token"}',
          200));

      // Act
      final result = await authRepository.login(email, password);

      // Assert
      expect(result, isA<Token>());
      expect(result.accessToken, 'test_access_token');
    });

    test('로그인 실패 (401) 시 Exception을 던져야 한다', () async {
      // Arrange
      when(mockClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act & Assert
      expect(() => authRepository.login(email, password), throwsException);
    });
  });

  group('checkNicknameAvailability', () {
    const nickname = 'testnick';
    final uri = Uri.parse('$baseUrl/users/check/nickname/$nickname');

    test('닉네임 사용 가능 시 true를 반환해야 한다', () async {
      // Arrange
      when(mockClient.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('{"isAvailable":true}', 200));

      // Act
      final result = await authRepository.checkNicknameAvailability(nickname);

      // Assert
      expect(result, isTrue);
    });

    test('닉네임 중복 시 false를 반환해야 한다', () async {
      // Arrange
      when(mockClient.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('{"isAvailable":false}', 200));

      // Act
      final result = await authRepository.checkNicknameAvailability(nickname);

      // Assert
      expect(result, isFalse);
    });
  });

  group('signUp', () {
    const email = 'newuser@example.com';
    const password = 'password';
    const nickname = 'newnick';
    final uri = Uri.parse('$baseUrl/auth/register');

    test('회원가입 성공 시 Token 객체를 반환해야 한다 (201)', () async {
      // Arrange
      when(mockClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, 'nickname': nickname}),
      )).thenAnswer((_) async => http.Response(
          '{"accessToken": "new_access_token", "refreshToken": "new_refresh_token"}',
          201));

      // Act
      final result = await authRepository.signUp(
          email: email, password: password, nickname: nickname);

      // Assert
      expect(result, isA<Token>());
      expect(result.accessToken, 'new_access_token');
    });

    test('회원가입 실패 (409) 시 Exception을 던져야 한다', () async {
      // Arrange
      when(mockClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, 'nickname': nickname}),
      )).thenAnswer((_) async => http.Response('Conflict', 409));

      // Act & Assert
      expect(
          () => authRepository.signUp(
              email: email, password: password, nickname: nickname),
          throwsException);
    });
  });

  group('checkEmailAvailability', () {
    const email = 'test@example.com';
    final uri = Uri.parse('$baseUrl/users/check-email');

    test('이메일 사용 가능 시 true를 반환해야 한다 (204)', () async {
      // Arrange
      when(mockClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      )).thenAnswer((_) async => http.Response('', 204));

      // Act
      final result = await authRepository.checkEmailAvailability(email);

      // Assert
      expect(result, isTrue);
    });

    test('이메일 중복 시 false를 반환해야 한다 (409)', () async {
      // Arrange
      when(mockClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      )).thenAnswer((_) async => http.Response('', 409));

      // Act
      final result = await authRepository.checkEmailAvailability(email);

      // Assert
      expect(result, isFalse);
    });
  });
}
