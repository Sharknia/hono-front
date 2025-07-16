import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hotdeal_with_hono/src/application/usecase/login_usecase.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/presentation/state/login_state.dart';
import 'package:hotdeal_with_hono/src/presentation/viewmodel/login_viewmodel.dart';

import 'login_viewmodel_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late LoginViewModel loginViewModel;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginViewModel = LoginViewModel(mockLoginUseCase);
  });

  group('LoginViewModel', () {
    const email = 'test@example.com';
    const password = 'password';
    final token = Token(
      accessToken: 'test_access_token',
      refreshToken: 'test_refresh_token',
    );
    final exception = Exception('Failed to login');

    test('초기 상태는 LoginState.initial 이어야 한다', () {
      expect(loginViewModel.state, const LoginState.initial());
    });

    test('로그인 성공 시 상태가 loading -> success 순으로 변경되어야 한다', () async {
      // Arrange
      when(mockLoginUseCase.call(email, password))
          .thenAnswer((_) async => token);

      // Act
      final future = loginViewModel.login(email, password);

      // Assert
      expect(loginViewModel.state, const LoginState.loading());
      await future;
      expect(loginViewModel.state, LoginState.success(token));
    });

    test('로그인 실패 시 상태가 loading -> error 순으로 변경되어야 한다', () async {
      // Arrange
      when(mockLoginUseCase.call(email, password)).thenThrow(exception);

      // Act
      final future = loginViewModel.login(email, password);

      // Assert
      expect(loginViewModel.state, const LoginState.loading());
      await future;
      expect(loginViewModel.state, LoginState.error(exception.toString()));
    });
  });
}
