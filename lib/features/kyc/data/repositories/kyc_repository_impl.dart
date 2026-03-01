import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/kyc_status.dart';
import '../../domain/entities/bank.dart';
import '../../domain/entities/kyc_request.dart';
import '../../domain/repositories/kyc_repository.dart';

class KycRepositoryImpl implements KycRepository {
  final DioClient _dioClient;

  KycRepositoryImpl(this._dioClient);

  @override
  Future<Either<String, KycStatusEntity>> initializeKyc({
    required String userId,
    required KycUserType userType,
  }) async {
    try {
      final response = await _dioClient.post(
        '/kyc/initialize',
        data: {
          'userId': userId,
          'userType': userType.toJson(),
        },
      );
      return Right(KycStatusEntity.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return Left(_getErrorMessage(e));
    } catch (e) {
      return Left('Failed to initialize KYC: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, KycStatusEntity>> getKycStatus(String userId) async {
    try {
      final response = await _dioClient.get('/kyc/status', queryParameters: {
        'userId': userId,
      });
      return Right(KycStatusEntity.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return Left(_getErrorMessage(e));
    } catch (e) {
      return Left('Failed to load KYC status: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<Bank>>> getBanks() async {
    try {
      final response = await _dioClient.get('/kyc/banks');
      final banks = (response.data as List)
          .map((json) => Bank.fromJson(json as Map<String, dynamic>))
          .toList();
      return Right(banks);
    } on DioException catch (e) {
      return Left(_getErrorMessage(e));
    } catch (e) {
      return Left('Failed to load banks: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> resolveBankAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      final response = await _dioClient.post(
        '/kyc/account/resolve',
        data: {
          'accountNumber': accountNumber,
          'bankCode': bankCode,
        },
      );
      return Right(response.data['account_name'] as String);
    } on DioException catch (e) {
      return Left(_getErrorMessage(e));
    } catch (e) {
      return Left('Failed to resolve account: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> verifyBvn(VerifyBvnRequest request) async {
    try {
      final response = await _dioClient.post(
        '/kyc/bvn/verify',
        data: request.toJson(),
      );
      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return Left(_getErrorMessage(e));
    } catch (e) {
      return Left('Failed to verify BVN: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> uploadDocument({
    required UploadDocumentRequest request,
    required File document,
  }) async {
    try {
      final formData = FormData.fromMap({
        'userId': request.userId,
        'documentType': request.documentType,
        'document': await MultipartFile.fromFile(
          document.path,
          filename: document.path.split('/').last,
        ),
      });

      final response = await _dioClient.dio.post(
        '/kyc/documents/upload',
        data: formData,
      );
      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return Left(_getErrorMessage(e));
    } catch (e) {
      return Left('Failed to upload document: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> uploadSelfie({
    required UploadSelfieRequest request,
    required File selfie,
  }) async {
    try {
      final formData = FormData.fromMap({
        'userId': request.userId,
        'selfie': await MultipartFile.fromFile(
          selfie.path,
          filename: selfie.path.split('/').last,
        ),
      });

      final response = await _dioClient.dio.post(
        '/kyc/selfie/upload',
        data: formData,
      );
      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return Left(_getErrorMessage(e));
    } catch (e) {
      return Left('Failed to upload selfie: ${e.toString()}');
    }
  }

  String _getErrorMessage(DioException e) {
    if (e.response?.statusCode == 404) {
      return 'KYC service not found';
    } else if (e.response?.statusCode == 400) {
      return e.response?.data['message'] ?? 'Invalid request';
    } else if (e.response?.statusCode == 401) {
      return 'Unauthorized access';
    } else if (e.response?.statusCode == 500) {
      return 'Server error occurred';
    } else {
      return 'Network error: ${e.message}';
    }
  }
}
