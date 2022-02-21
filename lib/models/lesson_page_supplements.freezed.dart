// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lesson_page_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LessonPageSupplementsTearOff {
  const _$LessonPageSupplementsTearOff();

  _LessonPageSupplements call({required Lesson lesson, required bool isLast}) {
    return _LessonPageSupplements(
      lesson: lesson,
      isLast: isLast,
    );
  }
}

/// @nodoc
const $LessonPageSupplements = _$LessonPageSupplementsTearOff();

/// @nodoc
mixin _$LessonPageSupplements {
  Lesson get lesson => throw _privateConstructorUsedError;
  bool get isLast => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LessonPageSupplementsCopyWith<LessonPageSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonPageSupplementsCopyWith<$Res> {
  factory $LessonPageSupplementsCopyWith(LessonPageSupplements value,
          $Res Function(LessonPageSupplements) then) =
      _$LessonPageSupplementsCopyWithImpl<$Res>;
  $Res call({Lesson lesson, bool isLast});
}

/// @nodoc
class _$LessonPageSupplementsCopyWithImpl<$Res>
    implements $LessonPageSupplementsCopyWith<$Res> {
  _$LessonPageSupplementsCopyWithImpl(this._value, this._then);

  final LessonPageSupplements _value;
  // ignore: unused_field
  final $Res Function(LessonPageSupplements) _then;

  @override
  $Res call({
    Object? lesson = freezed,
    Object? isLast = freezed,
  }) {
    return _then(_value.copyWith(
      lesson: lesson == freezed
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      isLast: isLast == freezed
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$LessonPageSupplementsCopyWith<$Res>
    implements $LessonPageSupplementsCopyWith<$Res> {
  factory _$LessonPageSupplementsCopyWith(_LessonPageSupplements value,
          $Res Function(_LessonPageSupplements) then) =
      __$LessonPageSupplementsCopyWithImpl<$Res>;
  @override
  $Res call({Lesson lesson, bool isLast});
}

/// @nodoc
class __$LessonPageSupplementsCopyWithImpl<$Res>
    extends _$LessonPageSupplementsCopyWithImpl<$Res>
    implements _$LessonPageSupplementsCopyWith<$Res> {
  __$LessonPageSupplementsCopyWithImpl(_LessonPageSupplements _value,
      $Res Function(_LessonPageSupplements) _then)
      : super(_value, (v) => _then(v as _LessonPageSupplements));

  @override
  _LessonPageSupplements get _value => super._value as _LessonPageSupplements;

  @override
  $Res call({
    Object? lesson = freezed,
    Object? isLast = freezed,
  }) {
    return _then(_LessonPageSupplements(
      lesson: lesson == freezed
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      isLast: isLast == freezed
          ? _value.isLast
          : isLast // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LessonPageSupplements implements _LessonPageSupplements {
  const _$_LessonPageSupplements({required this.lesson, required this.isLast});

  @override
  final Lesson lesson;
  @override
  final bool isLast;

  @override
  String toString() {
    return 'LessonPageSupplements(lesson: $lesson, isLast: $isLast)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LessonPageSupplements &&
            const DeepCollectionEquality().equals(other.lesson, lesson) &&
            const DeepCollectionEquality().equals(other.isLast, isLast));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(lesson),
      const DeepCollectionEquality().hash(isLast));

  @JsonKey(ignore: true)
  @override
  _$LessonPageSupplementsCopyWith<_LessonPageSupplements> get copyWith =>
      __$LessonPageSupplementsCopyWithImpl<_LessonPageSupplements>(
          this, _$identity);
}

abstract class _LessonPageSupplements implements LessonPageSupplements {
  const factory _LessonPageSupplements(
      {required Lesson lesson,
      required bool isLast}) = _$_LessonPageSupplements;

  @override
  Lesson get lesson;
  @override
  bool get isLast;
  @override
  @JsonKey(ignore: true)
  _$LessonPageSupplementsCopyWith<_LessonPageSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
