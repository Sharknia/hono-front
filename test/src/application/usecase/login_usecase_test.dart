import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotdeal_with_hono/src/application/usecase/login_usecase.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/domain/repository/auth_repository.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  group('LoginUseCase', () {
    const email = 'test@example.com';
    const password = 'password';
    final token = Token(
      accessToken: 'test_access_token',
      refreshToken: 'test_refresh_token',
    );

    test('call should return a Token on successful login', () async {
      // Arrange
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) async => token);

      // Act
      final result = await loginUseCase.call(email, password);

      // Assert
      expect(result, token);
      verify(mockAuthRepository.login(email, password)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}