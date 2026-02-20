// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PerformanceData _$PerformanceDataFromJson(Map<String, dynamic> json) {
  return _PerformanceData.fromJson(json);
}

/// @nodoc
mixin _$PerformanceData {
  double get performanceScore => throw _privateConstructorUsedError;
  int get pickupsCompleted => throw _privateConstructorUsedError;
  double get avgResponseTime => throw _privateConstructorUsedError;
  double get completionRate => throw _privateConstructorUsedError;
  double get disputeRate => throw _privateConstructorUsedError;
  double get slaAdherence => throw _privateConstructorUsedError;
  double get earningsPerJob => throw _privateConstructorUsedError;
  String get rankTier => throw _privateConstructorUsedError;
  int get rankPosition => throw _privateConstructorUsedError;
  int get totalAgents => throw _privateConstructorUsedError;

  /// Serializes this PerformanceData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PerformanceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerformanceDataCopyWith<PerformanceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceDataCopyWith<$Res> {
  factory $PerformanceDataCopyWith(
    PerformanceData value,
    $Res Function(PerformanceData) then,
  ) = _$PerformanceDataCopyWithImpl<$Res, PerformanceData>;
  @useResult
  $Res call({
    double performanceScore,
    int pickupsCompleted,
    double avgResponseTime,
    double completionRate,
    double disputeRate,
    double slaAdherence,
    double earningsPerJob,
    String rankTier,
    int rankPosition,
    int totalAgents,
  });
}

/// @nodoc
class _$PerformanceDataCopyWithImpl<$Res, $Val extends PerformanceData>
    implements $PerformanceDataCopyWith<$Res> {
  _$PerformanceDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerformanceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? performanceScore = null,
    Object? pickupsCompleted = null,
    Object? avgResponseTime = null,
    Object? completionRate = null,
    Object? disputeRate = null,
    Object? slaAdherence = null,
    Object? earningsPerJob = null,
    Object? rankTier = null,
    Object? rankPosition = null,
    Object? totalAgents = null,
  }) {
    return _then(
      _value.copyWith(
            performanceScore: null == performanceScore
                ? _value.performanceScore
                : performanceScore // ignore: cast_nullable_to_non_nullable
                      as double,
            pickupsCompleted: null == pickupsCompleted
                ? _value.pickupsCompleted
                : pickupsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            avgResponseTime: null == avgResponseTime
                ? _value.avgResponseTime
                : avgResponseTime // ignore: cast_nullable_to_non_nullable
                      as double,
            completionRate: null == completionRate
                ? _value.completionRate
                : completionRate // ignore: cast_nullable_to_non_nullable
                      as double,
            disputeRate: null == disputeRate
                ? _value.disputeRate
                : disputeRate // ignore: cast_nullable_to_non_nullable
                      as double,
            slaAdherence: null == slaAdherence
                ? _value.slaAdherence
                : slaAdherence // ignore: cast_nullable_to_non_nullable
                      as double,
            earningsPerJob: null == earningsPerJob
                ? _value.earningsPerJob
                : earningsPerJob // ignore: cast_nullable_to_non_nullable
                      as double,
            rankTier: null == rankTier
                ? _value.rankTier
                : rankTier // ignore: cast_nullable_to_non_nullable
                      as String,
            rankPosition: null == rankPosition
                ? _value.rankPosition
                : rankPosition // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAgents: null == totalAgents
                ? _value.totalAgents
                : totalAgents // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PerformanceDataImplCopyWith<$Res>
    implements $PerformanceDataCopyWith<$Res> {
  factory _$$PerformanceDataImplCopyWith(
    _$PerformanceDataImpl value,
    $Res Function(_$PerformanceDataImpl) then,
  ) = __$$PerformanceDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double performanceScore,
    int pickupsCompleted,
    double avgResponseTime,
    double completionRate,
    double disputeRate,
    double slaAdherence,
    double earningsPerJob,
    String rankTier,
    int rankPosition,
    int totalAgents,
  });
}

/// @nodoc
class __$$PerformanceDataImplCopyWithImpl<$Res>
    extends _$PerformanceDataCopyWithImpl<$Res, _$PerformanceDataImpl>
    implements _$$PerformanceDataImplCopyWith<$Res> {
  __$$PerformanceDataImplCopyWithImpl(
    _$PerformanceDataImpl _value,
    $Res Function(_$PerformanceDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PerformanceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? performanceScore = null,
    Object? pickupsCompleted = null,
    Object? avgResponseTime = null,
    Object? completionRate = null,
    Object? disputeRate = null,
    Object? slaAdherence = null,
    Object? earningsPerJob = null,
    Object? rankTier = null,
    Object? rankPosition = null,
    Object? totalAgents = null,
  }) {
    return _then(
      _$PerformanceDataImpl(
        performanceScore: null == performanceScore
            ? _value.performanceScore
            : performanceScore // ignore: cast_nullable_to_non_nullable
                  as double,
        pickupsCompleted: null == pickupsCompleted
            ? _value.pickupsCompleted
            : pickupsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        avgResponseTime: null == avgResponseTime
            ? _value.avgResponseTime
            : avgResponseTime // ignore: cast_nullable_to_non_nullable
                  as double,
        completionRate: null == completionRate
            ? _value.completionRate
            : completionRate // ignore: cast_nullable_to_non_nullable
                  as double,
        disputeRate: null == disputeRate
            ? _value.disputeRate
            : disputeRate // ignore: cast_nullable_to_non_nullable
                  as double,
        slaAdherence: null == slaAdherence
            ? _value.slaAdherence
            : slaAdherence // ignore: cast_nullable_to_non_nullable
                  as double,
        earningsPerJob: null == earningsPerJob
            ? _value.earningsPerJob
            : earningsPerJob // ignore: cast_nullable_to_non_nullable
                  as double,
        rankTier: null == rankTier
            ? _value.rankTier
            : rankTier // ignore: cast_nullable_to_non_nullable
                  as String,
        rankPosition: null == rankPosition
            ? _value.rankPosition
            : rankPosition // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAgents: null == totalAgents
            ? _value.totalAgents
            : totalAgents // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceDataImpl implements _PerformanceData {
  const _$PerformanceDataImpl({
    this.performanceScore = 0.0,
    this.pickupsCompleted = 0,
    this.avgResponseTime = 0.0,
    this.completionRate = 0.0,
    this.disputeRate = 0.0,
    this.slaAdherence = 0.0,
    this.earningsPerJob = 0.0,
    this.rankTier = 'Bronze',
    this.rankPosition = 0,
    this.totalAgents = 0,
  });

  factory _$PerformanceDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceDataImplFromJson(json);

  @override
  @JsonKey()
  final double performanceScore;
  @override
  @JsonKey()
  final int pickupsCompleted;
  @override
  @JsonKey()
  final double avgResponseTime;
  @override
  @JsonKey()
  final double completionRate;
  @override
  @JsonKey()
  final double disputeRate;
  @override
  @JsonKey()
  final double slaAdherence;
  @override
  @JsonKey()
  final double earningsPerJob;
  @override
  @JsonKey()
  final String rankTier;
  @override
  @JsonKey()
  final int rankPosition;
  @override
  @JsonKey()
  final int totalAgents;

  @override
  String toString() {
    return 'PerformanceData(performanceScore: $performanceScore, pickupsCompleted: $pickupsCompleted, avgResponseTime: $avgResponseTime, completionRate: $completionRate, disputeRate: $disputeRate, slaAdherence: $slaAdherence, earningsPerJob: $earningsPerJob, rankTier: $rankTier, rankPosition: $rankPosition, totalAgents: $totalAgents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceDataImpl &&
            (identical(other.performanceScore, performanceScore) ||
                other.performanceScore == performanceScore) &&
            (identical(other.pickupsCompleted, pickupsCompleted) ||
                other.pickupsCompleted == pickupsCompleted) &&
            (identical(other.avgResponseTime, avgResponseTime) ||
                other.avgResponseTime == avgResponseTime) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.disputeRate, disputeRate) ||
                other.disputeRate == disputeRate) &&
            (identical(other.slaAdherence, slaAdherence) ||
                other.slaAdherence == slaAdherence) &&
            (identical(other.earningsPerJob, earningsPerJob) ||
                other.earningsPerJob == earningsPerJob) &&
            (identical(other.rankTier, rankTier) ||
                other.rankTier == rankTier) &&
            (identical(other.rankPosition, rankPosition) ||
                other.rankPosition == rankPosition) &&
            (identical(other.totalAgents, totalAgents) ||
                other.totalAgents == totalAgents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    performanceScore,
    pickupsCompleted,
    avgResponseTime,
    completionRate,
    disputeRate,
    slaAdherence,
    earningsPerJob,
    rankTier,
    rankPosition,
    totalAgents,
  );

  /// Create a copy of PerformanceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceDataImplCopyWith<_$PerformanceDataImpl> get copyWith =>
      __$$PerformanceDataImplCopyWithImpl<_$PerformanceDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceDataImplToJson(this);
  }
}

abstract class _PerformanceData implements PerformanceData {
  const factory _PerformanceData({
    final double performanceScore,
    final int pickupsCompleted,
    final double avgResponseTime,
    final double completionRate,
    final double disputeRate,
    final double slaAdherence,
    final double earningsPerJob,
    final String rankTier,
    final int rankPosition,
    final int totalAgents,
  }) = _$PerformanceDataImpl;

  factory _PerformanceData.fromJson(Map<String, dynamic> json) =
      _$PerformanceDataImpl.fromJson;

  @override
  double get performanceScore;
  @override
  int get pickupsCompleted;
  @override
  double get avgResponseTime;
  @override
  double get completionRate;
  @override
  double get disputeRate;
  @override
  double get slaAdherence;
  @override
  double get earningsPerJob;
  @override
  String get rankTier;
  @override
  int get rankPosition;
  @override
  int get totalAgents;

  /// Create a copy of PerformanceData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerformanceDataImplCopyWith<_$PerformanceDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RankTierInfo _$RankTierInfoFromJson(Map<String, dynamic> json) {
  return _RankTierInfo.fromJson(json);
}

/// @nodoc
mixin _$RankTierInfo {
  String get name => throw _privateConstructorUsedError;
  double get commissionRate => throw _privateConstructorUsedError;
  bool get hasJobPriority => throw _privateConstructorUsedError;
  bool get enterpriseEligible => throw _privateConstructorUsedError;
  double get minScore => throw _privateConstructorUsedError;
  String? get bonusDescription => throw _privateConstructorUsedError;

  /// Serializes this RankTierInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RankTierInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RankTierInfoCopyWith<RankTierInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankTierInfoCopyWith<$Res> {
  factory $RankTierInfoCopyWith(
    RankTierInfo value,
    $Res Function(RankTierInfo) then,
  ) = _$RankTierInfoCopyWithImpl<$Res, RankTierInfo>;
  @useResult
  $Res call({
    String name,
    double commissionRate,
    bool hasJobPriority,
    bool enterpriseEligible,
    double minScore,
    String? bonusDescription,
  });
}

/// @nodoc
class _$RankTierInfoCopyWithImpl<$Res, $Val extends RankTierInfo>
    implements $RankTierInfoCopyWith<$Res> {
  _$RankTierInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RankTierInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? commissionRate = null,
    Object? hasJobPriority = null,
    Object? enterpriseEligible = null,
    Object? minScore = null,
    Object? bonusDescription = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            commissionRate: null == commissionRate
                ? _value.commissionRate
                : commissionRate // ignore: cast_nullable_to_non_nullable
                      as double,
            hasJobPriority: null == hasJobPriority
                ? _value.hasJobPriority
                : hasJobPriority // ignore: cast_nullable_to_non_nullable
                      as bool,
            enterpriseEligible: null == enterpriseEligible
                ? _value.enterpriseEligible
                : enterpriseEligible // ignore: cast_nullable_to_non_nullable
                      as bool,
            minScore: null == minScore
                ? _value.minScore
                : minScore // ignore: cast_nullable_to_non_nullable
                      as double,
            bonusDescription: freezed == bonusDescription
                ? _value.bonusDescription
                : bonusDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RankTierInfoImplCopyWith<$Res>
    implements $RankTierInfoCopyWith<$Res> {
  factory _$$RankTierInfoImplCopyWith(
    _$RankTierInfoImpl value,
    $Res Function(_$RankTierInfoImpl) then,
  ) = __$$RankTierInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    double commissionRate,
    bool hasJobPriority,
    bool enterpriseEligible,
    double minScore,
    String? bonusDescription,
  });
}

/// @nodoc
class __$$RankTierInfoImplCopyWithImpl<$Res>
    extends _$RankTierInfoCopyWithImpl<$Res, _$RankTierInfoImpl>
    implements _$$RankTierInfoImplCopyWith<$Res> {
  __$$RankTierInfoImplCopyWithImpl(
    _$RankTierInfoImpl _value,
    $Res Function(_$RankTierInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RankTierInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? commissionRate = null,
    Object? hasJobPriority = null,
    Object? enterpriseEligible = null,
    Object? minScore = null,
    Object? bonusDescription = freezed,
  }) {
    return _then(
      _$RankTierInfoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        commissionRate: null == commissionRate
            ? _value.commissionRate
            : commissionRate // ignore: cast_nullable_to_non_nullable
                  as double,
        hasJobPriority: null == hasJobPriority
            ? _value.hasJobPriority
            : hasJobPriority // ignore: cast_nullable_to_non_nullable
                  as bool,
        enterpriseEligible: null == enterpriseEligible
            ? _value.enterpriseEligible
            : enterpriseEligible // ignore: cast_nullable_to_non_nullable
                  as bool,
        minScore: null == minScore
            ? _value.minScore
            : minScore // ignore: cast_nullable_to_non_nullable
                  as double,
        bonusDescription: freezed == bonusDescription
            ? _value.bonusDescription
            : bonusDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RankTierInfoImpl implements _RankTierInfo {
  const _$RankTierInfoImpl({
    required this.name,
    required this.commissionRate,
    required this.hasJobPriority,
    required this.enterpriseEligible,
    required this.minScore,
    this.bonusDescription,
  });

  factory _$RankTierInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RankTierInfoImplFromJson(json);

  @override
  final String name;
  @override
  final double commissionRate;
  @override
  final bool hasJobPriority;
  @override
  final bool enterpriseEligible;
  @override
  final double minScore;
  @override
  final String? bonusDescription;

  @override
  String toString() {
    return 'RankTierInfo(name: $name, commissionRate: $commissionRate, hasJobPriority: $hasJobPriority, enterpriseEligible: $enterpriseEligible, minScore: $minScore, bonusDescription: $bonusDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RankTierInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.commissionRate, commissionRate) ||
                other.commissionRate == commissionRate) &&
            (identical(other.hasJobPriority, hasJobPriority) ||
                other.hasJobPriority == hasJobPriority) &&
            (identical(other.enterpriseEligible, enterpriseEligible) ||
                other.enterpriseEligible == enterpriseEligible) &&
            (identical(other.minScore, minScore) ||
                other.minScore == minScore) &&
            (identical(other.bonusDescription, bonusDescription) ||
                other.bonusDescription == bonusDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    commissionRate,
    hasJobPriority,
    enterpriseEligible,
    minScore,
    bonusDescription,
  );

  /// Create a copy of RankTierInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RankTierInfoImplCopyWith<_$RankTierInfoImpl> get copyWith =>
      __$$RankTierInfoImplCopyWithImpl<_$RankTierInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RankTierInfoImplToJson(this);
  }
}

abstract class _RankTierInfo implements RankTierInfo {
  const factory _RankTierInfo({
    required final String name,
    required final double commissionRate,
    required final bool hasJobPriority,
    required final bool enterpriseEligible,
    required final double minScore,
    final String? bonusDescription,
  }) = _$RankTierInfoImpl;

  factory _RankTierInfo.fromJson(Map<String, dynamic> json) =
      _$RankTierInfoImpl.fromJson;

  @override
  String get name;
  @override
  double get commissionRate;
  @override
  bool get hasJobPriority;
  @override
  bool get enterpriseEligible;
  @override
  double get minScore;
  @override
  String? get bonusDescription;

  /// Create a copy of RankTierInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RankTierInfoImplCopyWith<_$RankTierInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
