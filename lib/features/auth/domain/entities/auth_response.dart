import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recliq_agent/features/auth/domain/entities/user.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String message,
    User? user,
    String? accessToken,
    String? refreshToken,
    @Default(false) bool requiresOtp,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
class OtpResponse with _$OtpResponse {
  const factory OtpResponse({
    required String message,
    @Default(true) bool requiresOtp,
  }) = _OtpResponse;

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);
}

@freezed
class ForgotPasswordResponse with _$ForgotPasswordResponse {
  const factory ForgotPasswordResponse({
    required String message,
    String? email,
    @JsonKey(name: 'expires_in') int? expiresIn,
  }) = _ForgotPasswordResponse;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@freezed
class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required String accessToken,
    required String refreshToken,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}

@freezed
class PhotoUploadResponse with _$PhotoUploadResponse {
  const factory PhotoUploadResponse({
    required String message,
    required String profilePhoto,
  }) = _PhotoUploadResponse;

  factory PhotoUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotoUploadResponseFromJson(json);
}
