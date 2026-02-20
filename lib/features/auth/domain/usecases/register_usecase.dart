import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/auth/domain/entities/auth_response.dart';
import 'package:recliq_agent/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, OtpResponse>> call({
    required String name,
    required String identifier,
    required String password,
    String? referralCode,
  }) {
    return _repository.register(
      name: name,
      identifier: identifier,
      password: password,
      referralCode: referralCode,
    );
  }
}
