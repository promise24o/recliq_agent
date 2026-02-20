import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/auth/domain/entities/auth_response.dart';
import 'package:recliq_agent/features/auth/domain/repositories/auth_repository.dart';

@injectable
class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<Either<Failure, AuthResponse>> call({
    required String identifier,
    required String otp,
  }) {
    return _repository.verifyOtp(
      identifier: identifier,
      otp: otp,
    );
  }
}
