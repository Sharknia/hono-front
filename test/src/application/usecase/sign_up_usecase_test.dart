import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/application/usecase/sign_up_usecase.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/domain/repository/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUpUseCase signUpUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(mockAuthRepository);
  });

  const email = 'test@example.com';
  const password = 'password';
  const nickname = 'testnick';
  final token = const Token(
    accessToken: 'test_access_token',
    refreshToken: 'test_refresh_token',
  );

  test('should complete successfully on valid sign up', () async {
    // Arrange
    when(mockAuthRepository.signUp(
      email: email,
      password: password,
      nickname: nickname,
    )).thenAnswer((_) async => {});

    // Act
    final call = signUpUseCase.call(
      email: email,
      password: password,
      passwordCheck: password,
      nickname: nickname,
    );

    // Assert
    await expectLater(call, completes);
    verify(mockAuthRepository.signUp(
      email: email,
      password: password,
      nickname: nickname,
    )).called(1);
  });

  test('should throw an error if passwords do not match', () {
    // Assert
    expect(
      () => signUpUseCase.call(
        email: email,
        password: password,
        passwordCheck: 'wrongpassword',
        nickname: nickname,
      ),
      throwsArgumentError,
    );
  });

  test('should throw an error if email is empty', () {
    // Assert
    expect(
      () => signUpUseCase.call(
        email: '',
        password: password,
        passwordCheck: password,
        nickname: nickname,
      ),
      throwsArgumentError,
    );
  });
}
