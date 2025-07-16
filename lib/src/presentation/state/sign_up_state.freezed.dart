// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpState {

// Nickname check
 bool get isNicknameAvailable; bool get isCheckingNickname; bool get isNicknameFixed;// Validation
 String? get emailError; String? get passwordError; String? get nicknameError;// Form status
 bool get isLoading; bool get isSignUpSuccess; Token? get token; String? get error;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.isNicknameAvailable, isNicknameAvailable) || other.isNicknameAvailable == isNicknameAvailable)&&(identical(other.isCheckingNickname, isCheckingNickname) || other.isCheckingNickname == isCheckingNickname)&&(identical(other.isNicknameFixed, isNicknameFixed) || other.isNicknameFixed == isNicknameFixed)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.nicknameError, nicknameError) || other.nicknameError == nicknameError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSignUpSuccess, isSignUpSuccess) || other.isSignUpSuccess == isSignUpSuccess)&&(identical(other.token, token) || other.token == token)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isNicknameAvailable,isCheckingNickname,isNicknameFixed,emailError,passwordError,nicknameError,isLoading,isSignUpSuccess,token,error);

@override
String toString() {
  return 'SignUpState(isNicknameAvailable: $isNicknameAvailable, isCheckingNickname: $isCheckingNickname, isNicknameFixed: $isNicknameFixed, emailError: $emailError, passwordError: $passwordError, nicknameError: $nicknameError, isLoading: $isLoading, isSignUpSuccess: $isSignUpSuccess, token: $token, error: $error)';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 bool isNicknameAvailable, bool isCheckingNickname, bool isNicknameFixed, String? emailError, String? passwordError, String? nicknameError, bool isLoading, bool isSignUpSuccess, Token? token, String? error
});


$TokenCopyWith<$Res>? get token;

}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isNicknameAvailable = null,Object? isCheckingNickname = null,Object? isNicknameFixed = null,Object? emailError = freezed,Object? passwordError = freezed,Object? nicknameError = freezed,Object? isLoading = null,Object? isSignUpSuccess = null,Object? token = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isNicknameAvailable: null == isNicknameAvailable ? _self.isNicknameAvailable : isNicknameAvailable // ignore: cast_nullable_to_non_nullable
as bool,isCheckingNickname: null == isCheckingNickname ? _self.isCheckingNickname : isCheckingNickname // ignore: cast_nullable_to_non_nullable
as bool,isNicknameFixed: null == isNicknameFixed ? _self.isNicknameFixed : isNicknameFixed // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,nicknameError: freezed == nicknameError ? _self.nicknameError : nicknameError // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSignUpSuccess: null == isSignUpSuccess ? _self.isSignUpSuccess : isSignUpSuccess // ignore: cast_nullable_to_non_nullable
as bool,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as Token?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenCopyWith<$Res>? get token {
    if (_self.token == null) {
    return null;
  }

  return $TokenCopyWith<$Res>(_self.token!, (value) {
    return _then(_self.copyWith(token: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isNicknameAvailable,  bool isCheckingNickname,  bool isNicknameFixed,  String? emailError,  String? passwordError,  String? nicknameError,  bool isLoading,  bool isSignUpSuccess,  Token? token,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.isNicknameAvailable,_that.isCheckingNickname,_that.isNicknameFixed,_that.emailError,_that.passwordError,_that.nicknameError,_that.isLoading,_that.isSignUpSuccess,_that.token,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isNicknameAvailable,  bool isCheckingNickname,  bool isNicknameFixed,  String? emailError,  String? passwordError,  String? nicknameError,  bool isLoading,  bool isSignUpSuccess,  Token? token,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.isNicknameAvailable,_that.isCheckingNickname,_that.isNicknameFixed,_that.emailError,_that.passwordError,_that.nicknameError,_that.isLoading,_that.isSignUpSuccess,_that.token,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isNicknameAvailable,  bool isCheckingNickname,  bool isNicknameFixed,  String? emailError,  String? passwordError,  String? nicknameError,  bool isLoading,  bool isSignUpSuccess,  Token? token,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.isNicknameAvailable,_that.isCheckingNickname,_that.isNicknameFixed,_that.emailError,_that.passwordError,_that.nicknameError,_that.isLoading,_that.isSignUpSuccess,_that.token,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState extends SignUpState {
  const _SignUpState({this.isNicknameAvailable = true, this.isCheckingNickname = false, this.isNicknameFixed = false, this.emailError, this.passwordError, this.nicknameError, this.isLoading = false, this.isSignUpSuccess = false, this.token, this.error}): super._();
  

// Nickname check
@override@JsonKey() final  bool isNicknameAvailable;
@override@JsonKey() final  bool isCheckingNickname;
@override@JsonKey() final  bool isNicknameFixed;
// Validation
@override final  String? emailError;
@override final  String? passwordError;
@override final  String? nicknameError;
// Form status
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSignUpSuccess;
@override final  Token? token;
@override final  String? error;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.isNicknameAvailable, isNicknameAvailable) || other.isNicknameAvailable == isNicknameAvailable)&&(identical(other.isCheckingNickname, isCheckingNickname) || other.isCheckingNickname == isCheckingNickname)&&(identical(other.isNicknameFixed, isNicknameFixed) || other.isNicknameFixed == isNicknameFixed)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.nicknameError, nicknameError) || other.nicknameError == nicknameError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSignUpSuccess, isSignUpSuccess) || other.isSignUpSuccess == isSignUpSuccess)&&(identical(other.token, token) || other.token == token)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isNicknameAvailable,isCheckingNickname,isNicknameFixed,emailError,passwordError,nicknameError,isLoading,isSignUpSuccess,token,error);

@override
String toString() {
  return 'SignUpState(isNicknameAvailable: $isNicknameAvailable, isCheckingNickname: $isCheckingNickname, isNicknameFixed: $isNicknameFixed, emailError: $emailError, passwordError: $passwordError, nicknameError: $nicknameError, isLoading: $isLoading, isSignUpSuccess: $isSignUpSuccess, token: $token, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 bool isNicknameAvailable, bool isCheckingNickname, bool isNicknameFixed, String? emailError, String? passwordError, String? nicknameError, bool isLoading, bool isSignUpSuccess, Token? token, String? error
});


@override $TokenCopyWith<$Res>? get token;

}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isNicknameAvailable = null,Object? isCheckingNickname = null,Object? isNicknameFixed = null,Object? emailError = freezed,Object? passwordError = freezed,Object? nicknameError = freezed,Object? isLoading = null,Object? isSignUpSuccess = null,Object? token = freezed,Object? error = freezed,}) {
  return _then(_SignUpState(
isNicknameAvailable: null == isNicknameAvailable ? _self.isNicknameAvailable : isNicknameAvailable // ignore: cast_nullable_to_non_nullable
as bool,isCheckingNickname: null == isCheckingNickname ? _self.isCheckingNickname : isCheckingNickname // ignore: cast_nullable_to_non_nullable
as bool,isNicknameFixed: null == isNicknameFixed ? _self.isNicknameFixed : isNicknameFixed // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,nicknameError: freezed == nicknameError ? _self.nicknameError : nicknameError // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSignUpSuccess: null == isSignUpSuccess ? _self.isSignUpSuccess : isSignUpSuccess // ignore: cast_nullable_to_non_nullable
as bool,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as Token?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenCopyWith<$Res>? get token {
    if (_self.token == null) {
    return null;
  }

  return $TokenCopyWith<$Res>(_self.token!, (value) {
    return _then(_self.copyWith(token: value));
  });
}
}

// dart format on
