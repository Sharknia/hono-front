import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/core/di/providers.dart';
import 'package:hotdeal_tuum/domain/providers/auth/auth_notifier.dart';
import 'package:hotdeal_tuum/domain/providers/auth/auth_state.dart';
import 'package:hotdeal_tuum/domain/repositories/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_notifier_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthNotifier authNotifier;
  late List<AuthState> states;
  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    states = [];
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
    );
    container.listen<AuthState>(
      authNotifierProvider,
      (previous, next) => states.add(next),
      fireImmediately: true,
    );
    authNotifier = container.read(authNotifierProvider.notifier);
  });

  group('AuthNotifier login', () {
    test('should transition state to loading then authenticated on success', () async {
      // Arrange
      const email = 'test@test.com';
      const password = 'password';
      const rememberMe = true;
      when(mockAuthRepository.login(email: email, password: password, rememberMe: rememberMe))
          .thenAnswer((_) async {});

      // Act
      await authNotifier.login(email: email, password: password, rememberMe: rememberMe);

      // Assert
      expect(states, [
        const AuthState.initial(),
        const AuthState.loading(),
        const AuthState.authenticated(),
      ]);
      verify(mockAuthRepository.login(email: email, password: password, rememberMe: rememberMe)).called(1);
    });
  });
}
