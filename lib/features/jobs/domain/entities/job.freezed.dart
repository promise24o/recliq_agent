// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
mixin _$Job {
  String get id => throw _privateConstructorUsedError;
  String get wasteType => throw _privateConstructorUsedError;
  double get estimatedWeight => throw _privateConstructorUsedError;
  double get estimatedPayout => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  JobStatus get status => throw _privateConstructorUsedError;
  JobType get type => throw _privateConstructorUsedError;
  String? get customerName => throw _privateConstructorUsedError;
  String? get customerPhone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get slaTime => throw _privateConstructorUsedError;
  String? get scheduledAt => throw _privateConstructorUsedError;
  double? get pricePerKg => throw _privateConstructorUsedError;
  bool? get isEscrowSecured => throw _privateConstructorUsedError;
  String? get complianceNotes => throw _privateConstructorUsedError;
  double? get actualWeight => throw _privateConstructorUsedError;
  String? get proofImageUrl => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this Job to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JobCopyWith<Job> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) then) =
      _$JobCopyWithImpl<$Res, Job>;
  @useResult
  $Res call({
    String id,
    String wasteType,
    double estimatedWeight,
    double estimatedPayout,
    double distance,
    JobStatus status,
    JobType type,
    String? customerName,
    String? customerPhone,
    String? address,
    double? latitude,
    double? longitude,
    String? slaTime,
    String? scheduledAt,
    double? pricePerKg,
    bool? isEscrowSecured,
    String? complianceNotes,
    double? actualWeight,
    String? proofImageUrl,
    String? createdAt,
    String? completedAt,
  });
}

/// @nodoc
class _$JobCopyWithImpl<$Res, $Val extends Job> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wasteType = null,
    Object? estimatedWeight = null,
    Object? estimatedPayout = null,
    Object? distance = null,
    Object? status = null,
    Object? type = null,
    Object? customerName = freezed,
    Object? customerPhone = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? slaTime = freezed,
    Object? scheduledAt = freezed,
    Object? pricePerKg = freezed,
    Object? isEscrowSecured = freezed,
    Object? complianceNotes = freezed,
    Object? actualWeight = freezed,
    Object? proofImageUrl = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            wasteType: null == wasteType
                ? _value.wasteType
                : wasteType // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedWeight: null == estimatedWeight
                ? _value.estimatedWeight
                : estimatedWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedPayout: null == estimatedPayout
                ? _value.estimatedPayout
                : estimatedPayout // ignore: cast_nullable_to_non_nullable
                      as double,
            distance: null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as JobStatus,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as JobType,
            customerName: freezed == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerPhone: freezed == customerPhone
                ? _value.customerPhone
                : customerPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            slaTime: freezed == slaTime
                ? _value.slaTime
                : slaTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            pricePerKg: freezed == pricePerKg
                ? _value.pricePerKg
                : pricePerKg // ignore: cast_nullable_to_non_nullable
                      as double?,
            isEscrowSecured: freezed == isEscrowSecured
                ? _value.isEscrowSecured
                : isEscrowSecured // ignore: cast_nullable_to_non_nullable
                      as bool?,
            complianceNotes: freezed == complianceNotes
                ? _value.complianceNotes
                : complianceNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            actualWeight: freezed == actualWeight
                ? _value.actualWeight
                : actualWeight // ignore: cast_nullable_to_non_nullable
                      as double?,
            proofImageUrl: freezed == proofImageUrl
                ? _value.proofImageUrl
                : proofImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JobImplCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$$JobImplCopyWith(_$JobImpl value, $Res Function(_$JobImpl) then) =
      __$$JobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String wasteType,
    double estimatedWeight,
    double estimatedPayout,
    double distance,
    JobStatus status,
    JobType type,
    String? customerName,
    String? customerPhone,
    String? address,
    double? latitude,
    double? longitude,
    String? slaTime,
    String? scheduledAt,
    double? pricePerKg,
    bool? isEscrowSecured,
    String? complianceNotes,
    double? actualWeight,
    String? proofImageUrl,
    String? createdAt,
    String? completedAt,
  });
}

/// @nodoc
class __$$JobImplCopyWithImpl<$Res> extends _$JobCopyWithImpl<$Res, _$JobImpl>
    implements _$$JobImplCopyWith<$Res> {
  __$$JobImplCopyWithImpl(_$JobImpl _value, $Res Function(_$JobImpl) _then)
    : super(_value, _then);

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wasteType = null,
    Object? estimatedWeight = null,
    Object? estimatedPayout = null,
    Object? distance = null,
    Object? status = null,
    Object? type = null,
    Object? customerName = freezed,
    Object? customerPhone = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? slaTime = freezed,
    Object? scheduledAt = freezed,
    Object? pricePerKg = freezed,
    Object? isEscrowSecured = freezed,
    Object? complianceNotes = freezed,
    Object? actualWeight = freezed,
    Object? proofImageUrl = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$JobImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        wasteType: null == wasteType
            ? _value.wasteType
            : wasteType // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedWeight: null == estimatedWeight
            ? _value.estimatedWeight
            : estimatedWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedPayout: null == estimatedPayout
            ? _value.estimatedPayout
            : estimatedPayout // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as JobStatus,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as JobType,
        customerName: freezed == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerPhone: freezed == customerPhone
            ? _value.customerPhone
            : customerPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        slaTime: freezed == slaTime
            ? _value.slaTime
            : slaTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        pricePerKg: freezed == pricePerKg
            ? _value.pricePerKg
            : pricePerKg // ignore: cast_nullable_to_non_nullable
                  as double?,
        isEscrowSecured: freezed == isEscrowSecured
            ? _value.isEscrowSecured
            : isEscrowSecured // ignore: cast_nullable_to_non_nullable
                  as bool?,
        complianceNotes: freezed == complianceNotes
            ? _value.complianceNotes
            : complianceNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        actualWeight: freezed == actualWeight
            ? _value.actualWeight
            : actualWeight // ignore: cast_nullable_to_non_nullable
                  as double?,
        proofImageUrl: freezed == proofImageUrl
            ? _value.proofImageUrl
            : proofImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JobImpl implements _Job {
  const _$JobImpl({
    required this.id,
    required this.wasteType,
    required this.estimatedWeight,
    required this.estimatedPayout,
    required this.distance,
    required this.status,
    required this.type,
    this.customerName,
    this.customerPhone,
    this.address,
    this.latitude,
    this.longitude,
    this.slaTime,
    this.scheduledAt,
    this.pricePerKg,
    this.isEscrowSecured,
    this.complianceNotes,
    this.actualWeight,
    this.proofImageUrl,
    this.createdAt,
    this.completedAt,
  });

  factory _$JobImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobImplFromJson(json);

  @override
  final String id;
  @override
  final String wasteType;
  @override
  final double estimatedWeight;
  @override
  final double estimatedPayout;
  @override
  final double distance;
  @override
  final JobStatus status;
  @override
  final JobType type;
  @override
  final String? customerName;
  @override
  final String? customerPhone;
  @override
  final String? address;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? slaTime;
  @override
  final String? scheduledAt;
  @override
  final double? pricePerKg;
  @override
  final bool? isEscrowSecured;
  @override
  final String? complianceNotes;
  @override
  final double? actualWeight;
  @override
  final String? proofImageUrl;
  @override
  final String? createdAt;
  @override
  final String? completedAt;

  @override
  String toString() {
    return 'Job(id: $id, wasteType: $wasteType, estimatedWeight: $estimatedWeight, estimatedPayout: $estimatedPayout, distance: $distance, status: $status, type: $type, customerName: $customerName, customerPhone: $customerPhone, address: $address, latitude: $latitude, longitude: $longitude, slaTime: $slaTime, scheduledAt: $scheduledAt, pricePerKg: $pricePerKg, isEscrowSecured: $isEscrowSecured, complianceNotes: $complianceNotes, actualWeight: $actualWeight, proofImageUrl: $proofImageUrl, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wasteType, wasteType) ||
                other.wasteType == wasteType) &&
            (identical(other.estimatedWeight, estimatedWeight) ||
                other.estimatedWeight == estimatedWeight) &&
            (identical(other.estimatedPayout, estimatedPayout) ||
                other.estimatedPayout == estimatedPayout) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.slaTime, slaTime) || other.slaTime == slaTime) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.pricePerKg, pricePerKg) ||
                other.pricePerKg == pricePerKg) &&
            (identical(other.isEscrowSecured, isEscrowSecured) ||
                other.isEscrowSecured == isEscrowSecured) &&
            (identical(other.complianceNotes, complianceNotes) ||
                other.complianceNotes == complianceNotes) &&
            (identical(other.actualWeight, actualWeight) ||
                other.actualWeight == actualWeight) &&
            (identical(other.proofImageUrl, proofImageUrl) ||
                other.proofImageUrl == proofImageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    wasteType,
    estimatedWeight,
    estimatedPayout,
    distance,
    status,
    type,
    customerName,
    customerPhone,
    address,
    latitude,
    longitude,
    slaTime,
    scheduledAt,
    pricePerKg,
    isEscrowSecured,
    complianceNotes,
    actualWeight,
    proofImageUrl,
    createdAt,
    completedAt,
  ]);

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JobImplCopyWith<_$JobImpl> get copyWith =>
      __$$JobImplCopyWithImpl<_$JobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobImplToJson(this);
  }
}

abstract class _Job implements Job {
  const factory _Job({
    required final String id,
    required final String wasteType,
    required final double estimatedWeight,
    required final double estimatedPayout,
    required final double distance,
    required final JobStatus status,
    required final JobType type,
    final String? customerName,
    final String? customerPhone,
    final String? address,
    final double? latitude,
    final double? longitude,
    final String? slaTime,
    final String? scheduledAt,
    final double? pricePerKg,
    final bool? isEscrowSecured,
    final String? complianceNotes,
    final double? actualWeight,
    final String? proofImageUrl,
    final String? createdAt,
    final String? completedAt,
  }) = _$JobImpl;

  factory _Job.fromJson(Map<String, dynamic> json) = _$JobImpl.fromJson;

  @override
  String get id;
  @override
  String get wasteType;
  @override
  double get estimatedWeight;
  @override
  double get estimatedPayout;
  @override
  double get distance;
  @override
  JobStatus get status;
  @override
  JobType get type;
  @override
  String? get customerName;
  @override
  String? get customerPhone;
  @override
  String? get address;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get slaTime;
  @override
  String? get scheduledAt;
  @override
  double? get pricePerKg;
  @override
  bool? get isEscrowSecured;
  @override
  String? get complianceNotes;
  @override
  double? get actualWeight;
  @override
  String? get proofImageUrl;
  @override
  String? get createdAt;
  @override
  String? get completedAt;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JobImplCopyWith<_$JobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
