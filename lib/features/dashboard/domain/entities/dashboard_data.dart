import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';
part 'dashboard_data.g.dart';

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    @Default(0.0) double availableBalance,
    @Default(0.0) double pendingBalance,
    @Default(0.0) double commissionToday,
    @Default(0.0) double earningsToday,
    @Default(0) int activeJobs,
    @Default(0) int nearbyRequests,
    @Default(0) int completedToday,
    @Default(0.0) double performanceScore,
    String? nextScheduledPickup,
    @Default('Bronze') String rankTier,
    @Default(true) bool isOnline,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
}

@freezed
class AgentStats with _$AgentStats {
  const factory AgentStats({
    @Default(0) int totalPickups,
    @Default(0) int totalCustomers,
    @Default(0.0) double totalEarnings,
    @Default(0.0) double totalCommission,
    @Default(0.0) double avgResponseTime,
    @Default(0.0) double completionRate,
    @Default(0.0) double disputeRate,
    @Default(0.0) double slaAdherence,
  }) = _AgentStats;

  factory AgentStats.fromJson(Map<String, dynamic> json) =>
      _$AgentStatsFromJson(json);
}
