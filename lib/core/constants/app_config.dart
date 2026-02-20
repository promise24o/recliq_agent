import 'package:flutter/material.dart';

class AppConfig {
  static const String appName = 'Recliq Agent';
  static const String baseUrl = 'http://10.0.2.2:5001';

  // API Endpoints - Auth
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String resendOtpEndpoint = '/auth/resend-otp';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String changePasswordEndpoint = '/auth/change-password';
  static const String setupPinEndpoint = '/auth/setup-pin';
  static const String updatePinEndpoint = '/auth/update-pin';
  static const String forgotPinEndpoint = '/auth/forgot-pin';
  static const String sendPinResetOtpEndpoint = '/auth/send-pin-reset-otp';
  static const String profileEndpoint = '/auth/me';
  static const String updateProfileEndpoint = '/auth/update-profile';
  static const String uploadPhotoEndpoint = '/auth/upload-photo';
  static const String biometricEndpoint = '/auth/biometric';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user';
  static const String pinKey = 'agent_pin';
  static const String biometricEnabledKey = 'biometric_enabled';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Animations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Curve defaultAnimationCurve = Curves.easeInOut;

  // Agent-specific
  static const String agentRole = 'AGENT';
  static const Duration inactivityTimeout = Duration(minutes: 5);
  static const int pinLength = 6;
}
