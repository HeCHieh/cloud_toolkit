// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ssh_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SshConfig _$SshConfigFromJson(Map<String, dynamic> json) {
  return _SshConfig.fromJson(json);
}

/// @nodoc
mixin _$SshConfig {
  @HiveField(0)
  String get host => throw _privateConstructorUsedError;
  @HiveField(1)
  int get port => throw _privateConstructorUsedError;
  @HiveField(2)
  String get username => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get password => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get privateKeyPath => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get passphrase => throw _privateConstructorUsedError;

  /// Serializes this SshConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SshConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SshConfigCopyWith<SshConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SshConfigCopyWith<$Res> {
  factory $SshConfigCopyWith(SshConfig value, $Res Function(SshConfig) then) =
      _$SshConfigCopyWithImpl<$Res, SshConfig>;
  @useResult
  $Res call(
      {@HiveField(0) String host,
      @HiveField(1) int port,
      @HiveField(2) String username,
      @HiveField(3) String? password,
      @HiveField(4) String? privateKeyPath,
      @HiveField(5) String? passphrase});
}

/// @nodoc
class _$SshConfigCopyWithImpl<$Res, $Val extends SshConfig>
    implements $SshConfigCopyWith<$Res> {
  _$SshConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SshConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? username = null,
    Object? password = freezed,
    Object? privateKeyPath = freezed,
    Object? passphrase = freezed,
  }) {
    return _then(_value.copyWith(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      privateKeyPath: freezed == privateKeyPath
          ? _value.privateKeyPath
          : privateKeyPath // ignore: cast_nullable_to_non_nullable
              as String?,
      passphrase: freezed == passphrase
          ? _value.passphrase
          : passphrase // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SshConfigImplCopyWith<$Res>
    implements $SshConfigCopyWith<$Res> {
  factory _$$SshConfigImplCopyWith(
          _$SshConfigImpl value, $Res Function(_$SshConfigImpl) then) =
      __$$SshConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String host,
      @HiveField(1) int port,
      @HiveField(2) String username,
      @HiveField(3) String? password,
      @HiveField(4) String? privateKeyPath,
      @HiveField(5) String? passphrase});
}

/// @nodoc
class __$$SshConfigImplCopyWithImpl<$Res>
    extends _$SshConfigCopyWithImpl<$Res, _$SshConfigImpl>
    implements _$$SshConfigImplCopyWith<$Res> {
  __$$SshConfigImplCopyWithImpl(
      _$SshConfigImpl _value, $Res Function(_$SshConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SshConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? username = null,
    Object? password = freezed,
    Object? privateKeyPath = freezed,
    Object? passphrase = freezed,
  }) {
    return _then(_$SshConfigImpl(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      privateKeyPath: freezed == privateKeyPath
          ? _value.privateKeyPath
          : privateKeyPath // ignore: cast_nullable_to_non_nullable
              as String?,
      passphrase: freezed == passphrase
          ? _value.passphrase
          : passphrase // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SshConfigImpl implements _SshConfig {
  const _$SshConfigImpl(
      {@HiveField(0) required this.host,
      @HiveField(1) this.port = 22,
      @HiveField(2) required this.username,
      @HiveField(3) this.password,
      @HiveField(4) this.privateKeyPath,
      @HiveField(5) this.passphrase});

  factory _$SshConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SshConfigImplFromJson(json);

  @override
  @HiveField(0)
  final String host;
  @override
  @JsonKey()
  @HiveField(1)
  final int port;
  @override
  @HiveField(2)
  final String username;
  @override
  @HiveField(3)
  final String? password;
  @override
  @HiveField(4)
  final String? privateKeyPath;
  @override
  @HiveField(5)
  final String? passphrase;

  @override
  String toString() {
    return 'SshConfig(host: $host, port: $port, username: $username, password: $password, privateKeyPath: $privateKeyPath, passphrase: $passphrase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SshConfigImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.privateKeyPath, privateKeyPath) ||
                other.privateKeyPath == privateKeyPath) &&
            (identical(other.passphrase, passphrase) ||
                other.passphrase == passphrase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, host, port, username, password, privateKeyPath, passphrase);

  /// Create a copy of SshConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SshConfigImplCopyWith<_$SshConfigImpl> get copyWith =>
      __$$SshConfigImplCopyWithImpl<_$SshConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SshConfigImplToJson(
      this,
    );
  }
}

abstract class _SshConfig implements SshConfig {
  const factory _SshConfig(
      {@HiveField(0) required final String host,
      @HiveField(1) final int port,
      @HiveField(2) required final String username,
      @HiveField(3) final String? password,
      @HiveField(4) final String? privateKeyPath,
      @HiveField(5) final String? passphrase}) = _$SshConfigImpl;

  factory _SshConfig.fromJson(Map<String, dynamic> json) =
      _$SshConfigImpl.fromJson;

  @override
  @HiveField(0)
  String get host;
  @override
  @HiveField(1)
  int get port;
  @override
  @HiveField(2)
  String get username;
  @override
  @HiveField(3)
  String? get password;
  @override
  @HiveField(4)
  String? get privateKeyPath;
  @override
  @HiveField(5)
  String? get passphrase;

  /// Create a copy of SshConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SshConfigImplCopyWith<_$SshConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
