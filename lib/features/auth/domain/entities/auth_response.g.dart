// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      requiresOtp: json['requiresOtp'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'requiresOtp': instance.requiresOtp,
    };

_$OtpResponseImpl _$$OtpResponseImplFromJson(Map<String, dynamic> json) =>
    _$OtpResponseImpl(
      message: json['message'] as String?,
      requiresOtp: json['requiresOtp'] as bool? ?? true,
    );

Map<String, dynamic> _$$OtpResponseImplToJson(_$OtpResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'requiresOtp': instance.requiresOtp,
    };

_$ForgotPasswordResponseImpl _$$ForgotPasswordResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForgotPasswordResponseImpl(
  message: json['message'] as String?,
  email: json['email'] as String?,
  expiresIn: (json['expires_in'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ForgotPasswordResponseImplToJson(
  _$ForgotPasswordResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'email': instance.email,
  'expires_in': instance.expiresIn,
};

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) =>
    _$TokenResponseImpl(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_$PhotoUploadResponseImpl _$$PhotoUploadResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PhotoUploadResponseImpl(
  message: json['message'] as String?,
  profilePhoto: json['profilePhoto'] as String?,
);

Map<String, dynamic> _$$PhotoUploadResponseImplToJson(
  _$PhotoUploadResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'profilePhoto': instance.profilePhoto,
};
