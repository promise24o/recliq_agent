// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pickup_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PickupCoordinates _$PickupCoordinatesFromJson(Map<String, dynamic> json) {
  return _PickupCoordinates.fromJson(json);
}

/// @nodoc
mixin _$PickupCoordinates {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  /// Serializes this PickupCoordinates to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PickupCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PickupCoordinatesCopyWith<PickupCoordinates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupCoordinatesCopyWith<$Res> {
  factory $PickupCoordinatesCopyWith(
    PickupCoordinates value,
    $Res Function(PickupCoordinates) then,
  ) = _$PickupCoordinatesCopyWithImpl<$Res, PickupCoordinates>;
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class _$PickupCoordinatesCopyWithImpl<$Res, $Val extends PickupCoordinates>
    implements $PickupCoordinatesCopyWith<$Res> {
  _$PickupCoordinatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PickupCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _value.copyWith(
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PickupCoordinatesImplCopyWith<$Res>
    implements $PickupCoordinatesCopyWith<$Res> {
  factory _$$PickupCoordinatesImplCopyWith(
    _$PickupCoordinatesImpl value,
    $Res Function(_$PickupCoordinatesImpl) then,
  ) = __$$PickupCoordinatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class __$$PickupCoordinatesImplCopyWithImpl<$Res>
    extends _$PickupCoordinatesCopyWithImpl<$Res, _$PickupCoordinatesImpl>
    implements _$$PickupCoordinatesImplCopyWith<$Res> {
  __$$PickupCoordinatesImplCopyWithImpl(
    _$PickupCoordinatesImpl _value,
    $Res Function(_$PickupCoordinatesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PickupCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _$PickupCoordinatesImpl(
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupCoordinatesImpl implements _PickupCoordinates {
  const _$PickupCoordinatesImpl({required this.lat, required this.lng});

  factory _$PickupCoordinatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupCoordinatesImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'PickupCoordinates(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupCoordinatesImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of PickupCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupCoordinatesImplCopyWith<_$PickupCoordinatesImpl> get copyWith =>
      __$$PickupCoordinatesImplCopyWithImpl<_$PickupCoordinatesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupCoordinatesImplToJson(this);
  }
}

abstract class _PickupCoordinates implements PickupCoordinates {
  const factory _PickupCoordinates({
    required final double lat,
    required final double lng,
  }) = _$PickupCoordinatesImpl;

  factory _PickupCoordinates.fromJson(Map<String, dynamic> json) =
      _$PickupCoordinatesImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;

  /// Create a copy of PickupCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickupCoordinatesImplCopyWith<_$PickupCoordinatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PickupPricing _$PickupPricingFromJson(Map<String, dynamic> json) {
  return _PickupPricing.fromJson(json);
}

/// @nodoc
mixin _$PickupPricing {
  double get baseAmount => throw _privateConstructorUsedError;
  double get bonusAmount => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this PickupPricing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PickupPricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PickupPricingCopyWith<PickupPricing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupPricingCopyWith<$Res> {
  factory $PickupPricingCopyWith(
    PickupPricing value,
    $Res Function(PickupPricing) then,
  ) = _$PickupPricingCopyWithImpl<$Res, PickupPricing>;
  @useResult
  $Res call({
    double baseAmount,
    double bonusAmount,
    double totalAmount,
    String currency,
  });
}

/// @nodoc
class _$PickupPricingCopyWithImpl<$Res, $Val extends PickupPricing>
    implements $PickupPricingCopyWith<$Res> {
  _$PickupPricingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PickupPricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseAmount = null,
    Object? bonusAmount = null,
    Object? totalAmount = null,
    Object? currency = null,
  }) {
    return _then(
      _value.copyWith(
            baseAmount: null == baseAmount
                ? _value.baseAmount
                : baseAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            bonusAmount: null == bonusAmount
                ? _value.bonusAmount
                : bonusAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PickupPricingImplCopyWith<$Res>
    implements $PickupPricingCopyWith<$Res> {
  factory _$$PickupPricingImplCopyWith(
    _$PickupPricingImpl value,
    $Res Function(_$PickupPricingImpl) then,
  ) = __$$PickupPricingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double baseAmount,
    double bonusAmount,
    double totalAmount,
    String currency,
  });
}

/// @nodoc
class __$$PickupPricingImplCopyWithImpl<$Res>
    extends _$PickupPricingCopyWithImpl<$Res, _$PickupPricingImpl>
    implements _$$PickupPricingImplCopyWith<$Res> {
  __$$PickupPricingImplCopyWithImpl(
    _$PickupPricingImpl _value,
    $Res Function(_$PickupPricingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PickupPricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseAmount = null,
    Object? bonusAmount = null,
    Object? totalAmount = null,
    Object? currency = null,
  }) {
    return _then(
      _$PickupPricingImpl(
        baseAmount: null == baseAmount
            ? _value.baseAmount
            : baseAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        bonusAmount: null == bonusAmount
            ? _value.bonusAmount
            : bonusAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupPricingImpl implements _PickupPricing {
  const _$PickupPricingImpl({
    this.baseAmount = 0,
    this.bonusAmount = 0,
    this.totalAmount = 0,
    this.currency = 'NGN',
  });

  factory _$PickupPricingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupPricingImplFromJson(json);

  @override
  @JsonKey()
  final double baseAmount;
  @override
  @JsonKey()
  final double bonusAmount;
  @override
  @JsonKey()
  final double totalAmount;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'PickupPricing(baseAmount: $baseAmount, bonusAmount: $bonusAmount, totalAmount: $totalAmount, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupPricingImpl &&
            (identical(other.baseAmount, baseAmount) ||
                other.baseAmount == baseAmount) &&
            (identical(other.bonusAmount, bonusAmount) ||
                other.bonusAmount == bonusAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, baseAmount, bonusAmount, totalAmount, currency);

  /// Create a copy of PickupPricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupPricingImplCopyWith<_$PickupPricingImpl> get copyWith =>
      __$$PickupPricingImplCopyWithImpl<_$PickupPricingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupPricingImplToJson(this);
  }
}

abstract class _PickupPricing implements PickupPricing {
  const factory _PickupPricing({
    final double baseAmount,
    final double bonusAmount,
    final double totalAmount,
    final String currency,
  }) = _$PickupPricingImpl;

  factory _PickupPricing.fromJson(Map<String, dynamic> json) =
      _$PickupPricingImpl.fromJson;

  @override
  double get baseAmount;
  @override
  double get bonusAmount;
  @override
  double get totalAmount;
  @override
  String get currency;

  /// Create a copy of PickupPricing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickupPricingImplCopyWith<_$PickupPricingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchingTimelineEvent _$MatchingTimelineEventFromJson(
  Map<String, dynamic> json,
) {
  return _MatchingTimelineEvent.fromJson(json);
}

/// @nodoc
mixin _$MatchingTimelineEvent {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  String? get agentId => throw _privateConstructorUsedError;
  String? get agentName => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;

  /// Serializes this MatchingTimelineEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchingTimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchingTimelineEventCopyWith<MatchingTimelineEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchingTimelineEventCopyWith<$Res> {
  factory $MatchingTimelineEventCopyWith(
    MatchingTimelineEvent value,
    $Res Function(MatchingTimelineEvent) then,
  ) = _$MatchingTimelineEventCopyWithImpl<$Res, MatchingTimelineEvent>;
  @useResult
  $Res call({
    String id,
    String type,
    String timestamp,
    String? agentId,
    String? agentName,
    String? details,
  });
}

/// @nodoc
class _$MatchingTimelineEventCopyWithImpl<
  $Res,
  $Val extends MatchingTimelineEvent
>
    implements $MatchingTimelineEventCopyWith<$Res> {
  _$MatchingTimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchingTimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? agentId = freezed,
    Object? agentName = freezed,
    Object? details = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
            agentId: freezed == agentId
                ? _value.agentId
                : agentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            agentName: freezed == agentName
                ? _value.agentName
                : agentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MatchingTimelineEventImplCopyWith<$Res>
    implements $MatchingTimelineEventCopyWith<$Res> {
  factory _$$MatchingTimelineEventImplCopyWith(
    _$MatchingTimelineEventImpl value,
    $Res Function(_$MatchingTimelineEventImpl) then,
  ) = __$$MatchingTimelineEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String timestamp,
    String? agentId,
    String? agentName,
    String? details,
  });
}

/// @nodoc
class __$$MatchingTimelineEventImplCopyWithImpl<$Res>
    extends
        _$MatchingTimelineEventCopyWithImpl<$Res, _$MatchingTimelineEventImpl>
    implements _$$MatchingTimelineEventImplCopyWith<$Res> {
  __$$MatchingTimelineEventImplCopyWithImpl(
    _$MatchingTimelineEventImpl _value,
    $Res Function(_$MatchingTimelineEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MatchingTimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? timestamp = null,
    Object? agentId = freezed,
    Object? agentName = freezed,
    Object? details = freezed,
  }) {
    return _then(
      _$MatchingTimelineEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
        agentId: freezed == agentId
            ? _value.agentId
            : agentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        agentName: freezed == agentName
            ? _value.agentName
            : agentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchingTimelineEventImpl implements _MatchingTimelineEvent {
  const _$MatchingTimelineEventImpl({
    required this.id,
    required this.type,
    required this.timestamp,
    this.agentId,
    this.agentName,
    this.details,
  });

  factory _$MatchingTimelineEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchingTimelineEventImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String timestamp;
  @override
  final String? agentId;
  @override
  final String? agentName;
  @override
  final String? details;

  @override
  String toString() {
    return 'MatchingTimelineEvent(id: $id, type: $type, timestamp: $timestamp, agentId: $agentId, agentName: $agentName, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchingTimelineEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.agentId, agentId) || other.agentId == agentId) &&
            (identical(other.agentName, agentName) ||
                other.agentName == agentName) &&
            (identical(other.details, details) || other.details == details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    timestamp,
    agentId,
    agentName,
    details,
  );

  /// Create a copy of MatchingTimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchingTimelineEventImplCopyWith<_$MatchingTimelineEventImpl>
  get copyWith =>
      __$$MatchingTimelineEventImplCopyWithImpl<_$MatchingTimelineEventImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchingTimelineEventImplToJson(this);
  }
}

abstract class _MatchingTimelineEvent implements MatchingTimelineEvent {
  const factory _MatchingTimelineEvent({
    required final String id,
    required final String type,
    required final String timestamp,
    final String? agentId,
    final String? agentName,
    final String? details,
  }) = _$MatchingTimelineEventImpl;

  factory _MatchingTimelineEvent.fromJson(Map<String, dynamic> json) =
      _$MatchingTimelineEventImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get timestamp;
  @override
  String? get agentId;
  @override
  String? get agentName;
  @override
  String? get details;

  /// Create a copy of MatchingTimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchingTimelineEventImplCopyWith<_$MatchingTimelineEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PickupRequest _$PickupRequestFromJson(Map<String, dynamic> json) {
  return _PickupRequest.fromJson(json);
}

/// @nodoc
mixin _$PickupRequest {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get userPhone => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get zone => throw _privateConstructorUsedError;
  PickupMode get pickupMode => throw _privateConstructorUsedError;
  String? get matchType => throw _privateConstructorUsedError;
  WasteType get wasteType => throw _privateConstructorUsedError;
  double get estimatedWeight => throw _privateConstructorUsedError;
  PickupStatus get status => throw _privateConstructorUsedError;
  String? get assignedAgentId => throw _privateConstructorUsedError;
  String? get assignedAgentName => throw _privateConstructorUsedError;
  String? get slaDeadline => throw _privateConstructorUsedError;
  PickupPricing? get pricing => throw _privateConstructorUsedError;
  PickupCoordinates? get coordinates => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<MatchingTimelineEvent> get matchingTimeline =>
      throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;
  String? get cancelledAt => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PickupRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PickupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PickupRequestCopyWith<PickupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupRequestCopyWith<$Res> {
  factory $PickupRequestCopyWith(
    PickupRequest value,
    $Res Function(PickupRequest) then,
  ) = _$PickupRequestCopyWithImpl<$Res, PickupRequest>;
  @useResult
  $Res call({
    String id,
    String userId,
    String? userName,
    String? userPhone,
    String? city,
    String? zone,
    PickupMode pickupMode,
    String? matchType,
    WasteType wasteType,
    double estimatedWeight,
    PickupStatus status,
    String? assignedAgentId,
    String? assignedAgentName,
    String? slaDeadline,
    PickupPricing? pricing,
    PickupCoordinates? coordinates,
    String? address,
    String? notes,
    List<MatchingTimelineEvent> matchingTimeline,
    String? cancellationReason,
    String? cancelledAt,
    String? createdAt,
    String? updatedAt,
  });

  $PickupPricingCopyWith<$Res>? get pricing;
  $PickupCoordinatesCopyWith<$Res>? get coordinates;
}

/// @nodoc
class _$PickupRequestCopyWithImpl<$Res, $Val extends PickupRequest>
    implements $PickupRequestCopyWith<$Res> {
  _$PickupRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PickupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = freezed,
    Object? userPhone = freezed,
    Object? city = freezed,
    Object? zone = freezed,
    Object? pickupMode = null,
    Object? matchType = freezed,
    Object? wasteType = null,
    Object? estimatedWeight = null,
    Object? status = null,
    Object? assignedAgentId = freezed,
    Object? assignedAgentName = freezed,
    Object? slaDeadline = freezed,
    Object? pricing = freezed,
    Object? coordinates = freezed,
    Object? address = freezed,
    Object? notes = freezed,
    Object? matchingTimeline = null,
    Object? cancellationReason = freezed,
    Object? cancelledAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userPhone: freezed == userPhone
                ? _value.userPhone
                : userPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            zone: freezed == zone
                ? _value.zone
                : zone // ignore: cast_nullable_to_non_nullable
                      as String?,
            pickupMode: null == pickupMode
                ? _value.pickupMode
                : pickupMode // ignore: cast_nullable_to_non_nullable
                      as PickupMode,
            matchType: freezed == matchType
                ? _value.matchType
                : matchType // ignore: cast_nullable_to_non_nullable
                      as String?,
            wasteType: null == wasteType
                ? _value.wasteType
                : wasteType // ignore: cast_nullable_to_non_nullable
                      as WasteType,
            estimatedWeight: null == estimatedWeight
                ? _value.estimatedWeight
                : estimatedWeight // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PickupStatus,
            assignedAgentId: freezed == assignedAgentId
                ? _value.assignedAgentId
                : assignedAgentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            assignedAgentName: freezed == assignedAgentName
                ? _value.assignedAgentName
                : assignedAgentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            slaDeadline: freezed == slaDeadline
                ? _value.slaDeadline
                : slaDeadline // ignore: cast_nullable_to_non_nullable
                      as String?,
            pricing: freezed == pricing
                ? _value.pricing
                : pricing // ignore: cast_nullable_to_non_nullable
                      as PickupPricing?,
            coordinates: freezed == coordinates
                ? _value.coordinates
                : coordinates // ignore: cast_nullable_to_non_nullable
                      as PickupCoordinates?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            matchingTimeline: null == matchingTimeline
                ? _value.matchingTimeline
                : matchingTimeline // ignore: cast_nullable_to_non_nullable
                      as List<MatchingTimelineEvent>,
            cancellationReason: freezed == cancellationReason
                ? _value.cancellationReason
                : cancellationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of PickupRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PickupPricingCopyWith<$Res>? get pricing {
    if (_value.pricing == null) {
      return null;
    }

    return $PickupPricingCopyWith<$Res>(_value.pricing!, (value) {
      return _then(_value.copyWith(pricing: value) as $Val);
    });
  }

  /// Create a copy of PickupRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PickupCoordinatesCopyWith<$Res>? get coordinates {
    if (_value.coordinates == null) {
      return null;
    }

    return $PickupCoordinatesCopyWith<$Res>(_value.coordinates!, (value) {
      return _then(_value.copyWith(coordinates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PickupRequestImplCopyWith<$Res>
    implements $PickupRequestCopyWith<$Res> {
  factory _$$PickupRequestImplCopyWith(
    _$PickupRequestImpl value,
    $Res Function(_$PickupRequestImpl) then,
  ) = __$$PickupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String? userName,
    String? userPhone,
    String? city,
    String? zone,
    PickupMode pickupMode,
    String? matchType,
    WasteType wasteType,
    double estimatedWeight,
    PickupStatus status,
    String? assignedAgentId,
    String? assignedAgentName,
    String? slaDeadline,
    PickupPricing? pricing,
    PickupCoordinates? coordinates,
    String? address,
    String? notes,
    List<MatchingTimelineEvent> matchingTimeline,
    String? cancellationReason,
    String? cancelledAt,
    String? createdAt,
    String? updatedAt,
  });

  @override
  $PickupPricingCopyWith<$Res>? get pricing;
  @override
  $PickupCoordinatesCopyWith<$Res>? get coordinates;
}

/// @nodoc
class __$$PickupRequestImplCopyWithImpl<$Res>
    extends _$PickupRequestCopyWithImpl<$Res, _$PickupRequestImpl>
    implements _$$PickupRequestImplCopyWith<$Res> {
  __$$PickupRequestImplCopyWithImpl(
    _$PickupRequestImpl _value,
    $Res Function(_$PickupRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PickupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = freezed,
    Object? userPhone = freezed,
    Object? city = freezed,
    Object? zone = freezed,
    Object? pickupMode = null,
    Object? matchType = freezed,
    Object? wasteType = null,
    Object? estimatedWeight = null,
    Object? status = null,
    Object? assignedAgentId = freezed,
    Object? assignedAgentName = freezed,
    Object? slaDeadline = freezed,
    Object? pricing = freezed,
    Object? coordinates = freezed,
    Object? address = freezed,
    Object? notes = freezed,
    Object? matchingTimeline = null,
    Object? cancellationReason = freezed,
    Object? cancelledAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PickupRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: freezed == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userPhone: freezed == userPhone
            ? _value.userPhone
            : userPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        zone: freezed == zone
            ? _value.zone
            : zone // ignore: cast_nullable_to_non_nullable
                  as String?,
        pickupMode: null == pickupMode
            ? _value.pickupMode
            : pickupMode // ignore: cast_nullable_to_non_nullable
                  as PickupMode,
        matchType: freezed == matchType
            ? _value.matchType
            : matchType // ignore: cast_nullable_to_non_nullable
                  as String?,
        wasteType: null == wasteType
            ? _value.wasteType
            : wasteType // ignore: cast_nullable_to_non_nullable
                  as WasteType,
        estimatedWeight: null == estimatedWeight
            ? _value.estimatedWeight
            : estimatedWeight // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PickupStatus,
        assignedAgentId: freezed == assignedAgentId
            ? _value.assignedAgentId
            : assignedAgentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        assignedAgentName: freezed == assignedAgentName
            ? _value.assignedAgentName
            : assignedAgentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        slaDeadline: freezed == slaDeadline
            ? _value.slaDeadline
            : slaDeadline // ignore: cast_nullable_to_non_nullable
                  as String?,
        pricing: freezed == pricing
            ? _value.pricing
            : pricing // ignore: cast_nullable_to_non_nullable
                  as PickupPricing?,
        coordinates: freezed == coordinates
            ? _value.coordinates
            : coordinates // ignore: cast_nullable_to_non_nullable
                  as PickupCoordinates?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        matchingTimeline: null == matchingTimeline
            ? _value._matchingTimeline
            : matchingTimeline // ignore: cast_nullable_to_non_nullable
                  as List<MatchingTimelineEvent>,
        cancellationReason: freezed == cancellationReason
            ? _value.cancellationReason
            : cancellationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupRequestImpl implements _PickupRequest {
  const _$PickupRequestImpl({
    required this.id,
    required this.userId,
    this.userName,
    this.userPhone,
    this.city,
    this.zone,
    required this.pickupMode,
    this.matchType,
    required this.wasteType,
    required this.estimatedWeight,
    required this.status,
    this.assignedAgentId,
    this.assignedAgentName,
    this.slaDeadline,
    this.pricing,
    this.coordinates,
    this.address,
    this.notes,
    final List<MatchingTimelineEvent> matchingTimeline = const [],
    this.cancellationReason,
    this.cancelledAt,
    this.createdAt,
    this.updatedAt,
  }) : _matchingTimeline = matchingTimeline;

  factory _$PickupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? userName;
  @override
  final String? userPhone;
  @override
  final String? city;
  @override
  final String? zone;
  @override
  final PickupMode pickupMode;
  @override
  final String? matchType;
  @override
  final WasteType wasteType;
  @override
  final double estimatedWeight;
  @override
  final PickupStatus status;
  @override
  final String? assignedAgentId;
  @override
  final String? assignedAgentName;
  @override
  final String? slaDeadline;
  @override
  final PickupPricing? pricing;
  @override
  final PickupCoordinates? coordinates;
  @override
  final String? address;
  @override
  final String? notes;
  final List<MatchingTimelineEvent> _matchingTimeline;
  @override
  @JsonKey()
  List<MatchingTimelineEvent> get matchingTimeline {
    if (_matchingTimeline is EqualUnmodifiableListView)
      return _matchingTimeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchingTimeline);
  }

  @override
  final String? cancellationReason;
  @override
  final String? cancelledAt;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'PickupRequest(id: $id, userId: $userId, userName: $userName, userPhone: $userPhone, city: $city, zone: $zone, pickupMode: $pickupMode, matchType: $matchType, wasteType: $wasteType, estimatedWeight: $estimatedWeight, status: $status, assignedAgentId: $assignedAgentId, assignedAgentName: $assignedAgentName, slaDeadline: $slaDeadline, pricing: $pricing, coordinates: $coordinates, address: $address, notes: $notes, matchingTimeline: $matchingTimeline, cancellationReason: $cancellationReason, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.zone, zone) || other.zone == zone) &&
            (identical(other.pickupMode, pickupMode) ||
                other.pickupMode == pickupMode) &&
            (identical(other.matchType, matchType) ||
                other.matchType == matchType) &&
            (identical(other.wasteType, wasteType) ||
                other.wasteType == wasteType) &&
            (identical(other.estimatedWeight, estimatedWeight) ||
                other.estimatedWeight == estimatedWeight) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedAgentId, assignedAgentId) ||
                other.assignedAgentId == assignedAgentId) &&
            (identical(other.assignedAgentName, assignedAgentName) ||
                other.assignedAgentName == assignedAgentName) &&
            (identical(other.slaDeadline, slaDeadline) ||
                other.slaDeadline == slaDeadline) &&
            (identical(other.pricing, pricing) || other.pricing == pricing) &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(
              other._matchingTimeline,
              _matchingTimeline,
            ) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    userName,
    userPhone,
    city,
    zone,
    pickupMode,
    matchType,
    wasteType,
    estimatedWeight,
    status,
    assignedAgentId,
    assignedAgentName,
    slaDeadline,
    pricing,
    coordinates,
    address,
    notes,
    const DeepCollectionEquality().hash(_matchingTimeline),
    cancellationReason,
    cancelledAt,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of PickupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupRequestImplCopyWith<_$PickupRequestImpl> get copyWith =>
      __$$PickupRequestImplCopyWithImpl<_$PickupRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupRequestImplToJson(this);
  }
}

abstract class _PickupRequest implements PickupRequest {
  const factory _PickupRequest({
    required final String id,
    required final String userId,
    final String? userName,
    final String? userPhone,
    final String? city,
    final String? zone,
    required final PickupMode pickupMode,
    final String? matchType,
    required final WasteType wasteType,
    required final double estimatedWeight,
    required final PickupStatus status,
    final String? assignedAgentId,
    final String? assignedAgentName,
    final String? slaDeadline,
    final PickupPricing? pricing,
    final PickupCoordinates? coordinates,
    final String? address,
    final String? notes,
    final List<MatchingTimelineEvent> matchingTimeline,
    final String? cancellationReason,
    final String? cancelledAt,
    final String? createdAt,
    final String? updatedAt,
  }) = _$PickupRequestImpl;

  factory _PickupRequest.fromJson(Map<String, dynamic> json) =
      _$PickupRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get userName;
  @override
  String? get userPhone;
  @override
  String? get city;
  @override
  String? get zone;
  @override
  PickupMode get pickupMode;
  @override
  String? get matchType;
  @override
  WasteType get wasteType;
  @override
  double get estimatedWeight;
  @override
  PickupStatus get status;
  @override
  String? get assignedAgentId;
  @override
  String? get assignedAgentName;
  @override
  String? get slaDeadline;
  @override
  PickupPricing? get pricing;
  @override
  PickupCoordinates? get coordinates;
  @override
  String? get address;
  @override
  String? get notes;
  @override
  List<MatchingTimelineEvent> get matchingTimeline;
  @override
  String? get cancellationReason;
  @override
  String? get cancelledAt;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of PickupRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickupRequestImplCopyWith<_$PickupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PickupRespondRequest _$PickupRespondRequestFromJson(Map<String, dynamic> json) {
  return _PickupRespondRequest.fromJson(json);
}

/// @nodoc
mixin _$PickupRespondRequest {
  String get response =>
      throw _privateConstructorUsedError; // 'accept' or 'decline'
  String? get reason =>
      throw _privateConstructorUsedError; // Required if response=decline
  int? get estimatedArrivalMinutes => throw _privateConstructorUsedError;

  /// Serializes this PickupRespondRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PickupRespondRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PickupRespondRequestCopyWith<PickupRespondRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupRespondRequestCopyWith<$Res> {
  factory $PickupRespondRequestCopyWith(
    PickupRespondRequest value,
    $Res Function(PickupRespondRequest) then,
  ) = _$PickupRespondRequestCopyWithImpl<$Res, PickupRespondRequest>;
  @useResult
  $Res call({String response, String? reason, int? estimatedArrivalMinutes});
}

/// @nodoc
class _$PickupRespondRequestCopyWithImpl<
  $Res,
  $Val extends PickupRespondRequest
>
    implements $PickupRespondRequestCopyWith<$Res> {
  _$PickupRespondRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PickupRespondRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? reason = freezed,
    Object? estimatedArrivalMinutes = freezed,
  }) {
    return _then(
      _value.copyWith(
            response: null == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            estimatedArrivalMinutes: freezed == estimatedArrivalMinutes
                ? _value.estimatedArrivalMinutes
                : estimatedArrivalMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PickupRespondRequestImplCopyWith<$Res>
    implements $PickupRespondRequestCopyWith<$Res> {
  factory _$$PickupRespondRequestImplCopyWith(
    _$PickupRespondRequestImpl value,
    $Res Function(_$PickupRespondRequestImpl) then,
  ) = __$$PickupRespondRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String response, String? reason, int? estimatedArrivalMinutes});
}

/// @nodoc
class __$$PickupRespondRequestImplCopyWithImpl<$Res>
    extends _$PickupRespondRequestCopyWithImpl<$Res, _$PickupRespondRequestImpl>
    implements _$$PickupRespondRequestImplCopyWith<$Res> {
  __$$PickupRespondRequestImplCopyWithImpl(
    _$PickupRespondRequestImpl _value,
    $Res Function(_$PickupRespondRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PickupRespondRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? reason = freezed,
    Object? estimatedArrivalMinutes = freezed,
  }) {
    return _then(
      _$PickupRespondRequestImpl(
        response: null == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        estimatedArrivalMinutes: freezed == estimatedArrivalMinutes
            ? _value.estimatedArrivalMinutes
            : estimatedArrivalMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupRespondRequestImpl implements _PickupRespondRequest {
  const _$PickupRespondRequestImpl({
    required this.response,
    this.reason,
    this.estimatedArrivalMinutes,
  });

  factory _$PickupRespondRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupRespondRequestImplFromJson(json);

  @override
  final String response;
  // 'accept' or 'decline'
  @override
  final String? reason;
  // Required if response=decline
  @override
  final int? estimatedArrivalMinutes;

  @override
  String toString() {
    return 'PickupRespondRequest(response: $response, reason: $reason, estimatedArrivalMinutes: $estimatedArrivalMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupRespondRequestImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(
                  other.estimatedArrivalMinutes,
                  estimatedArrivalMinutes,
                ) ||
                other.estimatedArrivalMinutes == estimatedArrivalMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, response, reason, estimatedArrivalMinutes);

  /// Create a copy of PickupRespondRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupRespondRequestImplCopyWith<_$PickupRespondRequestImpl>
  get copyWith =>
      __$$PickupRespondRequestImplCopyWithImpl<_$PickupRespondRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupRespondRequestImplToJson(this);
  }
}

abstract class _PickupRespondRequest implements PickupRespondRequest {
  const factory _PickupRespondRequest({
    required final String response,
    final String? reason,
    final int? estimatedArrivalMinutes,
  }) = _$PickupRespondRequestImpl;

  factory _PickupRespondRequest.fromJson(Map<String, dynamic> json) =
      _$PickupRespondRequestImpl.fromJson;

  @override
  String get response; // 'accept' or 'decline'
  @override
  String? get reason; // Required if response=decline
  @override
  int? get estimatedArrivalMinutes;

  /// Create a copy of PickupRespondRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickupRespondRequestImplCopyWith<_$PickupRespondRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PickupRespondResponse _$PickupRespondResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PickupRespondResponse.fromJson(json);
}

/// @nodoc
mixin _$PickupRespondResponse {
  PickupRequest get pickup => throw _privateConstructorUsedError;
  bool get trackingEnabled => throw _privateConstructorUsedError;
  String? get trackableUserId => throw _privateConstructorUsedError;

  /// Serializes this PickupRespondResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PickupRespondResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PickupRespondResponseCopyWith<PickupRespondResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupRespondResponseCopyWith<$Res> {
  factory $PickupRespondResponseCopyWith(
    PickupRespondResponse value,
    $Res Function(PickupRespondResponse) then,
  ) = _$PickupRespondResponseCopyWithImpl<$Res, PickupRespondResponse>;
  @useResult
  $Res call({
    PickupRequest pickup,
    bool trackingEnabled,
    String? trackableUserId,
  });

  $PickupRequestCopyWith<$Res> get pickup;
}

/// @nodoc
class _$PickupRespondResponseCopyWithImpl<
  $Res,
  $Val extends PickupRespondResponse
>
    implements $PickupRespondResponseCopyWith<$Res> {
  _$PickupRespondResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PickupRespondResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pickup = null,
    Object? trackingEnabled = null,
    Object? trackableUserId = freezed,
  }) {
    return _then(
      _value.copyWith(
            pickup: null == pickup
                ? _value.pickup
                : pickup // ignore: cast_nullable_to_non_nullable
                      as PickupRequest,
            trackingEnabled: null == trackingEnabled
                ? _value.trackingEnabled
                : trackingEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            trackableUserId: freezed == trackableUserId
                ? _value.trackableUserId
                : trackableUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of PickupRespondResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PickupRequestCopyWith<$Res> get pickup {
    return $PickupRequestCopyWith<$Res>(_value.pickup, (value) {
      return _then(_value.copyWith(pickup: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PickupRespondResponseImplCopyWith<$Res>
    implements $PickupRespondResponseCopyWith<$Res> {
  factory _$$PickupRespondResponseImplCopyWith(
    _$PickupRespondResponseImpl value,
    $Res Function(_$PickupRespondResponseImpl) then,
  ) = __$$PickupRespondResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PickupRequest pickup,
    bool trackingEnabled,
    String? trackableUserId,
  });

  @override
  $PickupRequestCopyWith<$Res> get pickup;
}

/// @nodoc
class __$$PickupRespondResponseImplCopyWithImpl<$Res>
    extends
        _$PickupRespondResponseCopyWithImpl<$Res, _$PickupRespondResponseImpl>
    implements _$$PickupRespondResponseImplCopyWith<$Res> {
  __$$PickupRespondResponseImplCopyWithImpl(
    _$PickupRespondResponseImpl _value,
    $Res Function(_$PickupRespondResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PickupRespondResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pickup = null,
    Object? trackingEnabled = null,
    Object? trackableUserId = freezed,
  }) {
    return _then(
      _$PickupRespondResponseImpl(
        pickup: null == pickup
            ? _value.pickup
            : pickup // ignore: cast_nullable_to_non_nullable
                  as PickupRequest,
        trackingEnabled: null == trackingEnabled
            ? _value.trackingEnabled
            : trackingEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        trackableUserId: freezed == trackableUserId
            ? _value.trackableUserId
            : trackableUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupRespondResponseImpl implements _PickupRespondResponse {
  const _$PickupRespondResponseImpl({
    required this.pickup,
    this.trackingEnabled = false,
    this.trackableUserId,
  });

  factory _$PickupRespondResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupRespondResponseImplFromJson(json);

  @override
  final PickupRequest pickup;
  @override
  @JsonKey()
  final bool trackingEnabled;
  @override
  final String? trackableUserId;

  @override
  String toString() {
    return 'PickupRespondResponse(pickup: $pickup, trackingEnabled: $trackingEnabled, trackableUserId: $trackableUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupRespondResponseImpl &&
            (identical(other.pickup, pickup) || other.pickup == pickup) &&
            (identical(other.trackingEnabled, trackingEnabled) ||
                other.trackingEnabled == trackingEnabled) &&
            (identical(other.trackableUserId, trackableUserId) ||
                other.trackableUserId == trackableUserId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, pickup, trackingEnabled, trackableUserId);

  /// Create a copy of PickupRespondResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupRespondResponseImplCopyWith<_$PickupRespondResponseImpl>
  get copyWith =>
      __$$PickupRespondResponseImplCopyWithImpl<_$PickupRespondResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupRespondResponseImplToJson(this);
  }
}

abstract class _PickupRespondResponse implements PickupRespondResponse {
  const factory _PickupRespondResponse({
    required final PickupRequest pickup,
    final bool trackingEnabled,
    final String? trackableUserId,
  }) = _$PickupRespondResponseImpl;

  factory _PickupRespondResponse.fromJson(Map<String, dynamic> json) =
      _$PickupRespondResponseImpl.fromJson;

  @override
  PickupRequest get pickup;
  @override
  bool get trackingEnabled;
  @override
  String? get trackableUserId;

  /// Create a copy of PickupRespondResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickupRespondResponseImplCopyWith<_$PickupRespondResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TrackingLocation _$TrackingLocationFromJson(Map<String, dynamic> json) {
  return _TrackingLocation.fromJson(json);
}

/// @nodoc
mixin _$TrackingLocation {
  String get trackableUserId => throw _privateConstructorUsedError;
  PickupCoordinates? get location => throw _privateConstructorUsedError;
  String? get lastUpdated => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this TrackingLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrackingLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackingLocationCopyWith<TrackingLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingLocationCopyWith<$Res> {
  factory $TrackingLocationCopyWith(
    TrackingLocation value,
    $Res Function(TrackingLocation) then,
  ) = _$TrackingLocationCopyWithImpl<$Res, TrackingLocation>;
  @useResult
  $Res call({
    String trackableUserId,
    PickupCoordinates? location,
    String? lastUpdated,
    String? message,
  });

  $PickupCoordinatesCopyWith<$Res>? get location;
}

/// @nodoc
class _$TrackingLocationCopyWithImpl<$Res, $Val extends TrackingLocation>
    implements $TrackingLocationCopyWith<$Res> {
  _$TrackingLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackingLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackableUserId = null,
    Object? location = freezed,
    Object? lastUpdated = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            trackableUserId: null == trackableUserId
                ? _value.trackableUserId
                : trackableUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as PickupCoordinates?,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of TrackingLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PickupCoordinatesCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $PickupCoordinatesCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrackingLocationImplCopyWith<$Res>
    implements $TrackingLocationCopyWith<$Res> {
  factory _$$TrackingLocationImplCopyWith(
    _$TrackingLocationImpl value,
    $Res Function(_$TrackingLocationImpl) then,
  ) = __$$TrackingLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String trackableUserId,
    PickupCoordinates? location,
    String? lastUpdated,
    String? message,
  });

  @override
  $PickupCoordinatesCopyWith<$Res>? get location;
}

/// @nodoc
class __$$TrackingLocationImplCopyWithImpl<$Res>
    extends _$TrackingLocationCopyWithImpl<$Res, _$TrackingLocationImpl>
    implements _$$TrackingLocationImplCopyWith<$Res> {
  __$$TrackingLocationImplCopyWithImpl(
    _$TrackingLocationImpl _value,
    $Res Function(_$TrackingLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrackingLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackableUserId = null,
    Object? location = freezed,
    Object? lastUpdated = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _$TrackingLocationImpl(
        trackableUserId: null == trackableUserId
            ? _value.trackableUserId
            : trackableUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as PickupCoordinates?,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingLocationImpl implements _TrackingLocation {
  const _$TrackingLocationImpl({
    required this.trackableUserId,
    this.location,
    this.lastUpdated,
    this.message,
  });

  factory _$TrackingLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingLocationImplFromJson(json);

  @override
  final String trackableUserId;
  @override
  final PickupCoordinates? location;
  @override
  final String? lastUpdated;
  @override
  final String? message;

  @override
  String toString() {
    return 'TrackingLocation(trackableUserId: $trackableUserId, location: $location, lastUpdated: $lastUpdated, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingLocationImpl &&
            (identical(other.trackableUserId, trackableUserId) ||
                other.trackableUserId == trackableUserId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, trackableUserId, location, lastUpdated, message);

  /// Create a copy of TrackingLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingLocationImplCopyWith<_$TrackingLocationImpl> get copyWith =>
      __$$TrackingLocationImplCopyWithImpl<_$TrackingLocationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingLocationImplToJson(this);
  }
}

abstract class _TrackingLocation implements TrackingLocation {
  const factory _TrackingLocation({
    required final String trackableUserId,
    final PickupCoordinates? location,
    final String? lastUpdated,
    final String? message,
  }) = _$TrackingLocationImpl;

  factory _TrackingLocation.fromJson(Map<String, dynamic> json) =
      _$TrackingLocationImpl.fromJson;

  @override
  String get trackableUserId;
  @override
  PickupCoordinates? get location;
  @override
  String? get lastUpdated;
  @override
  String? get message;

  /// Create a copy of TrackingLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackingLocationImplCopyWith<_$TrackingLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
