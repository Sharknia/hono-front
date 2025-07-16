import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(true) bool isNicknameAvailable,
    @Default(false) bool isCheckingNickname,
    @Default(false) bool isLoading,
    Token? token,
    String? error,
  }) = _SignUpState;
}
