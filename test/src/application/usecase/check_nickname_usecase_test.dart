import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/application/usecase/check_nickname_usecase.dart';
import 'package:hotdeal_with_hono/src/domain/repository/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_nickname_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late CheckNicknameUseCase checkNicknameUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    checkNicknameUseCase = CheckNicknameUseCase(mockAuthRepository);
  });

  test('should call checkNicknameAvailability from the repository', () async {
    // Arrange
    const nickname = 'testnick';
    when(mockAuthRepository.checkNicknameAvailability(nickname))
        .thenAnswer((_) async => true);

    // Act
    await checkNicknameUseCase.call(nickname);

    // Assert
    verify(mockAuthRepository.checkNicknameAvailability(nickname)).called(1);
  });
}
