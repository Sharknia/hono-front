import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConfig {
  final String baseUrl;

  AppConfig({required this.baseUrl});
}

final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError(
      'appConfigProvider must be overridden in ProviderScope');
});
