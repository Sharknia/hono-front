import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/data/api/services/user_api.dart';
import 'package:hotdeal_tuum/domain/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserApi])
void main() {
  late MockUserApi mockUserApi;
  late UserRepository userRepository;

  setUp(() {
    mockUserApi = MockUserApi();
    userRepository = UserRepositoryImpl(userApi: mockUserApi);
  });

  group('UserRepository checkNickname', () {
    test('should call checkNickname on UserApi and return the result', () async {
      // Arrange
      const nickname = 'test_nickname';
      when(mockUserApi.checkNickname(nickname)).thenAnswer((_) async => true);

      // Act
      final result = await userRepository.checkNickname(nickname);

      // Assert
      expect(result, isTrue);
      verify(mockUserApi.checkNickname(nickname)).called(1);
    });
  });
}
