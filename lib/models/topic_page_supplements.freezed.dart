// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'topic_page_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TopicPageSupplementsTearOff {
  const _$TopicPageSupplementsTearOff();

  _TopicPageSupplements call(
      {required FilterType filterType,
      required List<Lesson> lessons,
      required List<Topic> topics}) {
    return _TopicPageSupplements(
      filterType: filterType,
      lessons: lessons,
      topics: topics,
    );
  }
}

/// @nodoc
const $TopicPageSupplements = _$TopicPageSupplementsTearOff();

/// @nodoc
mixin _$TopicPageSupplements {
  FilterType get filterType => throw _privateConstructorUsedError;
  List<Lesson> get lessons => throw _privateConstructorUsedError;
  List<Topic> get topics => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopicPageSupplementsCopyWith<TopicPageSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicPageSupplementsCopyWith<$Res> {
  factory $TopicPageSupplementsCopyWith(TopicPageSupplements value,
          $Res Function(TopicPageSupplements) then) =
      _$TopicPageSupplementsCopyWithImpl<$Res>;
  $Res call({FilterType filterType, List<Lesson> lessons, List<Topic> topics});
}

/// @nodoc
class _$TopicPageSupplementsCopyWithImpl<$Res>
    implements $TopicPageSupplementsCopyWith<$Res> {
  _$TopicPageSupplementsCopyWithImpl(this._value, this._then);

  final TopicPageSupplements _value;
  // ignore: unused_field
  final $Res Function(TopicPageSupplements) _then;

  @override
  $Res call({
    Object? filterType = freezed,
    Object? lessons = freezed,
    Object? topics = freezed,
  }) {
    return _then(_value.copyWith(
      filterType: filterType == freezed
          ? _value.filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as FilterType,
      lessons: lessons == freezed
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<Lesson>,
      topics: topics == freezed
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<Topic>,
    ));
  }
}

/// @nodoc
abstract class _$TopicPageSupplementsCopyWith<$Res>
    implements $TopicPageSupplementsCopyWith<$Res> {
  factory _$TopicPageSupplementsCopyWith(_TopicPageSupplements value,
          $Res Function(_TopicPageSupplements) then) =
      __$TopicPageSupplementsCopyWithImpl<$Res>;
  @override
  $Res call({FilterType filterType, List<Lesson> lessons, List<Topic> topics});
}

/// @nodoc
class __$TopicPageSupplementsCopyWithImpl<$Res>
    extends _$TopicPageSupplementsCopyWithImpl<$Res>
    implements _$TopicPageSupplementsCopyWith<$Res> {
  __$TopicPageSupplementsCopyWithImpl(
      _TopicPageSupplements _value, $Res Function(_TopicPageSupplements) _then)
      : super(_value, (v) => _then(v as _TopicPageSupplements));

  @override
  _TopicPageSupplements get _value => super._value as _TopicPageSupplements;

  @override
  $Res call({
    Object? filterType = freezed,
    Object? lessons = freezed,
    Object? topics = freezed,
  }) {
    return _then(_TopicPageSupplements(
      filterType: filterType == freezed
          ? _value.filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as FilterType,
      lessons: lessons == freezed
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<Lesson>,
      topics: topics == freezed
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<Topic>,
    ));
  }
}

/// @nodoc

class _$_TopicPageSupplements implements _TopicPageSupplements {
  const _$_TopicPageSupplements(
      {required this.filterType, required this.lessons, required this.topics});

  @override
  final FilterType filterType;
  @override
  final List<Lesson> lessons;
  @override
  final List<Topic> topics;

  @override
  String toString() {
    return 'TopicPageSupplements(filterType: $filterType, lessons: $lessons, topics: $topics)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TopicPageSupplements &&
            const DeepCollectionEquality()
                .equals(other.filterType, filterType) &&
            const DeepCollectionEquality().equals(other.lessons, lessons) &&
            const DeepCollectionEquality().equals(other.topics, topics));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(filterType),
      const DeepCollectionEquality().hash(lessons),
      const DeepCollectionEquality().hash(topics));

  @JsonKey(ignore: true)
  @override
  _$TopicPageSupplementsCopyWith<_TopicPageSupplements> get copyWith =>
      __$TopicPageSupplementsCopyWithImpl<_TopicPageSupplements>(
          this, _$identity);
}

abstract class _TopicPageSupplements implements TopicPageSupplements {
  const factory _TopicPageSupplements(
      {required FilterType filterType,
      required List<Lesson> lessons,
      required List<Topic> topics}) = _$_TopicPageSupplements;

  @override
  FilterType get filterType;
  @override
  List<Lesson> get lessons;
  @override
  List<Topic> get topics;
  @override
  @JsonKey(ignore: true)
  _$TopicPageSupplementsCopyWith<_TopicPageSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
