import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/performance/domain/entities/performance_data.dart';

abstract class PerformanceRemoteDataSource {
  Future<PerformanceData> getPerformanceData();
  Future<List<RankTierInfo>> getRankTiers();
}

@LazySingleton(as: PerformanceRemoteDataSource)
class PerformanceRemoteDataSourceImpl implements PerformanceRemoteDataSource {
  final DioClient _dioClient;

  PerformanceRemoteDataSourceImpl(this._dioClient);

  @override
  Future<PerformanceData> getPerformanceData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const PerformanceData(
      performanceScore: 87.5,
      pickupsCompleted: 342,
      avgResponseTime: 4.2,
      completionRate: 96.5,
      disputeRate: 1.2,
      slaAdherence: 94.8,
      earningsPerJob: 1315.0,
      rankTier: 'Silver',
      rankPosition: 23,
      totalAgents: 150,
    );
  }

  @override
  Future<List<RankTierInfo>> getRankTiers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      RankTierInfo(
        name: 'Bronze',
        commissionRate: 20.0,
        hasJobPriority: false,
        enterpriseEligible: false,
        minScore: 0.0,
      ),
      RankTierInfo(
        name: 'Silver',
        commissionRate: 15.0,
        hasJobPriority: true,
        enterpriseEligible: false,
        minScore: 60.0,
        bonusDescription: 'Priority job access',
      ),
      RankTierInfo(
        name: 'Gold',
        commissionRate: 10.0,
        hasJobPriority: true,
        enterpriseEligible: true,
        minScore: 80.0,
        bonusDescription: 'Enterprise jobs + bonus incentives',
      ),
      RankTierInfo(
        name: 'Platinum',
        commissionRate: 7.0,
        hasJobPriority: true,
        enterpriseEligible: true,
        minScore: 95.0,
        bonusDescription: 'Lowest commission + all perks',
      ),
    ];
  }
}
