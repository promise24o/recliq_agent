import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/constants/app_config.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/auth/domain/entities/auth_response.dart';
import 'package:recliq_agent/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<OtpResponse> register({
    required String name,
    required String identifier,
    required String password,
    String? referralCode,
  });

  Future<OtpResponse> login({
    required String identifier,
    required String password,
  });

  Future<AuthResponse> verifyOtp({
    required String identifier,
    required String otp,
  });

  Future<OtpResponse> resendOtp({required String identifier});

  Future<TokenResponse> refreshToken({required String refreshToken});

  Future<ForgotPasswordResponse> forgotPassword({required String email});

  Future<AuthResponse> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });

  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<String> setupPin({required String pin});

  Future<String> updatePin({
    required String oldPin,
    required String newPin,
  });

  Future<String> forgotPin({
    required String email,
    required String otp,
    required String newPin,
  });

  Future<ForgotPasswordResponse> sendPinResetOtp({required String email});

  Future<User> getProfile();

  Future<String> updateProfile({
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

  Future<PhotoUploadResponse> uploadPhoto({required String filePath});

  Future<String> toggleBiometric({required bool enabled});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  Dio get _dio => _dioClient.dio;

  @override
  Future<OtpResponse> register({
    required String name,
    required String identifier,
    required String password,
    String? referralCode,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.registerEndpoint,
        data: {
          'name': name,
          'identifier': identifier,
          'password': password,
          'role': 'AGENT',
          if (referralCode != null) 'referralCode': referralCode,
        },
      );
      return OtpResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<OtpResponse> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.loginEndpoint,
        data: {
          'identifier': identifier,
          'password': password,
        },
      );
      return OtpResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<AuthResponse> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.verifyOtpEndpoint,
        data: {
          'identifier': identifier,
          'otp': otp,
        },
      );
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<OtpResponse> resendOtp({required String identifier}) async {
    try {
      final response = await _dio.post(
        AppConfig.resendOtpEndpoint,
        data: {'identifier': identifier},
      );
      return OtpResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<TokenResponse> refreshToken({required String refreshToken}) async {
    try {
      final response = await _dio.post(
        AppConfig.refreshTokenEndpoint,
        data: {'refreshToken': refreshToken},
      );
      return TokenResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.forgotPasswordEndpoint,
        data: {'email': email},
      );
      return ForgotPasswordResponse.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<AuthResponse> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.resetPasswordEndpoint,
        data: {
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        },
      );
      return AuthResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.changePasswordEndpoint,
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
      return response.data['message'] as String;
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<String> setupPin({required String pin}) async {
    try {
      final response = await _dio.post(
        AppConfig.setupPinEndpoint,
        data: {'pin': pin},
      );
      return response.data['message'] as String;
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<String> updatePin({
    required String oldPin,
    required String newPin,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.updatePinEndpoint,
        data: {'oldPin': oldPin, 'newPin': newPin},
      );
      return response.data['message'] as String;
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<String> forgotPin({
    required String email,
    required String otp,
    required String newPin,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.forgotPinEndpoint,
        data: {'email': email, 'otp': otp, 'newPin': newPin},
      );
      return response.data['message'] as String;
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ForgotPasswordResponse> sendPinResetOtp({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.sendPinResetOtpEndpoint,
        data: {'email': email},
      );
      return ForgotPasswordResponse.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      final response = await _dio.get(AppConfig.profileEndpoint);
      return User.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<String> updateProfile({
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
      final data = <String, dynamic>{};
      if (profilePhoto != null) data['profilePhoto'] = profilePhoto;
      if (phone != null) data['phone'] = phone;
      if (priceUpdates != null) data['priceUpdates'] = priceUpdates;
      if (loginEmails != null) data['loginEmails'] = loginEmails;
      if (coordinates != null) data['coordinates'] = coordinates;
      if (address != null) data['address'] = address;
      if (city != null) data['city'] = city;
      if (state != null) data['state'] = state;
      if (country != null) data['country'] = country;

      final response = await _dio.post(
        AppConfig.updateProfileEndpoint,
        data: data,
      );
      return response.data['message'] as String;
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PhotoUploadResponse> uploadPhoto({required String filePath}) async {
    try {
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(filePath),
      });
      final response = await _dio.post(
        AppConfig.uploadPhotoEndpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return PhotoUploadResponse.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<String> toggleBiometric({required bool enabled}) async {
    try {
      final response = await _dio.post(
        AppConfig.biometricEndpoint,
        data: {'enabled': enabled},
      );
      return response.data['message'] as String;
    } on DioException catch (e) {
      throw ServerException(
        message: _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  String _extractErrorMessage(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      return (e.response!.data as Map<String, dynamic>)['message']
              as String? ??
          'An unexpected error occurred';
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timed out. Please try again.';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection. Please check your network.';
    }
    return e.message ?? 'An unexpected error occurred';
  }
}
