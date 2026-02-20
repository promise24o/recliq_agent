// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardDataImpl _$$DashboardDataImplFromJson(Map<String, dynamic> json) =>
    _$DashboardDataImpl(
      availableBalance: (json['availableBalance'] as num?)?.toDouble() ?? 0.0,
      pendingBalance: (json['pendingBalance'] as num?)?.toDouble() ?? 0.0,
      commissionToday: (json['commissionToday'] as num?)?.toDouble() ?? 0.0,
      earningsToday: (json['earningsToday'] as num?)?.toDouble() ?? 0.0,
      activeJobs: (json['activeJobs'] as num?)?.toInt() ?? 0,
      nearbyRequests: (json['nearbyRequests'] as num?)?.toInt() ?? 0,
      completedToday: (json['completedToday'] as num?)?.toInt() ?? 0,
      performanceScore: (json['performanceScore'] as num?)?.toDouble() ?? 0.0,
      nextScheduledPickup: json['nextScheduledPickup'] as String?,
      rankTier: json['rankTier'] as String? ?? 'Bronze',
      isOnline: json['isOnline'] as bool? ?? true,
    );

Map<String, dynamic> _$$DashboardDataImplToJson(_$DashboardDataImpl instance) =>
    <String, dynamic>{
      'availableBalance': instance.availableBalance,
      'pendingBalance': instance.pendingBalance,
      'commissionToday': instance.commissionToday,
      'earningsToday': instance.earningsToday,
      'activeJobs': instance.activeJobs,
      'nearbyRequests': instance.nearbyRequests,
      'completedToday': instance.completedToday,
      'performanceScore': instance.performanceScore,
      'nextScheduledPickup': instance.nextScheduledPickup,
      'rankTier': instance.rankTier,
      'isOnline': instance.isOnline,
    };

_$AgentStatsImpl _$$AgentStatsImplFromJson(Map<String, dynamic> json) =>
    _$AgentStatsImpl(
      totalPickups: (json['totalPickups'] as num?)?.toInt() ?? 0,
      totalCustomers: (json['totalCustomers'] as num?)?.toInt() ?? 0,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      totalCommission: (json['totalCommission'] as num?)?.toDouble() ?? 0.0,
      avgResponseTime: (json['avgResponseTime'] as num?)?.toDouble() ?? 0.0,
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
      disputeRate: (json['disputeRate'] as num?)?.toDouble() ?? 0.0,
      slaAdherence: (json['slaAdherence'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$AgentStatsImplToJson(_$AgentStatsImpl instance) =>
    <String, dynamic>{
      'totalPickups': instance.totalPickups,
      'totalCustomers': instance.totalCustomers,
      'totalEarnings': instance.totalEarnings,
      'totalCommission': instance.totalCommission,
      'avgResponseTime': instance.avgResponseTime,
      'completionRate': instance.completionRate,
      'disputeRate': instance.disputeRate,
      'slaAdherence': instance.slaAdherence,
    };
