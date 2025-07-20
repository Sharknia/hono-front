import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/data/api/api_client.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_client_test.mocks.dart';

@GenerateMocks([TokenStorageService])
void main() {
  group('ApiClient', () {
    late ApiClient apiClient;
    late MockTokenStorageService mockTokenStorageService;

    setUpAll(() async {
      dotenv.testLoad(fileInput: 'BASE_URL=https://api.test.com');
    });

    setUp(() {
      mockTokenStorageService = MockTokenStorageService();
      apiClient = ApiClient(mockTokenStorageService);
    });

    test('Dio instance should have correct base options', () {
      const expectedBaseUrl = 'https://api.test.com';
      const expectedTimeout = Duration(seconds: 30);

      final dio = apiClient.dio;
      final options = dio.options;

      expect(options.baseUrl, expectedBaseUrl);
      expect(options.connectTimeout, expectedTimeout);
      expect(options.receiveTimeout, expectedTimeout);
      expect(options.headers['Content-Type'], 'application/json');
    });
  });
}
