import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/auth/domain/entities/user.dart';
import 'package:recliq_agent/features/auth/domain/repositories/auth_repository.dart';

@injectable
class GetProfileUseCase {
  final AuthRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<Failure, User>> call() {
    return _repository.getProfile();
  }
}
