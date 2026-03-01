import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:recliq_agent/features/activity/domain/entities/activity_log.dart';
import 'package:recliq_agent/features/activity/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource _remoteDataSource;

  ActivityRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ActivityLogResponse>> getActivityLogs({
    ActionType? action,
    RiskLevel? riskLevel,
    Source? source,
    Outcome? outcome,
    EntityType? entityType,
    DateTime? dateFrom,
    DateTime? dateTo,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      print("Repository: Calling remote data source");
      final result = await _remoteDataSource.getActivityLogs(
        action: action?.name,
        riskLevel: riskLevel?.name,
        source: source?.name,
        outcome: outcome?.name,
        entityType: entityType?.name,
        dateFrom: dateFrom,
        dateTo: dateTo,
        page: page,
        limit: limit,
      );
      
      print("Repository: Success with ${result.logs.length} logs");
      return Right(result);
    } catch (e) {
      print("Repository error: $e");
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
