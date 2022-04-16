// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'onboarding_pages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OnBoardingPagesStateTearOff {
  const _$OnBoardingPagesStateTearOff();

  _Loading laoding(Pages page, OnBoardingSupplements supplements,
      {String? message}) {
    return _Loading(
      page,
      supplements,
      message: message,
    );
  }

  _Content content(Pages page, OnBoardingSupplements supplements) {
    return _Content(
      page,
      supplements,
    );
  }

  _Success success(Pages page, OnBoardingSupplements supplements) {
    return _Success(
      page,
      supplements,
    );
  }

  _Failed failed(
      Pages page, OnBoardingSupplements supplements, AppError error) {
    return _Failed(
      page,
      supplements,
      error,
    );
  }
}

/// @nodoc
const $OnBoardingPagesState = _$OnBoardingPagesStateTearOff();

/// @nodoc
mixin _$OnBoardingPagesState {
  Pages get page => throw _privateConstructorUsedError;
  OnBoardingSupplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)
        laoding,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        content,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        success,
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) laoding,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnBoardingPagesStateCopyWith<OnBoardingPagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnBoardingPagesStateCopyWith<$Res> {
  factory $OnBoardingPagesStateCopyWith(OnBoardingPagesState value,
          $Res Function(OnBoardingPagesState) then) =
      _$OnBoardingPagesStateCopyWithImpl<$Res>;
  $Res call({Pages page, OnBoardingSupplements supplements});

  $OnBoardingSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$OnBoardingPagesStateCopyWithImpl<$Res>
    implements $OnBoardingPagesStateCopyWith<$Res> {
  _$OnBoardingPagesStateCopyWithImpl(this._value, this._then);

  final OnBoardingPagesState _value;
  // ignore: unused_field
  final $Res Function(OnBoardingPagesState) _then;

  @override
  $Res call({
    Object? page = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as Pages,
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as OnBoardingSupplements,
    ));
  }

  @override
  $OnBoardingSupplementsCopyWith<$Res> get supplements {
    return $OnBoardingSupplementsCopyWith<$Res>(_value.supplements, (value) {
      return _then(_value.copyWith(supplements: value));
    });
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $OnBoardingPagesStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({Pages page, OnBoardingSupplements supplements, String? message});

  @override
  $OnBoardingSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    extends _$OnBoardingPagesStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? page = freezed,
    Object? supplements = freezed,
    Object? message = freezed,
  }) {
    return _then(_Loading(
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as Pages,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as OnBoardingSupplements,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.page, this.supplements, {this.message});

  @override
  final Pages page;
  @override
  final OnBoardingSupplements supplements;
  @override
  final String? message;

  @override
  String toString() {
    return 'OnBoardingPagesState.laoding(page: $page, supplements: $supplements, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(supplements),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)
        laoding,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        content,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        success,
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)
        failed,
  }) {
    return laoding(page, supplements, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
  }) {
    return laoding?.call(page, supplements, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
    required TResult orElse(),
  }) {
    if (laoding != null) {
      return laoding(page, supplements, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) laoding,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return laoding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return laoding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (laoding != null) {
      return laoding(this);
    }
    return orElse();
  }
}

abstract class _Loading implements OnBoardingPagesState {
  const factory _Loading(Pages page, OnBoardingSupplements supplements,
      {String? message}) = _$_Loading;

  @override
  Pages get page;
  @override
  OnBoardingSupplements get supplements;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $OnBoardingPagesStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({Pages page, OnBoardingSupplements supplements});

  @override
  $OnBoardingSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res>
    extends _$OnBoardingPagesStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? page = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as Pages,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as OnBoardingSupplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.page, this.supplements);

  @override
  final Pages page;
  @override
  final OnBoardingSupplements supplements;

  @override
  String toString() {
    return 'OnBoardingPagesState.content(page: $page, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)
        laoding,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        content,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        success,
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)
        failed,
  }) {
    return content(page, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
  }) {
    return content?.call(page, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(page, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) laoding,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements OnBoardingPagesState {
  const factory _Content(Pages page, OnBoardingSupplements supplements) =
      _$_Content;

  @override
  Pages get page;
  @override
  OnBoardingSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res>
    implements $OnBoardingPagesStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  @override
  $Res call({Pages page, OnBoardingSupplements supplements});

  @override
  $OnBoardingSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    extends _$OnBoardingPagesStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object? page = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Success(
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as Pages,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as OnBoardingSupplements,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(this.page, this.supplements);

  @override
  final Pages page;
  @override
  final OnBoardingSupplements supplements;

  @override
  String toString() {
    return 'OnBoardingPagesState.success(page: $page, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)
        laoding,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        content,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        success,
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)
        failed,
  }) {
    return success(page, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
  }) {
    return success?.call(page, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(page, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) laoding,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements OnBoardingPagesState {
  const factory _Success(Pages page, OnBoardingSupplements supplements) =
      _$_Success;

  @override
  Pages get page;
  @override
  OnBoardingSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$SuccessCopyWith<_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $OnBoardingPagesStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call({Pages page, OnBoardingSupplements supplements, AppError error});

  @override
  $OnBoardingSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res>
    extends _$OnBoardingPagesStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? page = freezed,
    Object? supplements = freezed,
    Object? error = freezed,
  }) {
    return _then(_Failed(
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as Pages,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as OnBoardingSupplements,
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppError,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.page, this.supplements, this.error);

  @override
  final Pages page;
  @override
  final OnBoardingSupplements supplements;
  @override
  final AppError error;

  @override
  String toString() {
    return 'OnBoardingPagesState.failed(page: $page, supplements: $supplements, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(supplements),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)
        laoding,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        content,
    required TResult Function(Pages page, OnBoardingSupplements supplements)
        success,
    required TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)
        failed,
  }) {
    return failed(page, supplements, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
  }) {
    return failed?.call(page, supplements, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Pages page, OnBoardingSupplements supplements, String? message)?
        laoding,
    TResult Function(Pages page, OnBoardingSupplements supplements)? content,
    TResult Function(Pages page, OnBoardingSupplements supplements)? success,
    TResult Function(
            Pages page, OnBoardingSupplements supplements, AppError error)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(page, supplements, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) laoding,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? laoding,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements OnBoardingPagesState {
  const factory _Failed(
          Pages page, OnBoardingSupplements supplements, AppError error) =
      _$_Failed;

  @override
  Pages get page;
  @override
  OnBoardingSupplements get supplements;
  AppError get error;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}
