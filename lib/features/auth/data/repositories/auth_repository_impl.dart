import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/constants/app_config.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:recliq_agent/features/auth/domain/entities/auth_response.dart';
import 'package:recliq_agent/features/auth/domain/entities/user.dart';
import 'package:recliq_agent/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  @override
  Future<Either<Failure, OtpResponse>> register({
    required String name,
    required String identifier,
    required String password,
    String? referralCode,
  }) async {
    try {
      final result = await _remoteDataSource.register(
        name: name,
        identifier: identifier,
        password: password,
        referralCode: referralCode,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } on NetworkException catch (e) {
      return Left(Failure.networkError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OtpResponse>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(
        identifier: identifier,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } on NetworkException catch (e) {
      return Left(Failure.networkError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    try {
      final result = await _remoteDataSource.verifyOtp(
        identifier: identifier,
        otp: otp,
      );
      if (result.accessToken != null) {
        await _secureStorage.write(
          key: AppConfig.authTokenKey,
          value: result.accessToken,
        );
      }
      if (result.refreshToken != null) {
        await _secureStorage.write(
          key: AppConfig.refreshTokenKey,
          value: result.refreshToken,
        );
      }
      if (result.user != null) {
        await _secureStorage.write(
          key: AppConfig.userKey,
          value: jsonEncode(result.user!.toJson()),
        );
      }
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } on NetworkException catch (e) {
      return Left(Failure.networkError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OtpResponse>> resendOtp({
    required String identifier,
  }) async {
    try {
      final result = await _remoteDataSource.resendOtp(
        identifier: identifier,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenResponse>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final result = await _remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );
      await _secureStorage.write(
        key: AppConfig.authTokenKey,
        value: result.accessToken,
      );
      await _secureStorage.write(
        key: AppConfig.refreshTokenKey,
        value: result.refreshToken,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword({
    required String email,
  }) async {
    try {
      final result = await _remoteDataSource.forgotPassword(email: email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final result = await _remoteDataSource.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      if (result.accessToken != null) {
        await _secureStorage.write(
          key: AppConfig.authTokenKey,
          value: result.accessToken,
        );
      }
      if (result.refreshToken != null) {
        await _secureStorage.write(
          key: AppConfig.refreshTokenKey,
          value: result.refreshToken,
        );
      }
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final result = await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> setupPin({required String pin}) async {
    try {
      final result = await _remoteDataSource.setupPin(pin: pin);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updatePin({
    required String oldPin,
    required String newPin,
  }) async {
    try {
      final result = await _remoteDataSource.updatePin(
        oldPin: oldPin,
        newPin: newPin,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPin({
    required String email,
    required String otp,
    required String newPin,
  }) async {
    try {
      final result = await _remoteDataSource.forgotPin(
        email: email,
        otp: otp,
        newPin: newPin,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordResponse>> sendPinResetOtp({
    required String email,
  }) async {
    try {
      final result = await _remoteDataSource.sendPinResetOtp(email: email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    try {
      final result = await _remoteDataSource.getProfile();
      await _secureStorage.write(
        key: AppConfig.userKey,
        value: jsonEncode(result.toJson()),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final result = await _remoteDataSource.updateProfile(
        profilePhoto: profilePhoto,
        phone: phone,
        priceUpdates: priceUpdates,
        loginEmails: loginEmails,
        coordinates: coordinates,
        address: address,
        city: city,
        state: state,
        country: country,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhotoUploadResponse>> uploadPhoto({
    required String filePath,
  }) async {
    try {
      final result = await _remoteDataSource.uploadPhoto(filePath: filePath);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> toggleBiometric({
    required bool enabled,
  }) async {
    try {
      final result = await _remoteDataSource.toggleBiometric(enabled: enabled);
      await _secureStorage.write(
        key: AppConfig.biometricEnabledKey,
        value: enabled.toString(),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final token = await _secureStorage.read(key: AppConfig.authTokenKey);
      return Right(token != null && token.isNotEmpty);
    } catch (e) {
      return Left(Failure.cacheError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _secureStorage.deleteAll();
      return const Right(null);
    } catch (e) {
      return Left(Failure.cacheError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getSavedToken() async {
    try {
      final token = await _secureStorage.read(key: AppConfig.authTokenKey);
      return Right(token);
    } catch (e) {
      return Left(Failure.cacheError(e.toString()));
    }
  }
}
