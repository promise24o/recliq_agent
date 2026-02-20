import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/auth/domain/entities/auth_response.dart';
import 'package:recliq_agent/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, OtpResponse>> call({
    required String identifier,
    required String password,
  }) {
    return _repository.login(
      identifier: identifier,
      password: password,
    );
  }
}
