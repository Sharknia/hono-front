import 'package:flutter_test/flutter_test.dart';
import '../../../../lib/src/application/usecase/login_usecase.dart';
import '../../../../lib/src/domain/model/token.dart';
import '../../../../lib/src/domain/repository/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
    final token = Token(accessToken: 'access', refreshToken: 'refresh');

    test('call 메소드는 AuthRepository.login을 호출해야 한다', () async {
      // Arrange
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) async => token);

      // Act
      await loginUseCase.call(email, password);

      // Assert
      verify(mockAuthRepository.login(email, password)).called(1);
    });

    test('유효하지 않은 이메일 형식일 경우 Exception을 던져야 한다', () {
      // Act & Assert
      expect(() => loginUseCase.call('invalid-email', password), throwsException);
    });
  });
}
