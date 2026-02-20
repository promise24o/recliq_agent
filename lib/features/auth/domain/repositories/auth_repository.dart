import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/auth/domain/entities/auth_response.dart';
import 'package:recliq_agent/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, OtpResponse>> register({
    required String name,
    required String identifier,
    required String password,
    String? referralCode,
  });

  Future<Either<Failure, OtpResponse>> login({
    required String identifier,
    required String password,
  });

  Future<Either<Failure, AuthResponse>> verifyOtp({
    required String identifier,
    required String otp,
  });

  Future<Either<Failure, OtpResponse>> resendOtp({
    required String identifier,
  });

  Future<Either<Failure, TokenResponse>> refreshToken({
    required String refreshToken,
  });

  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, AuthResponse>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });

  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Either<Failure, String>> setupPin({
    required String pin,
  });

  Future<Either<Failure, String>> updatePin({
    required String oldPin,
    required String newPin,
  });

  Future<Either<Failure, String>> forgotPin({
    required String email,
    required String otp,
    required String newPin,
  });

  Future<Either<Failure, ForgotPasswordResponse>> sendPinResetOtp({
    required String email,
  });

  Future<Either<Failure, User>> getProfile();

  Future<Either<Failure, String>> updateProfile({
    String? profilePhoto,
    String? phone,
    bool? priceUpdates,
    bool? loginEmails,
    List<double>? coordinates,
    String? address,
    String? city,
    String? state,
    String? country,
  });

  Future<Either<Failure, PhotoUploadResponse>> uploadPhoto({
    required String filePath,
  });

  Future<Either<Failure, String>> toggleBiometric({
    required bool enabled,
  });

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, String?>> getSavedToken();
}
