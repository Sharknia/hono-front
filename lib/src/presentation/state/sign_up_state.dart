import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotdeal_with_hono/src/domain/model/token.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    // Nickname check
    @Default(true) bool isNicknameAvailable,
    @Default(false) bool isCheckingNickname,
    @Default(false) bool isNicknameFixed,
    // Validation
    String? emailError,
    String? passwordError,
    String? nicknameError,
    // Form status
    @Default(false) bool isLoading,
    @Default(false) bool isSignUpSuccess,
    String? email,
    String? password,
    Token? token,
    String? error,
  }) = _SignUpState;

  const SignUpState._();

  bool get isFormValid =>
      emailError == null && passwordError == null && nicknameError == null && isNicknameFixed;
}
