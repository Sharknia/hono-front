import 'package:flutter_test/flutter_test.dart';
import '../../../../lib/src/domain/model/token.dart';
import '../../../../lib/src/infrastructure/repository/auth_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthRepositoryImpl authRepository;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    authRepository = AuthRepositoryImpl(client: mockClient);
  });

  group('login', () {
    const email = 'test@example.com';
    const password = 'password';
    final uri = Uri.parse('https://hono-be.furychick0.workers.dev/api/auth/login');

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
}
