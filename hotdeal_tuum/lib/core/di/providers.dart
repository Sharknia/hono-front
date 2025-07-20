import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';

// This file will contain all the Riverpod providers for dependency injection.

/// Provider for the token storage service.
final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) {
  return TokenStorageService();
});

// Example:
// final myServiceProvider = Provider<MyService>((ref) {
//   return MyService();
// });
