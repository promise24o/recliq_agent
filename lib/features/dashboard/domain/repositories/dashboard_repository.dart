import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/dashboard/domain/entities/dashboard_data.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardData>> getDashboardData();
  Future<Either<Failure, AgentStats>> getAgentStats();
  Future<Either<Failure, void>> toggleOnlineStatus(bool isOnline);
}
