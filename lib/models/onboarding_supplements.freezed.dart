// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'onboarding_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OnBoardingSupplementsTearOff {
  const _$OnBoardingSupplementsTearOff();

  _OnBoardingSupplements call(
      {String password = '',
      String confirmationPassword = '',
      Map<String, String?> errors = const {},
      required UserData user,
      List<Course> courseList = const [],
      List<String> courseTypes = const []}) {
    return _OnBoardingSupplements(
      password: password,
      confirmationPassword: confirmationPassword,
      errors: errors,
      user: user,
      courseList: courseList,
      courseTypes: courseTypes,
    );
  }
}

/// @nodoc
const $OnBoardingSupplements = _$OnBoardingSupplementsTearOff();

/// @nodoc
mixin _$OnBoardingSupplements {
  String get password => throw _privateConstructorUsedError;
  String get confirmationPassword => throw _privateConstructorUsedError;
  Map<String, String?> get errors => throw _privateConstructorUsedError;
  UserData get user => throw _privateConstructorUsedError;
  List<Course> get courseList => throw _privateConstructorUsedError;
  List<String> get courseTypes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnBoardingSupplementsCopyWith<OnBoardingSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnBoardingSupplementsCopyWith<$Res> {
  factory $OnBoardingSupplementsCopyWith(OnBoardingSupplements value,
          $Res Function(OnBoardingSupplements) then) =
      _$OnBoardingSupplementsCopyWithImpl<$Res>;
  $Res call(
      {String password,
      String confirmationPassword,
      Map<String, String?> errors,
      UserData user,
      List<Course> courseList,
      List<String> courseTypes});

  $UserDataCopyWith<$Res> get user;
}

/// @nodoc
class _$OnBoardingSupplementsCopyWithImpl<$Res>
    implements $OnBoardingSupplementsCopyWith<$Res> {
  _$OnBoardingSupplementsCopyWithImpl(this._value, this._then);

  final OnBoardingSupplements _value;
  // ignore: unused_field
  final $Res Function(OnBoardingSupplements) _then;

  @override
  $Res call({
    Object? password = freezed,
    Object? confirmationPassword = freezed,
    Object? errors = freezed,
    Object? user = freezed,
    Object? courseList = freezed,
    Object? courseTypes = freezed,
  }) {
    return _then(_value.copyWith(
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmationPassword: confirmationPassword == freezed
          ? _value.confirmationPassword
          : confirmationPassword // ignore: cast_nullable_to_non_nullable
              as String,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData,
      courseList: courseList == freezed
          ? _value.courseList
          : courseList // ignore: cast_nullable_to_non_nullable
              as List<Course>,
      courseTypes: courseTypes == freezed
          ? _value.courseTypes
          : courseTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  @override
  $UserDataCopyWith<$Res> get user {
    return $UserDataCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$OnBoardingSupplementsCopyWith<$Res>
    implements $OnBoardingSupplementsCopyWith<$Res> {
  factory _$OnBoardingSupplementsCopyWith(_OnBoardingSupplements value,
          $Res Function(_OnBoardingSupplements) then) =
      __$OnBoardingSupplementsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String password,
      String confirmationPassword,
      Map<String, String?> errors,
      UserData user,
      List<Course> courseList,
      List<String> courseTypes});

  @override
  $UserDataCopyWith<$Res> get user;
}

/// @nodoc
class __$OnBoardingSupplementsCopyWithImpl<$Res>
    extends _$OnBoardingSupplementsCopyWithImpl<$Res>
    implements _$OnBoardingSupplementsCopyWith<$Res> {
  __$OnBoardingSupplementsCopyWithImpl(_OnBoardingSupplements _value,
      $Res Function(_OnBoardingSupplements) _then)
      : super(_value, (v) => _then(v as _OnBoardingSupplements));

  @override
  _OnBoardingSupplements get _value => super._value as _OnBoardingSupplements;

  @override
  $Res call({
    Object? password = freezed,
    Object? confirmationPassword = freezed,
    Object? errors = freezed,
    Object? user = freezed,
    Object? courseList = freezed,
    Object? courseTypes = freezed,
  }) {
    return _then(_OnBoardingSupplements(
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmationPassword: confirmationPassword == freezed
          ? _value.confirmationPassword
          : confirmationPassword // ignore: cast_nullable_to_non_nullable
              as String,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData,
      courseList: courseList == freezed
          ? _value.courseList
          : courseList // ignore: cast_nullable_to_non_nullable
              as List<Course>,
      courseTypes: courseTypes == freezed
          ? _value.courseTypes
          : courseTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_OnBoardingSupplements implements _OnBoardingSupplements {
  const _$_OnBoardingSupplements(
      {this.password = '',
      this.confirmationPassword = '',
      this.errors = const {},
      required this.user,
      this.courseList = const [],
      this.courseTypes = const []});

  @JsonKey()
  @override
  final String password;
  @JsonKey()
  @override
  final String confirmationPassword;
  @JsonKey()
  @override
  final Map<String, String?> errors;
  @override
  final UserData user;
  @JsonKey()
  @override
  final List<Course> courseList;
  @JsonKey()
  @override
  final List<String> courseTypes;

  @override
  String toString() {
    return 'OnBoardingSupplements(password: $password, confirmationPassword: $confirmationPassword, errors: $errors, user: $user, courseList: $courseList, courseTypes: $courseTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OnBoardingSupplements &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.confirmationPassword, confirmationPassword) &&
            const DeepCollectionEquality().equals(other.errors, errors) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other.courseList, courseList) &&
            const DeepCollectionEquality()
                .equals(other.courseTypes, courseTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(confirmationPassword),
      const DeepCollectionEquality().hash(errors),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(courseList),
      const DeepCollectionEquality().hash(courseTypes));

  @JsonKey(ignore: true)
  @override
  _$OnBoardingSupplementsCopyWith<_OnBoardingSupplements> get copyWith =>
      __$OnBoardingSupplementsCopyWithImpl<_OnBoardingSupplements>(
          this, _$identity);
}

abstract class _OnBoardingSupplements implements OnBoardingSupplements {
  const factory _OnBoardingSupplements(
      {String password,
      String confirmationPassword,
      Map<String, String?> errors,
      required UserData user,
      List<Course> courseList,
      List<String> courseTypes}) = _$_OnBoardingSupplements;

  @override
  String get password;
  @override
  String get confirmationPassword;
  @override
  Map<String, String?> get errors;
  @override
  UserData get user;
  @override
  List<Course> get courseList;
  @override
  List<String> get courseTypes;
  @override
  @JsonKey(ignore: true)
  _$OnBoardingSupplementsCopyWith<_OnBoardingSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
