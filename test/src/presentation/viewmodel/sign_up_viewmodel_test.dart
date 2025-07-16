import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/application/usecase/check_nickname_usecase.dart';
import 'package:hotdeal_with_hono/src/application/usecase/sign_up_usecase.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/presentation/state/sign_up_state.dart';
import 'package:hotdeal_with_hono/src/presentation/viewmodel/sign_up_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_viewmodel_test.mocks.dart';

@GenerateMocks([SignUpUseCase, CheckNicknameUseCase])
void main() {
  late SignUpViewModel signUpViewModel;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockCheckNicknameUseCase mockCheckNicknameUseCase;

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    mockCheckNicknameUseCase = MockCheckNicknameUseCase();
    signUpViewModel = SignUpViewModel(mockSignUpUseCase, mockCheckNicknameUseCase);
  });

  group('Validation', () {
    test('validateEmail sets error for invalid email', () {
      signUpViewModel.validateEmail('invalid');
      expect(signUpViewModel.debugState.emailError, 'Invalid email format');
    });

    test('validatePassword sets error for non-matching passwords', () {
      signUpViewModel.validatePassword('pass1', 'pass2');
      expect(signUpViewModel.debugState.passwordError, 'Passwords do not match');
    });
  });

  group('checkNickname', () {
    test('sets isNicknameFixed to true when nickname is available', () async {
      // Arrange
      when(mockCheckNicknameUseCase.call('newnick')).thenAnswer((_) async => true);

      // Act
      await signUpViewModel.checkNickname('newnick');

      // Assert
      expect(signUpViewModel.debugState.isNicknameAvailable, true);
      expect(signUpViewModel.debugState.isNicknameFixed, true);
    });
  });

  group('signUp', () {
    const email = 'test@example.com';
    const password = 'password';
    const nickname = 'testnick';
    final token = const Token(
        accessToken: 'test_access_token', refreshToken: 'test_refresh_token');

    test('updates state correctly on success', () async {
      // Arrange
      when(mockSignUpUseCase.call(
        email: email,
        password: password,
        passwordCheck: password,
        nickname: nickname,
      )).thenAnswer((_) async => token);

      // Act
      final future = signUpViewModel.signUp(
        email: email,
        password: password,
        passwordCheck: password,
        nickname: nickname,
      );

      // Assert
      expect(signUpViewModel.debugState.isLoading, true);
      await future;
      expect(signUpViewModel.debugState.token, token);
      expect(signUpViewModel.debugState.isSignUpSuccess, true);
      expect(signUpViewModel.debugState.isLoading, false);
    });
  });
}
