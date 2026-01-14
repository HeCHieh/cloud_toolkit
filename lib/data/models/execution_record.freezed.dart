// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'execution_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExecutionRecord _$ExecutionRecordFromJson(Map<String, dynamic> json) {
  return _ExecutionRecord.fromJson(json);
}

/// @nodoc
mixin _$ExecutionRecord {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get taskId => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get startTime => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime? get endTime => throw _privateConstructorUsedError;
  @HiveField(4)
  ExecutionStatus get status => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get logs => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this ExecutionRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExecutionRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExecutionRecordCopyWith<ExecutionRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutionRecordCopyWith<$Res> {
  factory $ExecutionRecordCopyWith(
          ExecutionRecord value, $Res Function(ExecutionRecord) then) =
      _$ExecutionRecordCopyWithImpl<$Res, ExecutionRecord>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String taskId,
      @HiveField(2) DateTime startTime,
      @HiveField(3) DateTime? endTime,
      @HiveField(4) ExecutionStatus status,
      @HiveField(5) List<String> logs,
      @HiveField(6) String? errorMessage});
}

/// @nodoc
class _$ExecutionRecordCopyWithImpl<$Res, $Val extends ExecutionRecord>
    implements $ExecutionRecordCopyWith<$Res> {
  _$ExecutionRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExecutionRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? logs = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExecutionStatus,
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExecutionRecordImplCopyWith<$Res>
    implements $ExecutionRecordCopyWith<$Res> {
  factory _$$ExecutionRecordImplCopyWith(_$ExecutionRecordImpl value,
          $Res Function(_$ExecutionRecordImpl) then) =
      __$$ExecutionRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String taskId,
      @HiveField(2) DateTime startTime,
      @HiveField(3) DateTime? endTime,
      @HiveField(4) ExecutionStatus status,
      @HiveField(5) List<String> logs,
      @HiveField(6) String? errorMessage});
}

/// @nodoc
class __$$ExecutionRecordImplCopyWithImpl<$Res>
    extends _$ExecutionRecordCopyWithImpl<$Res, _$ExecutionRecordImpl>
    implements _$$ExecutionRecordImplCopyWith<$Res> {
  __$$ExecutionRecordImplCopyWithImpl(
      _$ExecutionRecordImpl _value, $Res Function(_$ExecutionRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExecutionRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? logs = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ExecutionRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExecutionStatus,
      logs: null == logs
          ? _value._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExecutionRecordImpl extends _ExecutionRecord {
  const _$ExecutionRecordImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.taskId,
      @HiveField(2) required this.startTime,
      @HiveField(3) this.endTime,
      @HiveField(4) required this.status,
      @HiveField(5) final List<String> logs = const <String>[],
      @HiveField(6) this.errorMessage})
      : _logs = logs,
        super._();

  factory _$ExecutionRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExecutionRecordImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String taskId;
  @override
  @HiveField(2)
  final DateTime startTime;
  @override
  @HiveField(3)
  final DateTime? endTime;
  @override
  @HiveField(4)
  final ExecutionStatus status;
  final List<String> _logs;
  @override
  @JsonKey()
  @HiveField(5)
  List<String> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  @HiveField(6)
  final String? errorMessage;

  @override
  String toString() {
    return 'ExecutionRecord(id: $id, taskId: $taskId, startTime: $startTime, endTime: $endTime, status: $status, logs: $logs, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExecutionRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._logs, _logs) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, taskId, startTime, endTime,
      status, const DeepCollectionEquality().hash(_logs), errorMessage);

  /// Create a copy of ExecutionRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExecutionRecordImplCopyWith<_$ExecutionRecordImpl> get copyWith =>
      __$$ExecutionRecordImplCopyWithImpl<_$ExecutionRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExecutionRecordImplToJson(
      this,
    );
  }
}

abstract class _ExecutionRecord extends ExecutionRecord {
  const factory _ExecutionRecord(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String taskId,
      @HiveField(2) required final DateTime startTime,
      @HiveField(3) final DateTime? endTime,
      @HiveField(4) required final ExecutionStatus status,
      @HiveField(5) final List<String> logs,
      @HiveField(6) final String? errorMessage}) = _$ExecutionRecordImpl;
  const _ExecutionRecord._() : super._();

  factory _ExecutionRecord.fromJson(Map<String, dynamic> json) =
      _$ExecutionRecordImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get taskId;
  @override
  @HiveField(2)
  DateTime get startTime;
  @override
  @HiveField(3)
  DateTime? get endTime;
  @override
  @HiveField(4)
  ExecutionStatus get status;
  @override
  @HiveField(5)
  List<String> get logs;
  @override
  @HiveField(6)
  String? get errorMessage;

  /// Create a copy of ExecutionRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExecutionRecordImplCopyWith<_$ExecutionRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
