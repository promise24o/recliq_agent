import 'dart:io';
import 'package:dartz/dartz.dart';
import '../entities/kyc_status.dart';
import '../entities/bank.dart';
import '../entities/kyc_request.dart';

abstract class KycRepository {
  Future<Either<String, KycStatusEntity>> initializeKyc({
    required String userId,
    required KycUserType userType,
  });

  Future<Either<String, KycStatusEntity>> getKycStatus(String userId);

  Future<Either<String, List<Bank>>> getBanks();

  Future<Either<String, String>> resolveBankAccount({
    required String accountNumber,
    required String bankCode,
  });

  Future<Either<String, Map<String, dynamic>>> verifyBvn(VerifyBvnRequest request);

  Future<Either<String, Map<String, dynamic>>> uploadDocument({
    required UploadDocumentRequest request,
    required File document,
  });

  Future<Either<String, Map<String, dynamic>>> uploadSelfie({
    required UploadSelfieRequest request,
    required File selfie,
  });
}
