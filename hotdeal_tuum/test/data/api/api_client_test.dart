import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/data/api/api_client.dart';

void main() {
  group('ApiClient', () {
    late ApiClient apiClient;

    setUpAll(() async {
      // Load a mock .env file for tests
      dotenv.testLoad(fileInput: 'BASE_URL=https://api.test.com');
    });

    setUp(() {
      apiClient = ApiClient();
    });

    test('Dio instance should have correct base options', () {
      // Arrange
      const expectedBaseUrl = 'https://api.test.com';
      const expectedTimeout = Duration(seconds: 30);

      // Act
      final dio = apiClient.dio;
      final options = dio.options;

      // Assert
      expect(options.baseUrl, expectedBaseUrl);
      expect(options.connectTimeout, expectedTimeout);
      expect(options.receiveTimeout, expectedTimeout);
      expect(options.headers['Content-Type'], 'application/json');
    });
  });
}
