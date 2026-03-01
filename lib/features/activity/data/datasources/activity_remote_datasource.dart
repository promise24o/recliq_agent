import 'package:recliq_agent/features/activity/domain/entities/activity_log.dart';

abstract class ActivityRemoteDataSource {
  Future<ActivityLogResponse> getActivityLogs({
    String? action,
    String? riskLevel,
    String? source,
    String? outcome,
    String? entityType,
    DateTime? dateFrom,
    DateTime? dateTo,
    int page = 1,
    int limit = 20,
  });
}
