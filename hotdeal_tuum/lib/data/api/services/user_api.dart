import 'package:dio/dio.dart';

class UserApi {
  final Dio dio;

  UserApi({required this.dio});

  Future<bool> checkNickname(String nickname) async {
    try {
      final response = await dio.get(
        '/user/check-nickname',
        queryParameters: {'nickname': nickname},
      );
      if (response.statusCode == 200) {
        return response.data['isAvailable'] ?? false;
      }
      return false;
    } catch (e) {
      // In a real app, you'd handle errors more gracefully
      return false;
    }
  }
}
