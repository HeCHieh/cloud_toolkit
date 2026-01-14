// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deploy_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeployTask _$DeployTaskFromJson(Map<String, dynamic> json) {
  return _DeployTask.fromJson(json);
}

/// @nodoc
mixin _$DeployTask {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  SshConfig get sshConfig => throw _privateConstructorUsedError;
  @HiveField(3)
  String get localPath => throw _privateConstructorUsedError;
  @HiveField(4)
  String get remotePath => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get preScript => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get postScript => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DeployTask to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeployTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeployTaskCopyWith<DeployTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeployTaskCopyWith<$Res> {
  factory $DeployTaskCopyWith(
          DeployTask value, $Res Function(DeployTask) then) =
      _$DeployTaskCopyWithImpl<$Res, DeployTask>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) SshConfig sshConfig,
      @HiveField(3) String localPath,
      @HiveField(4) String remotePath,
      @HiveField(5) String? preScript,
      @HiveField(6) String? postScript,
      @HiveField(7) DateTime createdAt,
      @HiveField(8) DateTime? updatedAt});

  $SshConfigCopyWith<$Res> get sshConfig;
}

/// @nodoc
class _$DeployTaskCopyWithImpl<$Res, $Val extends DeployTask>
    implements $DeployTaskCopyWith<$Res> {
  _$DeployTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeployTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sshConfig = null,
    Object? localPath = null,
    Object? remotePath = null,
    Object? preScript = freezed,
    Object? postScript = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sshConfig: null == sshConfig
          ? _value.sshConfig
          : sshConfig // ignore: cast_nullable_to_non_nullable
              as SshConfig,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      remotePath: null == remotePath
          ? _value.remotePath
          : remotePath // ignore: cast_nullable_to_non_nullable
              as String,
      preScript: freezed == preScript
          ? _value.preScript
          : preScript // ignore: cast_nullable_to_non_nullable
              as String?,
      postScript: freezed == postScript
          ? _value.postScript
          : postScript // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of DeployTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SshConfigCopyWith<$Res> get sshConfig {
    return $SshConfigCopyWith<$Res>(_value.sshConfig, (value) {
      return _then(_value.copyWith(sshConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeployTaskImplCopyWith<$Res>
    implements $DeployTaskCopyWith<$Res> {
  factory _$$DeployTaskImplCopyWith(
          _$DeployTaskImpl value, $Res Function(_$DeployTaskImpl) then) =
      __$$DeployTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) SshConfig sshConfig,
      @HiveField(3) String localPath,
      @HiveField(4) String remotePath,
      @HiveField(5) String? preScript,
      @HiveField(6) String? postScript,
      @HiveField(7) DateTime createdAt,
      @HiveField(8) DateTime? updatedAt});

  @override
  $SshConfigCopyWith<$Res> get sshConfig;
}

/// @nodoc
class __$$DeployTaskImplCopyWithImpl<$Res>
    extends _$DeployTaskCopyWithImpl<$Res, _$DeployTaskImpl>
    implements _$$DeployTaskImplCopyWith<$Res> {
  __$$DeployTaskImplCopyWithImpl(
      _$DeployTaskImpl _value, $Res Function(_$DeployTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeployTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sshConfig = null,
    Object? localPath = null,
    Object? remotePath = null,
    Object? preScript = freezed,
    Object? postScript = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DeployTaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sshConfig: null == sshConfig
          ? _value.sshConfig
          : sshConfig // ignore: cast_nullable_to_non_nullable
              as SshConfig,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      remotePath: null == remotePath
          ? _value.remotePath
          : remotePath // ignore: cast_nullable_to_non_nullable
              as String,
      preScript: freezed == preScript
          ? _value.preScript
          : preScript // ignore: cast_nullable_to_non_nullable
              as String?,
      postScript: freezed == postScript
          ? _value.postScript
          : postScript // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeployTaskImpl implements _DeployTask {
  const _$DeployTaskImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.sshConfig,
      @HiveField(3) required this.localPath,
      @HiveField(4) required this.remotePath,
      @HiveField(5) this.preScript,
      @HiveField(6) this.postScript,
      @HiveField(7) required this.createdAt,
      @HiveField(8) this.updatedAt});

  factory _$DeployTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeployTaskImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final SshConfig sshConfig;
  @override
  @HiveField(3)
  final String localPath;
  @override
  @HiveField(4)
  final String remotePath;
  @override
  @HiveField(5)
  final String? preScript;
  @override
  @HiveField(6)
  final String? postScript;
  @override
  @HiveField(7)
  final DateTime createdAt;
  @override
  @HiveField(8)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DeployTask(id: $id, name: $name, sshConfig: $sshConfig, localPath: $localPath, remotePath: $remotePath, preScript: $preScript, postScript: $postScript, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeployTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sshConfig, sshConfig) ||
                other.sshConfig == sshConfig) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.remotePath, remotePath) ||
                other.remotePath == remotePath) &&
            (identical(other.preScript, preScript) ||
                other.preScript == preScript) &&
            (identical(other.postScript, postScript) ||
                other.postScript == postScript) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, sshConfig, localPath,
      remotePath, preScript, postScript, createdAt, updatedAt);

  /// Create a copy of DeployTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeployTaskImplCopyWith<_$DeployTaskImpl> get copyWith =>
      __$$DeployTaskImplCopyWithImpl<_$DeployTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeployTaskImplToJson(
      this,
    );
  }
}

abstract class _DeployTask implements DeployTask {
  const factory _DeployTask(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final SshConfig sshConfig,
      @HiveField(3) required final String localPath,
      @HiveField(4) required final String remotePath,
      @HiveField(5) final String? preScript,
      @HiveField(6) final String? postScript,
      @HiveField(7) required final DateTime createdAt,
      @HiveField(8) final DateTime? updatedAt}) = _$DeployTaskImpl;

  factory _DeployTask.fromJson(Map<String, dynamic> json) =
      _$DeployTaskImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  SshConfig get sshConfig;
  @override
  @HiveField(3)
  String get localPath;
  @override
  @HiveField(4)
  String get remotePath;
  @override
  @HiveField(5)
  String? get preScript;
  @override
  @HiveField(6)
  String? get postScript;
  @override
  @HiveField(7)
  DateTime get createdAt;
  @override
  @HiveField(8)
  DateTime? get updatedAt;

  /// Create a copy of DeployTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeployTaskImplCopyWith<_$DeployTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
