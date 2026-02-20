import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_data.freezed.dart';
part 'performance_data.g.dart';

@freezed
class PerformanceData with _$PerformanceData {
  const factory PerformanceData({
    @Default(0.0) double performanceScore,
    @Default(0) int pickupsCompleted,
    @Default(0.0) double avgResponseTime,
    @Default(0.0) double completionRate,
    @Default(0.0) double disputeRate,
    @Default(0.0) double slaAdherence,
    @Default(0.0) double earningsPerJob,
    @Default('Bronze') String rankTier,
    @Default(0) int rankPosition,
    @Default(0) int totalAgents,
  }) = _PerformanceData;

  factory PerformanceData.fromJson(Map<String, dynamic> json) =>
      _$PerformanceDataFromJson(json);
}

@freezed
class RankTierInfo with _$RankTierInfo {
  const factory RankTierInfo({
    required String name,
    required double commissionRate,
    required bool hasJobPriority,
    required bool enterpriseEligible,
    required double minScore,
    String? bonusDescription,
  }) = _RankTierInfo;

  factory RankTierInfo.fromJson(Map<String, dynamic> json) =>
      _$RankTierInfoFromJson(json);
}
