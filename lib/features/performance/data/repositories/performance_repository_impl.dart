import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/performance/data/datasources/performance_remote_datasource.dart';
import 'package:recliq_agent/features/performance/domain/entities/performance_data.dart';
import 'package:recliq_agent/features/performance/domain/repositories/performance_repository.dart';

@LazySingleton(as: PerformanceRepository)
class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceRemoteDataSource _remoteDataSource;

  PerformanceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PerformanceData>> getPerformanceData() async {
    try {
      final result = await _remoteDataSource.getPerformanceData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RankTierInfo>>> getRankTiers() async {
    try {
      final result = await _remoteDataSource.getRankTiers();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
