// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return _AuthResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthResponse {
  String? get message => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  bool get requiresOtp => throw _privateConstructorUsedError;

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResponseCopyWith<AuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponseCopyWith<$Res> {
  factory $AuthResponseCopyWith(
    AuthResponse value,
    $Res Function(AuthResponse) then,
  ) = _$AuthResponseCopyWithImpl<$Res, AuthResponse>;
  @useResult
  $Res call({
    String? message,
    User? user,
    String? accessToken,
    String? refreshToken,
    bool requiresOtp,
  });

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuthResponseCopyWithImpl<$Res, $Val extends AuthResponse>
    implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? user = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? requiresOtp = null,
  }) {
    return _then(
      _value.copyWith(
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as User?,
            accessToken: freezed == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            refreshToken: freezed == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiresOtp: null == requiresOtp
                ? _value.requiresOtp
                : requiresOtp // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthResponseImplCopyWith<$Res>
    implements $AuthResponseCopyWith<$Res> {
  factory _$$AuthResponseImplCopyWith(
    _$AuthResponseImpl value,
    $Res Function(_$AuthResponseImpl) then,
  ) = __$$AuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? message,
    User? user,
    String? accessToken,
    String? refreshToken,
    bool requiresOtp,
  });

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AuthResponseImplCopyWithImpl<$Res>
    extends _$AuthResponseCopyWithImpl<$Res, _$AuthResponseImpl>
    implements _$$AuthResponseImplCopyWith<$Res> {
  __$$AuthResponseImplCopyWithImpl(
    _$AuthResponseImpl _value,
    $Res Function(_$AuthResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? user = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? requiresOtp = null,
  }) {
    return _then(
      _$AuthResponseImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User?,
        accessToken: freezed == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        refreshToken: freezed == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiresOtp: null == requiresOtp
            ? _value.requiresOtp
            : requiresOtp // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthResponseImpl implements _AuthResponse {
  const _$AuthResponseImpl({
    this.message,
    this.user,
    this.accessToken,
    this.refreshToken,
    this.requiresOtp = false,
  });

  factory _$AuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final User? user;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  @JsonKey()
  final bool requiresOtp;

  @override
  String toString() {
    return 'AuthResponse(message: $message, user: $user, accessToken: $accessToken, refreshToken: $refreshToken, requiresOtp: $requiresOtp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.requiresOtp, requiresOtp) ||
                other.requiresOtp == requiresOtp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    user,
    accessToken,
    refreshToken,
    requiresOtp,
  );

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      __$$AuthResponseImplCopyWithImpl<_$AuthResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthResponseImplToJson(this);
  }
}

abstract class _AuthResponse implements AuthResponse {
  const factory _AuthResponse({
    final String? message,
    final User? user,
    final String? accessToken,
    final String? refreshToken,
    final bool requiresOtp,
  }) = _$AuthResponseImpl;

  factory _AuthResponse.fromJson(Map<String, dynamic> json) =
      _$AuthResponseImpl.fromJson;

  @override
  String? get message;
  @override
  User? get user;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  bool get requiresOtp;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) {
  return _OtpResponse.fromJson(json);
}

/// @nodoc
mixin _$OtpResponse {
  String? get message => throw _privateConstructorUsedError;
  bool get requiresOtp => throw _privateConstructorUsedError;

  /// Serializes this OtpResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpResponseCopyWith<OtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpResponseCopyWith<$Res> {
  factory $OtpResponseCopyWith(
    OtpResponse value,
    $Res Function(OtpResponse) then,
  ) = _$OtpResponseCopyWithImpl<$Res, OtpResponse>;
  @useResult
  $Res call({String? message, bool requiresOtp});
}

/// @nodoc
class _$OtpResponseCopyWithImpl<$Res, $Val extends OtpResponse>
    implements $OtpResponseCopyWith<$Res> {
  _$OtpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? requiresOtp = null}) {
    return _then(
      _value.copyWith(
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiresOtp: null == requiresOtp
                ? _value.requiresOtp
                : requiresOtp // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpResponseImplCopyWith<$Res>
    implements $OtpResponseCopyWith<$Res> {
  factory _$$OtpResponseImplCopyWith(
    _$OtpResponseImpl value,
    $Res Function(_$OtpResponseImpl) then,
  ) = __$$OtpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, bool requiresOtp});
}

/// @nodoc
class __$$OtpResponseImplCopyWithImpl<$Res>
    extends _$OtpResponseCopyWithImpl<$Res, _$OtpResponseImpl>
    implements _$$OtpResponseImplCopyWith<$Res> {
  __$$OtpResponseImplCopyWithImpl(
    _$OtpResponseImpl _value,
    $Res Function(_$OtpResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? requiresOtp = null}) {
    return _then(
      _$OtpResponseImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiresOtp: null == requiresOtp
            ? _value.requiresOtp
            : requiresOtp // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpResponseImpl implements _OtpResponse {
  const _$OtpResponseImpl({this.message, this.requiresOtp = true});

  factory _$OtpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpResponseImplFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey()
  final bool requiresOtp;

  @override
  String toString() {
    return 'OtpResponse(message: $message, requiresOtp: $requiresOtp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.requiresOtp, requiresOtp) ||
                other.requiresOtp == requiresOtp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, requiresOtp);

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpResponseImplCopyWith<_$OtpResponseImpl> get copyWith =>
      __$$OtpResponseImplCopyWithImpl<_$OtpResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpResponseImplToJson(this);
  }
}

abstract class _OtpResponse implements OtpResponse {
  const factory _OtpResponse({final String? message, final bool requiresOtp}) =
      _$OtpResponseImpl;

  factory _OtpResponse.fromJson(Map<String, dynamic> json) =
      _$OtpResponseImpl.fromJson;

  @override
  String? get message;
  @override
  bool get requiresOtp;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpResponseImplCopyWith<_$OtpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ForgotPasswordResponse.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordResponse {
  String? get message => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  int? get expiresIn => throw _privateConstructorUsedError;

  /// Serializes this ForgotPasswordResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForgotPasswordResponseCopyWith<ForgotPasswordResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordResponseCopyWith<$Res> {
  factory $ForgotPasswordResponseCopyWith(
    ForgotPasswordResponse value,
    $Res Function(ForgotPasswordResponse) then,
  ) = _$ForgotPasswordResponseCopyWithImpl<$Res, ForgotPasswordResponse>;
  @useResult
  $Res call({
    String? message,
    String? email,
    @JsonKey(name: 'expires_in') int? expiresIn,
  });
}

/// @nodoc
class _$ForgotPasswordResponseCopyWithImpl<
  $Res,
  $Val extends ForgotPasswordResponse
>
    implements $ForgotPasswordResponseCopyWith<$Res> {
  _$ForgotPasswordResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? email = freezed,
    Object? expiresIn = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresIn: freezed == expiresIn
                ? _value.expiresIn
                : expiresIn // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForgotPasswordResponseImplCopyWith<$Res>
    implements $ForgotPasswordResponseCopyWith<$Res> {
  factory _$$ForgotPasswordResponseImplCopyWith(
    _$ForgotPasswordResponseImpl value,
    $Res Function(_$ForgotPasswordResponseImpl) then,
  ) = __$$ForgotPasswordResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? message,
    String? email,
    @JsonKey(name: 'expires_in') int? expiresIn,
  });
}

/// @nodoc
class __$$ForgotPasswordResponseImplCopyWithImpl<$Res>
    extends
        _$ForgotPasswordResponseCopyWithImpl<$Res, _$ForgotPasswordResponseImpl>
    implements _$$ForgotPasswordResponseImplCopyWith<$Res> {
  __$$ForgotPasswordResponseImplCopyWithImpl(
    _$ForgotPasswordResponseImpl _value,
    $Res Function(_$ForgotPasswordResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? email = freezed,
    Object? expiresIn = freezed,
  }) {
    return _then(
      _$ForgotPasswordResponseImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresIn: freezed == expiresIn
            ? _value.expiresIn
            : expiresIn // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotPasswordResponseImpl implements _ForgotPasswordResponse {
  const _$ForgotPasswordResponseImpl({
    this.message,
    this.email,
    @JsonKey(name: 'expires_in') this.expiresIn,
  });

  factory _$ForgotPasswordResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotPasswordResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final String? email;
  @override
  @JsonKey(name: 'expires_in')
  final int? expiresIn;

  @override
  String toString() {
    return 'ForgotPasswordResponse(message: $message, email: $email, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, email, expiresIn);

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordResponseImplCopyWith<_$ForgotPasswordResponseImpl>
  get copyWith =>
      __$$ForgotPasswordResponseImplCopyWithImpl<_$ForgotPasswordResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordResponseImplToJson(this);
  }
}

abstract class _ForgotPasswordResponse implements ForgotPasswordResponse {
  const factory _ForgotPasswordResponse({
    final String? message,
    final String? email,
    @JsonKey(name: 'expires_in') final int? expiresIn,
  }) = _$ForgotPasswordResponseImpl;

  factory _ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =
      _$ForgotPasswordResponseImpl.fromJson;

  @override
  String? get message;
  @override
  String? get email;
  @override
  @JsonKey(name: 'expires_in')
  int? get expiresIn;

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordResponseImplCopyWith<_$ForgotPasswordResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return _TokenResponse.fromJson(json);
}

/// @nodoc
mixin _$TokenResponse {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this TokenResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseCopyWith<TokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseCopyWith<$Res> {
  factory $TokenResponseCopyWith(
    TokenResponse value,
    $Res Function(TokenResponse) then,
  ) = _$TokenResponseCopyWithImpl<$Res, TokenResponse>;
  @useResult
  $Res call({String? accessToken, String? refreshToken});
}

/// @nodoc
class _$TokenResponseCopyWithImpl<$Res, $Val extends TokenResponse>
    implements $TokenResponseCopyWith<$Res> {
  _$TokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = freezed, Object? refreshToken = freezed}) {
    return _then(
      _value.copyWith(
            accessToken: freezed == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            refreshToken: freezed == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenResponseImplCopyWith<$Res>
    implements $TokenResponseCopyWith<$Res> {
  factory _$$TokenResponseImplCopyWith(
    _$TokenResponseImpl value,
    $Res Function(_$TokenResponseImpl) then,
  ) = __$$TokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? accessToken, String? refreshToken});
}

/// @nodoc
class __$$TokenResponseImplCopyWithImpl<$Res>
    extends _$TokenResponseCopyWithImpl<$Res, _$TokenResponseImpl>
    implements _$$TokenResponseImplCopyWith<$Res> {
  __$$TokenResponseImplCopyWithImpl(
    _$TokenResponseImpl _value,
    $Res Function(_$TokenResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = freezed, Object? refreshToken = freezed}) {
    return _then(
      _$TokenResponseImpl(
        accessToken: freezed == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        refreshToken: freezed == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenResponseImpl implements _TokenResponse {
  const _$TokenResponseImpl({this.accessToken, this.refreshToken});

  factory _$TokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenResponseImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? refreshToken;

  @override
  String toString() {
    return 'TokenResponse(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      __$$TokenResponseImplCopyWithImpl<_$TokenResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenResponseImplToJson(this);
  }
}

abstract class _TokenResponse implements TokenResponse {
  const factory _TokenResponse({
    final String? accessToken,
    final String? refreshToken,
  }) = _$TokenResponseImpl;

  factory _TokenResponse.fromJson(Map<String, dynamic> json) =
      _$TokenResponseImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get refreshToken;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhotoUploadResponse _$PhotoUploadResponseFromJson(Map<String, dynamic> json) {
  return _PhotoUploadResponse.fromJson(json);
}

/// @nodoc
mixin _$PhotoUploadResponse {
  String? get message => throw _privateConstructorUsedError;
  String? get profilePhoto => throw _privateConstructorUsedError;

  /// Serializes this PhotoUploadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhotoUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoUploadResponseCopyWith<PhotoUploadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoUploadResponseCopyWith<$Res> {
  factory $PhotoUploadResponseCopyWith(
    PhotoUploadResponse value,
    $Res Function(PhotoUploadResponse) then,
  ) = _$PhotoUploadResponseCopyWithImpl<$Res, PhotoUploadResponse>;
  @useResult
  $Res call({String? message, String? profilePhoto});
}

/// @nodoc
class _$PhotoUploadResponseCopyWithImpl<$Res, $Val extends PhotoUploadResponse>
    implements $PhotoUploadResponseCopyWith<$Res> {
  _$PhotoUploadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? profilePhoto = freezed}) {
    return _then(
      _value.copyWith(
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            profilePhoto: freezed == profilePhoto
                ? _value.profilePhoto
                : profilePhoto // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhotoUploadResponseImplCopyWith<$Res>
    implements $PhotoUploadResponseCopyWith<$Res> {
  factory _$$PhotoUploadResponseImplCopyWith(
    _$PhotoUploadResponseImpl value,
    $Res Function(_$PhotoUploadResponseImpl) then,
  ) = __$$PhotoUploadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, String? profilePhoto});
}

/// @nodoc
class __$$PhotoUploadResponseImplCopyWithImpl<$Res>
    extends _$PhotoUploadResponseCopyWithImpl<$Res, _$PhotoUploadResponseImpl>
    implements _$$PhotoUploadResponseImplCopyWith<$Res> {
  __$$PhotoUploadResponseImplCopyWithImpl(
    _$PhotoUploadResponseImpl _value,
    $Res Function(_$PhotoUploadResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhotoUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? profilePhoto = freezed}) {
    return _then(
      _$PhotoUploadResponseImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        profilePhoto: freezed == profilePhoto
            ? _value.profilePhoto
            : profilePhoto // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoUploadResponseImpl implements _PhotoUploadResponse {
  const _$PhotoUploadResponseImpl({this.message, this.profilePhoto});

  factory _$PhotoUploadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoUploadResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final String? profilePhoto;

  @override
  String toString() {
    return 'PhotoUploadResponse(message: $message, profilePhoto: $profilePhoto)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoUploadResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, profilePhoto);

  /// Create a copy of PhotoUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoUploadResponseImplCopyWith<_$PhotoUploadResponseImpl> get copyWith =>
      __$$PhotoUploadResponseImplCopyWithImpl<_$PhotoUploadResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoUploadResponseImplToJson(this);
  }
}

abstract class _PhotoUploadResponse implements PhotoUploadResponse {
  const factory _PhotoUploadResponse({
    final String? message,
    final String? profilePhoto,
  }) = _$PhotoUploadResponseImpl;

  factory _PhotoUploadResponse.fromJson(Map<String, dynamic> json) =
      _$PhotoUploadResponseImpl.fromJson;

  @override
  String? get message;
  @override
  String? get profilePhoto;

  /// Create a copy of PhotoUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoUploadResponseImplCopyWith<_$PhotoUploadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
