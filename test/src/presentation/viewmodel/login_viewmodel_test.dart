import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/application/usecase/login_usecase.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/infrastructure/service/token_storage_service.dart';
import 'package:hotdeal_with_hono/src/presentation/state/login_state.dart';
import 'package:hotdeal_with_hono/src/presentation/viewmodel/login_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_viewmodel_test.mocks.dart';

@GenerateMocks([LoginUseCase, TokenStorageService])
void main() {
  late LoginViewModel loginViewModel;
  late MockLoginUseCase mockLoginUseCase;
  late MockTokenStorageService mockTokenStorageService;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockTokenStorageService = MockTokenStorageService();
    loginViewModel = LoginViewModel(mockLoginUseCase, mockTokenStorageService);
  });

  test('초기 상태는 LoginState.initial() 이어야 한다', () {
    expect(loginViewModel.debugState, const LoginState.initial());
  });

  group('login', () {
    const testEmail = 'test@test.com';
    const testPassword = 'password';
    final testToken =
        Token(accessToken: 'test_token', refreshToken: 'refresh_token');

    test('로그인 성공 시, 상태는 LoginState.success(token)가 되어야 한다', () async {
      // Arrange
      when(mockLoginUseCase.call(testEmail, testPassword))
          .thenAnswer((_) async => testToken);
      when(mockTokenStorageService.saveTokens(
              accessToken: anyNamed('accessToken'),
              refreshToken: anyNamed('refreshToken')))
          .thenAnswer((_) async {});

      // Act
      final future = loginViewModel.login(testEmail, testPassword);

      // Assert
      expect(loginViewModel.debugState, const LoginState.loading());
      await future;
      expect(loginViewModel.debugState, LoginState.success(testToken));
      verify(mockTokenStorageService.saveTokens(
        accessToken: testToken.accessToken,
        refreshToken: testToken.refreshToken,
      )).called(1);
    });

    test('로그인 실패 시, 상태는 LoginState.error(message)가 되어야 한다', () async {
      // Arrange
      final exception = Exception('Failed to login');
      when(mockLoginUseCase.call(testEmail, testPassword))
          .thenThrow(exception);

      // Act
      final future = loginViewModel.login(testEmail, testPassword);

      // Assert
      expect(loginViewModel.debugState, const LoginState.loading());
      await future;
      expect(loginViewModel.debugState, LoginState.error(exception.toString()));
    });
  });
}

