import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/data/api/services/auth_api.dart';
import 'package:hotdeal_tuum/domain/repositories/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthApi])
void main() {
  late MockAuthApi mockAuthApi;
  late AuthRepository authRepository;

  setUp(() {
    mockAuthApi = MockAuthApi();
    authRepository = AuthRepositoryImpl(authApi: mockAuthApi);
  });

  group('AuthRepository login', () {
    test('should call login on AuthApi', () async {
      // Arrange
      const email = 'test@test.com';
      const password = 'password';
      const rememberMe = true;
      when(mockAuthApi.login(email: email, password: password, rememberMe: rememberMe))
          .thenAnswer((_) async {});

      // Act
      await authRepository.login(email: email, password: password, rememberMe: rememberMe);

      // Assert
      verify(mockAuthApi.login(email: email, password: password, rememberMe: rememberMe)).called(1);
    });
  });
}
