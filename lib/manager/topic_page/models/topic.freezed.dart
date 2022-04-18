// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TopicTearOff {
  const _$TopicTearOff();

  _Topic call(
      {String id = '',
      String title = '',
      String? description,
      String? thumbnailUrl,
      String? parentID,
      int totalLessons = 0,
      int completedLessons = 0,
      bool isPublished = false}) {
    return _Topic(
      id: id,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      parentID: parentID,
      totalLessons: totalLessons,
      completedLessons: completedLessons,
      isPublished: isPublished,
    );
  }
}

/// @nodoc
const $Topic = _$TopicTearOff();

/// @nodoc
mixin _$Topic {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get parentID => throw _privateConstructorUsedError;
  int get totalLessons => throw _privateConstructorUsedError;
  int get completedLessons => throw _privateConstructorUsedError;
  bool get isPublished => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopicCopyWith<Topic> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicCopyWith<$Res> {
  factory $TopicCopyWith(Topic value, $Res Function(Topic) then) =
      _$TopicCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String? description,
      String? thumbnailUrl,
      String? parentID,
      int totalLessons,
      int completedLessons,
      bool isPublished});
}

/// @nodoc
class _$TopicCopyWithImpl<$Res> implements $TopicCopyWith<$Res> {
  _$TopicCopyWithImpl(this._value, this._then);

  final Topic _value;
  // ignore: unused_field
  final $Res Function(Topic) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? parentID = freezed,
    Object? totalLessons = freezed,
    Object? completedLessons = freezed,
    Object? isPublished = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      parentID: parentID == freezed
          ? _value.parentID
          : parentID // ignore: cast_nullable_to_non_nullable
              as String?,
      totalLessons: totalLessons == freezed
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: completedLessons == freezed
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: isPublished == freezed
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$TopicCopyWith<$Res> implements $TopicCopyWith<$Res> {
  factory _$TopicCopyWith(_Topic value, $Res Function(_Topic) then) =
      __$TopicCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String? description,
      String? thumbnailUrl,
      String? parentID,
      int totalLessons,
      int completedLessons,
      bool isPublished});
}

/// @nodoc
class __$TopicCopyWithImpl<$Res> extends _$TopicCopyWithImpl<$Res>
    implements _$TopicCopyWith<$Res> {
  __$TopicCopyWithImpl(_Topic _value, $Res Function(_Topic) _then)
      : super(_value, (v) => _then(v as _Topic));

  @override
  _Topic get _value => super._value as _Topic;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? parentID = freezed,
    Object? totalLessons = freezed,
    Object? completedLessons = freezed,
    Object? isPublished = freezed,
  }) {
    return _then(_Topic(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      parentID: parentID == freezed
          ? _value.parentID
          : parentID // ignore: cast_nullable_to_non_nullable
              as String?,
      totalLessons: totalLessons == freezed
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: completedLessons == freezed
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: isPublished == freezed
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Topic implements _Topic {
  const _$_Topic(
      {this.id = '',
      this.title = '',
      this.description,
      this.thumbnailUrl,
      this.parentID,
      this.totalLessons = 0,
      this.completedLessons = 0,
      this.isPublished = false});

  @JsonKey()
  @override
  final String id;
  @JsonKey()
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? thumbnailUrl;
  @override
  final String? parentID;
  @JsonKey()
  @override
  final int totalLessons;
  @JsonKey()
  @override
  final int completedLessons;
  @JsonKey()
  @override
  final bool isPublished;

  @override
  String toString() {
    return 'Topic(id: $id, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, parentID: $parentID, totalLessons: $totalLessons, completedLessons: $completedLessons, isPublished: $isPublished)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Topic &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailUrl, thumbnailUrl) &&
            const DeepCollectionEquality().equals(other.parentID, parentID) &&
            const DeepCollectionEquality()
                .equals(other.totalLessons, totalLessons) &&
            const DeepCollectionEquality()
                .equals(other.completedLessons, completedLessons) &&
            const DeepCollectionEquality()
                .equals(other.isPublished, isPublished));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(thumbnailUrl),
      const DeepCollectionEquality().hash(parentID),
      const DeepCollectionEquality().hash(totalLessons),
      const DeepCollectionEquality().hash(completedLessons),
      const DeepCollectionEquality().hash(isPublished));

  @JsonKey(ignore: true)
  @override
  _$TopicCopyWith<_Topic> get copyWith =>
      __$TopicCopyWithImpl<_Topic>(this, _$identity);
}

abstract class _Topic implements Topic {
  const factory _Topic(
      {String id,
      String title,
      String? description,
      String? thumbnailUrl,
      String? parentID,
      int totalLessons,
      int completedLessons,
      bool isPublished}) = _$_Topic;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get thumbnailUrl;
  @override
  String? get parentID;
  @override
  int get totalLessons;
  @override
  int get completedLessons;
  @override
  bool get isPublished;
  @override
  @JsonKey(ignore: true)
  _$TopicCopyWith<_Topic> get copyWith => throw _privateConstructorUsedError;
}
