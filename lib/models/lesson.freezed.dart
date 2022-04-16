// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LessonTearOff {
  const _$LessonTearOff();

  _Lesson call(
      {String id = '',
      String title = '',
      String topicId = '',
      String topicName = '',
      Status completionStatus = Status.completed,
      String description = '',
      String body = '',
      String thumbnailUrl = '',
      LessonType type = LessonType.learn,
      bool isPaid = true,
      bool isPublished = true,
      VideoDetails videoDetails = const VideoDetails()}) {
    return _Lesson(
      id: id,
      title: title,
      topicId: topicId,
      topicName: topicName,
      completionStatus: completionStatus,
      description: description,
      body: body,
      thumbnailUrl: thumbnailUrl,
      type: type,
      isPaid: isPaid,
      isPublished: isPublished,
      videoDetails: videoDetails,
    );
  }
}

/// @nodoc
const $Lesson = _$LessonTearOff();

/// @nodoc
mixin _$Lesson {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get topicId => throw _privateConstructorUsedError;
  String get topicName => throw _privateConstructorUsedError;
  Status get completionStatus => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  LessonType get type => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;
  bool get isPublished => throw _privateConstructorUsedError;
  VideoDetails get videoDetails => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LessonCopyWith<Lesson> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String topicId,
      String topicName,
      Status completionStatus,
      String description,
      String body,
      String thumbnailUrl,
      LessonType type,
      bool isPaid,
      bool isPublished,
      VideoDetails videoDetails});
}

/// @nodoc
class _$LessonCopyWithImpl<$Res> implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  final Lesson _value;
  // ignore: unused_field
  final $Res Function(Lesson) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? topicId = freezed,
    Object? topicName = freezed,
    Object? completionStatus = freezed,
    Object? description = freezed,
    Object? body = freezed,
    Object? thumbnailUrl = freezed,
    Object? type = freezed,
    Object? isPaid = freezed,
    Object? isPublished = freezed,
    Object? videoDetails = freezed,
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
      topicId: topicId == freezed
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as String,
      topicName: topicName == freezed
          ? _value.topicName
          : topicName // ignore: cast_nullable_to_non_nullable
              as String,
      completionStatus: completionStatus == freezed
          ? _value.completionStatus
          : completionStatus // ignore: cast_nullable_to_non_nullable
              as Status,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      isPaid: isPaid == freezed
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublished: isPublished == freezed
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      videoDetails: videoDetails == freezed
          ? _value.videoDetails
          : videoDetails // ignore: cast_nullable_to_non_nullable
              as VideoDetails,
    ));
  }
}

/// @nodoc
abstract class _$LessonCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$LessonCopyWith(_Lesson value, $Res Function(_Lesson) then) =
      __$LessonCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String topicId,
      String topicName,
      Status completionStatus,
      String description,
      String body,
      String thumbnailUrl,
      LessonType type,
      bool isPaid,
      bool isPublished,
      VideoDetails videoDetails});
}

/// @nodoc
class __$LessonCopyWithImpl<$Res> extends _$LessonCopyWithImpl<$Res>
    implements _$LessonCopyWith<$Res> {
  __$LessonCopyWithImpl(_Lesson _value, $Res Function(_Lesson) _then)
      : super(_value, (v) => _then(v as _Lesson));

  @override
  _Lesson get _value => super._value as _Lesson;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? topicId = freezed,
    Object? topicName = freezed,
    Object? completionStatus = freezed,
    Object? description = freezed,
    Object? body = freezed,
    Object? thumbnailUrl = freezed,
    Object? type = freezed,
    Object? isPaid = freezed,
    Object? isPublished = freezed,
    Object? videoDetails = freezed,
  }) {
    return _then(_Lesson(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      topicId: topicId == freezed
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as String,
      topicName: topicName == freezed
          ? _value.topicName
          : topicName // ignore: cast_nullable_to_non_nullable
              as String,
      completionStatus: completionStatus == freezed
          ? _value.completionStatus
          : completionStatus // ignore: cast_nullable_to_non_nullable
              as Status,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType,
      isPaid: isPaid == freezed
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublished: isPublished == freezed
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      videoDetails: videoDetails == freezed
          ? _value.videoDetails
          : videoDetails // ignore: cast_nullable_to_non_nullable
              as VideoDetails,
    ));
  }
}

/// @nodoc

class _$_Lesson extends _Lesson {
  const _$_Lesson(
      {this.id = '',
      this.title = '',
      this.topicId = '',
      this.topicName = '',
      this.completionStatus = Status.completed,
      this.description = '',
      this.body = '',
      this.thumbnailUrl = '',
      this.type = LessonType.learn,
      this.isPaid = true,
      this.isPublished = true,
      this.videoDetails = const VideoDetails()})
      : super._();

  @JsonKey()
  @override
  final String id;
  @JsonKey()
  @override
  final String title;
  @JsonKey()
  @override
  final String topicId;
  @JsonKey()
  @override
  final String topicName;
  @JsonKey()
  @override
  final Status completionStatus;
  @JsonKey()
  @override
  final String description;
  @JsonKey()
  @override
  final String body;
  @JsonKey()
  @override
  final String thumbnailUrl;
  @JsonKey()
  @override
  final LessonType type;
  @JsonKey()
  @override
  final bool isPaid;
  @JsonKey()
  @override
  final bool isPublished;
  @JsonKey()
  @override
  final VideoDetails videoDetails;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Lesson &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.topicId, topicId) &&
            const DeepCollectionEquality().equals(other.topicName, topicName) &&
            const DeepCollectionEquality()
                .equals(other.completionStatus, completionStatus) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.body, body) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailUrl, thumbnailUrl) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.isPaid, isPaid) &&
            const DeepCollectionEquality()
                .equals(other.isPublished, isPublished) &&
            const DeepCollectionEquality()
                .equals(other.videoDetails, videoDetails));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(topicId),
      const DeepCollectionEquality().hash(topicName),
      const DeepCollectionEquality().hash(completionStatus),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(thumbnailUrl),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(isPaid),
      const DeepCollectionEquality().hash(isPublished),
      const DeepCollectionEquality().hash(videoDetails));

  @JsonKey(ignore: true)
  @override
  _$LessonCopyWith<_Lesson> get copyWith =>
      __$LessonCopyWithImpl<_Lesson>(this, _$identity);
}

abstract class _Lesson extends Lesson {
  const factory _Lesson(
      {String id,
      String title,
      String topicId,
      String topicName,
      Status completionStatus,
      String description,
      String body,
      String thumbnailUrl,
      LessonType type,
      bool isPaid,
      bool isPublished,
      VideoDetails videoDetails}) = _$_Lesson;
  const _Lesson._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String get topicId;
  @override
  String get topicName;
  @override
  Status get completionStatus;
  @override
  String get description;
  @override
  String get body;
  @override
  String get thumbnailUrl;
  @override
  LessonType get type;
  @override
  bool get isPaid;
  @override
  bool get isPublished;
  @override
  VideoDetails get videoDetails;
  @override
  @JsonKey(ignore: true)
  _$LessonCopyWith<_Lesson> get copyWith => throw _privateConstructorUsedError;
}
