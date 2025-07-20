import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/data/api/services/user_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late UserApi userApi;

  setUp(() {
    mockDio = MockDio();
    userApi = UserApi(dio: mockDio);
  });

  group('UserApi checkNickname', () {
    test('should call checkNickname endpoint and return true for success', () async {
      // Arrange
      const nickname = 'test_nickname';
      when(mockDio.get('/users/check/nickname/$nickname')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/users/check/nickname/$nickname'),
            statusCode: 200,
            data: {'isAvailable': true},
          ));

      // Act
      final isAvailable = await userApi.checkNickname(nickname);

      // Assert
      expect(isAvailable, isTrue);
      verify(mockDio.get('/users/check/nickname/$nickname')).called(1);
    });
  });
}
