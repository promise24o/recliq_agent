import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:recliq_agent/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:recliq_agent/features/dashboard/domain/repositories/dashboard_repository.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, DashboardData>> getDashboardData() async {
    try {
      final result = await _remoteDataSource.getDashboardData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AgentStats>> getAgentStats() async {
    try {
      final result = await _remoteDataSource.getAgentStats();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleOnlineStatus(bool isOnline) async {
    try {
      await _remoteDataSource.toggleOnlineStatus(isOnline);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
