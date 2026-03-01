import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/activity/domain/entities/activity_log.dart';

abstract class ActivityRepository {
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
  });
}
