// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'topic_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TopicPageStateTearOff {
  const _$TopicPageStateTearOff();

  _Loading loading(TopicPageSupplements supplements, {String? message}) {
    return _Loading(
      supplements,
      message: message,
    );
  }

  _Content content(TopicPageSupplements supplements) {
    return _Content(
      supplements,
    );
  }

  _Failed failed(TopicPageSupplements supplements, AppError error) {
    return _Failed(
      supplements,
      error,
    );
  }
}

/// @nodoc
const $TopicPageState = _$TopicPageStateTearOff();

/// @nodoc
mixin _$TopicPageState {
  TopicPageSupplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TopicPageSupplements supplements, String? message)
        loading,
    required TResult Function(TopicPageSupplements supplements) content,
    required TResult Function(TopicPageSupplements supplements, AppError error)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopicPageStateCopyWith<TopicPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicPageStateCopyWith<$Res> {
  factory $TopicPageStateCopyWith(
          TopicPageState value, $Res Function(TopicPageState) then) =
      _$TopicPageStateCopyWithImpl<$Res>;
  $Res call({TopicPageSupplements supplements});

  $TopicPageSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$TopicPageStateCopyWithImpl<$Res>
    implements $TopicPageStateCopyWith<$Res> {
  _$TopicPageStateCopyWithImpl(this._value, this._then);

  final TopicPageState _value;
  // ignore: unused_field
  final $Res Function(TopicPageState) _then;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as TopicPageSupplements,
    ));
  }

  @override
  $TopicPageSupplementsCopyWith<$Res> get supplements {
    return $TopicPageSupplementsCopyWith<$Res>(_value.supplements, (value) {
      return _then(_value.copyWith(supplements: value));
    });
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $TopicPageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({TopicPageSupplements supplements, String? message});

  @override
  $TopicPageSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$TopicPageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? supplements = freezed,
    Object? message = freezed,
  }) {
    return _then(_Loading(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as TopicPageSupplements,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.supplements, {this.message});

  @override
  final TopicPageSupplements supplements;
  @override
  final String? message;

  @override
  String toString() {
    return 'TopicPageState.loading(supplements: $supplements, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(supplements),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TopicPageSupplements supplements, String? message)
        loading,
    required TResult Function(TopicPageSupplements supplements) content,
    required TResult Function(TopicPageSupplements supplements, AppError error)
        failed,
  }) {
    return loading(supplements, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
  }) {
    return loading?.call(supplements, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(supplements, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements TopicPageState {
  const factory _Loading(TopicPageSupplements supplements, {String? message}) =
      _$_Loading;

  @override
  TopicPageSupplements get supplements;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $TopicPageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({TopicPageSupplements supplements});

  @override
  $TopicPageSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$TopicPageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as TopicPageSupplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.supplements);

  @override
  final TopicPageSupplements supplements;

  @override
  String toString() {
    return 'TopicPageState.content(supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TopicPageSupplements supplements, String? message)
        loading,
    required TResult Function(TopicPageSupplements supplements) content,
    required TResult Function(TopicPageSupplements supplements, AppError error)
        failed,
  }) {
    return content(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
  }) {
    return content?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements TopicPageState {
  const factory _Content(TopicPageSupplements supplements) = _$_Content;

  @override
  TopicPageSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res> implements $TopicPageStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call({TopicPageSupplements supplements, AppError error});

  @override
  $TopicPageSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> extends _$TopicPageStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? supplements = freezed,
    Object? error = freezed,
  }) {
    return _then(_Failed(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as TopicPageSupplements,
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppError,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.supplements, this.error);

  @override
  final TopicPageSupplements supplements;
  @override
  final AppError error;

  @override
  String toString() {
    return 'TopicPageState.failed(supplements: $supplements, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(supplements),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TopicPageSupplements supplements, String? message)
        loading,
    required TResult Function(TopicPageSupplements supplements) content,
    required TResult Function(TopicPageSupplements supplements, AppError error)
        failed,
  }) {
    return failed(supplements, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
  }) {
    return failed?.call(supplements, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TopicPageSupplements supplements, String? message)?
        loading,
    TResult Function(TopicPageSupplements supplements)? content,
    TResult Function(TopicPageSupplements supplements, AppError error)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(supplements, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements TopicPageState {
  const factory _Failed(TopicPageSupplements supplements, AppError error) =
      _$_Failed;

  @override
  TopicPageSupplements get supplements;
  AppError get error;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}
