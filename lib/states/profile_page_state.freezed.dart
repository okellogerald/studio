// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProfilePageStateTearOff {
  const _$ProfilePageStateTearOff();

  _Loading loading(Map<String, dynamic> userData, {String? message}) {
    return _Loading(
      userData,
      message: message,
    );
  }

  _Content content(Map<String, dynamic> userData) {
    return _Content(
      userData,
    );
  }

  _Failed failed(Map<String, dynamic> userData, AppError error) {
    return _Failed(
      userData,
      error,
    );
  }

  _Success success(Map<String, dynamic> userData) {
    return _Success(
      userData,
    );
  }
}

/// @nodoc
const $ProfilePageState = _$ProfilePageStateTearOff();

/// @nodoc
mixin _$ProfilePageState {
  Map<String, dynamic> get userData => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> userData, String? message)
        loading,
    required TResult Function(Map<String, dynamic> userData) content,
    required TResult Function(Map<String, dynamic> userData, AppError error)
        failed,
    required TResult Function(Map<String, dynamic> userData) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfilePageStateCopyWith<ProfilePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfilePageStateCopyWith<$Res> {
  factory $ProfilePageStateCopyWith(
          ProfilePageState value, $Res Function(ProfilePageState) then) =
      _$ProfilePageStateCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> userData});
}

/// @nodoc
class _$ProfilePageStateCopyWithImpl<$Res>
    implements $ProfilePageStateCopyWith<$Res> {
  _$ProfilePageStateCopyWithImpl(this._value, this._then);

  final ProfilePageState _value;
  // ignore: unused_field
  final $Res Function(ProfilePageState) _then;

  @override
  $Res call({
    Object? userData = freezed,
  }) {
    return _then(_value.copyWith(
      userData: userData == freezed
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $ProfilePageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> userData, String? message});
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$ProfilePageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? userData = freezed,
    Object? message = freezed,
  }) {
    return _then(_Loading(
      userData == freezed
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.userData, {this.message});

  @override
  final Map<String, dynamic> userData;
  @override
  final String? message;

  @override
  String toString() {
    return 'ProfilePageState.loading(userData: $userData, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality().equals(other.userData, userData) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userData),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> userData, String? message)
        loading,
    required TResult Function(Map<String, dynamic> userData) content,
    required TResult Function(Map<String, dynamic> userData, AppError error)
        failed,
    required TResult Function(Map<String, dynamic> userData) success,
  }) {
    return loading(userData, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
  }) {
    return loading?.call(userData, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(userData, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProfilePageState {
  const factory _Loading(Map<String, dynamic> userData, {String? message}) =
      _$_Loading;

  @override
  Map<String, dynamic> get userData;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $ProfilePageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> userData});
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$ProfilePageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? userData = freezed,
  }) {
    return _then(_Content(
      userData == freezed
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.userData);

  @override
  final Map<String, dynamic> userData;

  @override
  String toString() {
    return 'ProfilePageState.content(userData: $userData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            const DeepCollectionEquality().equals(other.userData, userData));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(userData));

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> userData, String? message)
        loading,
    required TResult Function(Map<String, dynamic> userData) content,
    required TResult Function(Map<String, dynamic> userData, AppError error)
        failed,
    required TResult Function(Map<String, dynamic> userData) success,
  }) {
    return content(userData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
  }) {
    return content?.call(userData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(userData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements ProfilePageState {
  const factory _Content(Map<String, dynamic> userData) = _$_Content;

  @override
  Map<String, dynamic> get userData;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $ProfilePageStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> userData, AppError error});
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> extends _$ProfilePageStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? userData = freezed,
    Object? error = freezed,
  }) {
    return _then(_Failed(
      userData == freezed
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppError,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.userData, this.error);

  @override
  final Map<String, dynamic> userData;
  @override
  final AppError error;

  @override
  String toString() {
    return 'ProfilePageState.failed(userData: $userData, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            const DeepCollectionEquality().equals(other.userData, userData) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userData),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> userData, String? message)
        loading,
    required TResult Function(Map<String, dynamic> userData) content,
    required TResult Function(Map<String, dynamic> userData, AppError error)
        failed,
    required TResult Function(Map<String, dynamic> userData) success,
  }) {
    return failed(userData, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
  }) {
    return failed?.call(userData, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(userData, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements ProfilePageState {
  const factory _Failed(Map<String, dynamic> userData, AppError error) =
      _$_Failed;

  @override
  Map<String, dynamic> get userData;
  AppError get error;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res>
    implements $ProfilePageStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic> userData});
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> extends _$ProfilePageStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object? userData = freezed,
  }) {
    return _then(_Success(
      userData == freezed
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(this.userData);

  @override
  final Map<String, dynamic> userData;

  @override
  String toString() {
    return 'ProfilePageState.success(userData: $userData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            const DeepCollectionEquality().equals(other.userData, userData));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(userData));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> userData, String? message)
        loading,
    required TResult Function(Map<String, dynamic> userData) content,
    required TResult Function(Map<String, dynamic> userData, AppError error)
        failed,
    required TResult Function(Map<String, dynamic> userData) success,
  }) {
    return success(userData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
  }) {
    return success?.call(userData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> userData, String? message)? loading,
    TResult Function(Map<String, dynamic> userData)? content,
    TResult Function(Map<String, dynamic> userData, AppError error)? failed,
    TResult Function(Map<String, dynamic> userData)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(userData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ProfilePageState {
  const factory _Success(Map<String, dynamic> userData) = _$_Success;

  @override
  Map<String, dynamic> get userData;
  @override
  @JsonKey(ignore: true)
  _$SuccessCopyWith<_Success> get copyWith =>
      throw _privateConstructorUsedError;
}
