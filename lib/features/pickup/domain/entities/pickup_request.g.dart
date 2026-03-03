// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickupCoordinatesImpl _$$PickupCoordinatesImplFromJson(
  Map<String, dynamic> json,
) => _$PickupCoordinatesImpl(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$$PickupCoordinatesImplToJson(
  _$PickupCoordinatesImpl instance,
) => <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

_$PickupPricingImpl _$$PickupPricingImplFromJson(Map<String, dynamic> json) =>
    _$PickupPricingImpl(
      baseAmount: (json['baseAmount'] as num?)?.toDouble() ?? 0,
      bonusAmount: (json['bonusAmount'] as num?)?.toDouble() ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? 'NGN',
    );

Map<String, dynamic> _$$PickupPricingImplToJson(_$PickupPricingImpl instance) =>
    <String, dynamic>{
      'baseAmount': instance.baseAmount,
      'bonusAmount': instance.bonusAmount,
      'totalAmount': instance.totalAmount,
      'currency': instance.currency,
    };

_$MatchingTimelineEventImpl _$$MatchingTimelineEventImplFromJson(
  Map<String, dynamic> json,
) => _$MatchingTimelineEventImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  timestamp: json['timestamp'] as String,
  agentId: json['agentId'] as String?,
  agentName: json['agentName'] as String?,
  details: json['details'] as String?,
);

Map<String, dynamic> _$$MatchingTimelineEventImplToJson(
  _$MatchingTimelineEventImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'timestamp': instance.timestamp,
  'agentId': instance.agentId,
  'agentName': instance.agentName,
  'details': instance.details,
};

_$PickupRequestImpl _$$PickupRequestImplFromJson(Map<String, dynamic> json) =>
    _$PickupRequestImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String?,
      userPhone: json['userPhone'] as String?,
      city: json['city'] as String?,
      zone: json['zone'] as String?,
      pickupMode: $enumDecode(_$PickupModeEnumMap, json['pickupMode']),
      matchType: json['matchType'] as String?,
      wasteType: $enumDecode(_$WasteTypeEnumMap, json['wasteType']),
      estimatedWeight: (json['estimatedWeight'] as num).toDouble(),
      status: $enumDecode(_$PickupStatusEnumMap, json['status']),
      assignedAgentId: json['assignedAgentId'] as String?,
      assignedAgentName: json['assignedAgentName'] as String?,
      slaDeadline: json['slaDeadline'] as String?,
      pricing: json['pricing'] == null
          ? null
          : PickupPricing.fromJson(json['pricing'] as Map<String, dynamic>),
      coordinates: json['coordinates'] == null
          ? null
          : PickupCoordinates.fromJson(
              json['coordinates'] as Map<String, dynamic>,
            ),
      address: json['address'] as String?,
      notes: json['notes'] as String?,
      matchingTimeline:
          (json['matchingTimeline'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MatchingTimelineEvent.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      cancellationReason: json['cancellationReason'] as String?,
      cancelledAt: json['cancelledAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$PickupRequestImplToJson(_$PickupRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhone': instance.userPhone,
      'city': instance.city,
      'zone': instance.zone,
      'pickupMode': _$PickupModeEnumMap[instance.pickupMode]!,
      'matchType': instance.matchType,
      'wasteType': _$WasteTypeEnumMap[instance.wasteType]!,
      'estimatedWeight': instance.estimatedWeight,
      'status': _$PickupStatusEnumMap[instance.status]!,
      'assignedAgentId': instance.assignedAgentId,
      'assignedAgentName': instance.assignedAgentName,
      'slaDeadline': instance.slaDeadline,
      'pricing': instance.pricing,
      'coordinates': instance.coordinates,
      'address': instance.address,
      'notes': instance.notes,
      'matchingTimeline': instance.matchingTimeline,
      'cancellationReason': instance.cancellationReason,
      'cancelledAt': instance.cancelledAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$PickupModeEnumMap = {
  PickupMode.pickup: 'pickup',
  PickupMode.dropoff: 'dropoff',
};

const _$WasteTypeEnumMap = {
  WasteType.plastic: 'plastic',
  WasteType.paper: 'paper',
  WasteType.metal: 'metal',
  WasteType.glass: 'glass',
  WasteType.organic: 'organic',
  WasteType.eWaste: 'e_waste',
  WasteType.mixed: 'mixed',
};

const _$PickupStatusEnumMap = {
  PickupStatus.newRequest: 'new',
  PickupStatus.matching: 'matching',
  PickupStatus.pendingAcceptance: 'pending_acceptance',
  PickupStatus.assigned: 'assigned',
  PickupStatus.agentEnRoute: 'agent_en_route',
  PickupStatus.arrived: 'arrived',
  PickupStatus.completed: 'completed',
  PickupStatus.cancelled: 'cancelled',
  PickupStatus.failed: 'failed',
};

_$PickupRespondRequestImpl _$$PickupRespondRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PickupRespondRequestImpl(
  response: json['response'] as String,
  reason: json['reason'] as String?,
  estimatedArrivalMinutes: (json['estimatedArrivalMinutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$$PickupRespondRequestImplToJson(
  _$PickupRespondRequestImpl instance,
) => <String, dynamic>{
  'response': instance.response,
  'reason': instance.reason,
  'estimatedArrivalMinutes': instance.estimatedArrivalMinutes,
};

_$PickupRespondResponseImpl _$$PickupRespondResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PickupRespondResponseImpl(
  pickup: PickupRequest.fromJson(json['pickup'] as Map<String, dynamic>),
  trackingEnabled: json['trackingEnabled'] as bool? ?? false,
  trackableUserId: json['trackableUserId'] as String?,
);

Map<String, dynamic> _$$PickupRespondResponseImplToJson(
  _$PickupRespondResponseImpl instance,
) => <String, dynamic>{
  'pickup': instance.pickup,
  'trackingEnabled': instance.trackingEnabled,
  'trackableUserId': instance.trackableUserId,
};

_$TrackingLocationImpl _$$TrackingLocationImplFromJson(
  Map<String, dynamic> json,
) => _$TrackingLocationImpl(
  trackableUserId: json['trackableUserId'] as String,
  location: json['location'] == null
      ? null
      : PickupCoordinates.fromJson(json['location'] as Map<String, dynamic>),
  lastUpdated: json['lastUpdated'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$$TrackingLocationImplToJson(
  _$TrackingLocationImpl instance,
) => <String, dynamic>{
  'trackableUserId': instance.trackableUserId,
  'location': instance.location,
  'lastUpdated': instance.lastUpdated,
  'message': instance.message,
};
