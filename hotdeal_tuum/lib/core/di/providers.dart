import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_tuum/data/api/api_client.dart';
import 'package:hotdeal_tuum/data/api/services/auth_api.dart';
import 'package:hotdeal_tuum/data/api/services/user_api.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';
import 'package:hotdeal_tuum/domain/providers/auth/auth_notifier.dart';
import 'package:hotdeal_tuum/domain/providers/auth/auth_state.dart';
import 'package:hotdeal_tuum/domain/repositories/auth_repository.dart';
import 'package:hotdeal_tuum/domain/repositories/user_repository.dart';

// This file will contain all the Riverpod providers for dependency injection.

/// Provider for the token storage service.
final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) {
  return TokenStorageService();
});

/// Provider for the ApiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenService = ref.watch(tokenStorageServiceProvider);
  return ApiClient(tokenService);
});

/// Provider for the Dio instance from ApiClient
final dioProvider = Provider<Dio>((ref) {
  return ref.watch(apiClientProvider).dio;
});

/// Provider for the AuthApi service
final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  final tokenService = ref.watch(tokenStorageServiceProvider);
  return AuthApi(dio: dio, tokenStorageService: tokenService);
});

/// Provider for the UserApi service
final userApiProvider = Provider<UserApi>((ref) {
  final dio = ref.watch(dioProvider);
  return UserApi(dio: dio);
});

/// Provider for the AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authApi = ref.watch(authApiProvider);
  return AuthRepositoryImpl(authApi: authApi);
});

/// Provider for the UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userApi = ref.watch(userApiProvider);
  return UserRepositoryImpl(userApi: userApi);
});

/// Provider for the AuthNotifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository: authRepository);
});
