// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerformanceDataImpl _$$PerformanceDataImplFromJson(
  Map<String, dynamic> json,
) => _$PerformanceDataImpl(
  performanceScore: (json['performanceScore'] as num?)?.toDouble() ?? 0.0,
  pickupsCompleted: (json['pickupsCompleted'] as num?)?.toInt() ?? 0,
  avgResponseTime: (json['avgResponseTime'] as num?)?.toDouble() ?? 0.0,
  completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
  disputeRate: (json['disputeRate'] as num?)?.toDouble() ?? 0.0,
  slaAdherence: (json['slaAdherence'] as num?)?.toDouble() ?? 0.0,
  earningsPerJob: (json['earningsPerJob'] as num?)?.toDouble() ?? 0.0,
  rankTier: json['rankTier'] as String? ?? 'Bronze',
  rankPosition: (json['rankPosition'] as num?)?.toInt() ?? 0,
  totalAgents: (json['totalAgents'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PerformanceDataImplToJson(
  _$PerformanceDataImpl instance,
) => <String, dynamic>{
  'performanceScore': instance.performanceScore,
  'pickupsCompleted': instance.pickupsCompleted,
  'avgResponseTime': instance.avgResponseTime,
  'completionRate': instance.completionRate,
  'disputeRate': instance.disputeRate,
  'slaAdherence': instance.slaAdherence,
  'earningsPerJob': instance.earningsPerJob,
  'rankTier': instance.rankTier,
  'rankPosition': instance.rankPosition,
  'totalAgents': instance.totalAgents,
};

_$RankTierInfoImpl _$$RankTierInfoImplFromJson(Map<String, dynamic> json) =>
    _$RankTierInfoImpl(
      name: json['name'] as String,
      commissionRate: (json['commissionRate'] as num).toDouble(),
      hasJobPriority: json['hasJobPriority'] as bool,
      enterpriseEligible: json['enterpriseEligible'] as bool,
      minScore: (json['minScore'] as num).toDouble(),
      bonusDescription: json['bonusDescription'] as String?,
    );

Map<String, dynamic> _$$RankTierInfoImplToJson(_$RankTierInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'commissionRate': instance.commissionRate,
      'hasJobPriority': instance.hasJobPriority,
      'enterpriseEligible': instance.enterpriseEligible,
      'minScore': instance.minScore,
      'bonusDescription': instance.bonusDescription,
    };
