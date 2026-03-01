import 'package:flutter/material.dart';

class AppConfig {
  static const String appName = 'Recliq Agent';
  static const String baseUrl = 'https://0bfd-105-127-15-165.ngrok-free.app';
  // static const String baseUrl = 'http://10.0.2.2:5001';


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

  // API Endpoints - Agent Availability & Location
  static const String agentAvailabilityEndpoint = '/agent-availability';
  static const String onlineStatusEndpoint = '/agent-availability/online-status';
  static const String locationUpdateEndpoint = '/agent-availability/location';
  static const String wsLocationNamespace = '/agent-location';

  // Location Tracking
  static const int locationUpdateIntervalActive = 5; // seconds - on pickup
  static const int locationUpdateIntervalAvailable = 10; // seconds - nearby requests
  static const int locationUpdateIntervalIdle = 30; // seconds - no activity
  static const int locationUpdateIntervalLowBattery = 120; // seconds - battery < 20%
  static const int locationUpdateIntervalBackground = 300; // seconds - background only
  static const double locationAccuracyThreshold = 200.0; // meters - reject if worse
  static const double locationStationaryThreshold = 50.0; // meters - pause if not moved

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
