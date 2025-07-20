import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_tuum/data/api/api_client.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';

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
