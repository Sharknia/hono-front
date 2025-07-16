import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/application/usecase/login_usecase.dart';
import 'package:hotdeal_with_hono/src/infrastructure/repository/auth_repository_impl.dart';
import 'package:hotdeal_with_hono/src/presentation/state/login_state.dart';
import 'package:hotdeal_with_hono/src/presentation/viewmodel/login_viewmodel.dart';
import 'package:http/http.dart' as http;

// Infrastructure
final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryImpl(client: http.Client()),
);

// Application
final loginUseCaseProvider = Provider(
  (ref) => LoginUseCase(ref.watch(authRepositoryProvider)),
);

// Presentation
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(ref.watch(loginUseCaseProvider));
});
