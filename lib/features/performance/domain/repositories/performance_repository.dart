import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/performance/domain/entities/performance_data.dart';

abstract class PerformanceRepository {
  Future<Either<Failure, PerformanceData>> getPerformanceData();
  Future<Either<Failure, List<RankTierInfo>>> getRankTiers();
}
