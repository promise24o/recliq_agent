import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/dashboard/domain/entities/dashboard_data.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardData> getDashboardData();
  Future<AgentStats> getAgentStats();
  Future<void> toggleOnlineStatus(bool isOnline);
}

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient _dioClient;

  DashboardRemoteDataSourceImpl(this._dioClient);

  @override
  Future<DashboardData> getDashboardData() async {
    // TODO: Replace with actual API call when endpoint is available
    await Future.delayed(const Duration(milliseconds: 500));
    return const DashboardData(
      availableBalance: 125000.0,
      pendingBalance: 15000.0,
      commissionToday: 3500.0,
      earningsToday: 18500.0,
      activeJobs: 2,
      nearbyRequests: 5,
      completedToday: 8,
      performanceScore: 87.5,
      nextScheduledPickup: '2:30 PM Today',
      rankTier: 'Silver',
      isOnline: true,
    );
  }

  @override
  Future<AgentStats> getAgentStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const AgentStats(
      totalPickups: 342,
      totalCustomers: 89,
      totalEarnings: 450000.0,
      totalCommission: 67500.0,
      avgResponseTime: 4.2,
      completionRate: 96.5,
      disputeRate: 1.2,
      slaAdherence: 94.8,
    );
  }

  @override
  Future<void> toggleOnlineStatus(bool isOnline) async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
