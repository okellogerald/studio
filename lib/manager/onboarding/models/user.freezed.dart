// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {required DateTime dateOfBirth,
      String email = '',
      String name = '',
      dynamic gender = 'Male',
      int courseId = 0,
      String level = '',
      int gradeId = 0}) {
    return _User(
      dateOfBirth: dateOfBirth,
      email: email,
      name: name,
      gender: gender,
      courseId: courseId,
      level: level,
      gradeId: gradeId,
    );
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  dynamic get gender => throw _privateConstructorUsedError;
  int get courseId => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  int get gradeId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {DateTime dateOfBirth,
      String email,
      String name,
      dynamic gender,
      int courseId,
      String level,
      int gradeId});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? dateOfBirth = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? gender = freezed,
    Object? courseId = freezed,
    Object? level = freezed,
    Object? gradeId = freezed,
  }) {
    return _then(_value.copyWith(
      dateOfBirth: dateOfBirth == freezed
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as dynamic,
      courseId: courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as int,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      gradeId: gradeId == freezed
          ? _value.gradeId
          : gradeId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {DateTime dateOfBirth,
      String email,
      String name,
      dynamic gender,
      int courseId,
      String level,
      int gradeId});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? dateOfBirth = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? gender = freezed,
    Object? courseId = freezed,
    Object? level = freezed,
    Object? gradeId = freezed,
  }) {
    return _then(_User(
      dateOfBirth: dateOfBirth == freezed
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: gender == freezed ? _value.gender : gender,
      courseId: courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as int,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      gradeId: gradeId == freezed
          ? _value.gradeId
          : gradeId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_User extends _User {
  const _$_User(
      {required this.dateOfBirth,
      this.email = '',
      this.name = '',
      this.gender = 'Male',
      this.courseId = 0,
      this.level = '',
      this.gradeId = 0})
      : super._();

  @override
  final DateTime dateOfBirth;
  @JsonKey()
  @override
  final String email;
  @JsonKey()
  @override
  final String name;
  @JsonKey()
  @override
  final dynamic gender;
  @JsonKey()
  @override
  final int courseId;
  @JsonKey()
  @override
  final String level;
  @JsonKey()
  @override
  final int gradeId;

  @override
  String toString() {
    return 'User(dateOfBirth: $dateOfBirth, email: $email, name: $name, gender: $gender, courseId: $courseId, level: $level, gradeId: $gradeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality()
                .equals(other.dateOfBirth, dateOfBirth) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.courseId, courseId) &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality().equals(other.gradeId, gradeId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dateOfBirth),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(courseId),
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(gradeId));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);
}

abstract class _User extends User {
  const factory _User(
      {required DateTime dateOfBirth,
      String email,
      String name,
      dynamic gender,
      int courseId,
      String level,
      int gradeId}) = _$_User;
  const _User._() : super._();

  @override
  DateTime get dateOfBirth;
  @override
  String get email;
  @override
  String get name;
  @override
  dynamic get gender;
  @override
  int get courseId;
  @override
  String get level;
  @override
  int get gradeId;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
