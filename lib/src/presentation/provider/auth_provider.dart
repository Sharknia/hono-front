import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/application/usecase/check_nickname_usecase.dart';
import 'package:hotdeal_with_hono/src/application/usecase/login_usecase.dart';
import 'package:hotdeal_with_hono/src/application/usecase/sign_up_usecase.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/infrastructure/repository/auth_repository_impl.dart';
import 'package:hotdeal_with_hono/src/infrastructure/service/token_storage_service.dart';
import 'package:hotdeal_with_hono/src/presentation/state/login_state.dart';
import 'package:hotdeal_with_hono/src/presentation/state/sign_up_state.dart';
import 'package:hotdeal_with_hono/src/presentation/viewmodel/login_viewmodel.dart';
import 'package:hotdeal_with_hono/src/presentation/viewmodel/sign_up_viewmodel.dart';
import 'package:http/http.dart' as http;

// Infrastructure
final authRepositoryProvider = Provider((ref) {
  final config = ref.watch(appConfigProvider);
  return AuthRepositoryImpl(client: http.Client(), baseUrl: config.baseUrl);
});

// Application
final loginUseCaseProvider = Provider(
  (ref) => LoginUseCase(ref.watch(authRepositoryProvider)),
);
final signUpUseCaseProvider = Provider(
  (ref) => SignUpUseCase(ref.watch(authRepositoryProvider)),
);
final checkNicknameUseCaseProvider = Provider(
  (ref) => CheckNicknameUseCase(ref.watch(authRepositoryProvider)),
);

// Presentation
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return LoginViewModel(loginUseCase, TokenStorageService());
});

final signUpViewModelProvider =
    StateNotifierProvider<SignUpViewModel, SignUpState>((ref) {
  final signUpUseCase = ref.watch(signUpUseCaseProvider);
  return SignUpViewModel(
    ref.watch(signUpUseCaseProvider),
    ref.watch(checkNicknameUseCaseProvider),
  );
});
