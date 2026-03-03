import 'package:freezed_annotation/freezed_annotation.dart';

part 'pickup_request.freezed.dart';
part 'pickup_request.g.dart';

enum PickupStatus {
  @JsonValue('new')
  newRequest,
  @JsonValue('matching')
  matching,
  @JsonValue('pending_acceptance')
  pendingAcceptance,
  @JsonValue('assigned')
  assigned,
  @JsonValue('agent_en_route')
  agentEnRoute,
  @JsonValue('arrived')
  arrived,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('failed')
  failed,
}

enum PickupMode {
  @JsonValue('pickup')
  pickup,
  @JsonValue('dropoff')
  dropoff,
}

enum WasteType {
  @JsonValue('plastic')
  plastic,
  @JsonValue('paper')
  paper,
  @JsonValue('metal')
  metal,
  @JsonValue('glass')
  glass,
  @JsonValue('organic')
  organic,
  @JsonValue('e_waste')
  eWaste,
  @JsonValue('mixed')
  mixed,
}

@freezed
class PickupCoordinates with _$PickupCoordinates {
  const factory PickupCoordinates({
    required double lat,
    required double lng,
  }) = _PickupCoordinates;

  factory PickupCoordinates.fromJson(Map<String, dynamic> json) =>
      _$PickupCoordinatesFromJson(json);
}

@freezed
class PickupPricing with _$PickupPricing {
  const factory PickupPricing({
    @Default(0) double baseAmount,
    @Default(0) double bonusAmount,
    @Default(0) double totalAmount,
    @Default('NGN') String currency,
  }) = _PickupPricing;

  factory PickupPricing.fromJson(Map<String, dynamic> json) =>
      _$PickupPricingFromJson(json);
}

@freezed
class MatchingTimelineEvent with _$MatchingTimelineEvent {
  const factory MatchingTimelineEvent({
    required String id,
    required String type,
    required String timestamp,
    String? agentId,
    String? agentName,
    String? details,
  }) = _MatchingTimelineEvent;

  factory MatchingTimelineEvent.fromJson(Map<String, dynamic> json) =>
      _$MatchingTimelineEventFromJson(json);
}

@freezed
class PickupRequest with _$PickupRequest {
  const factory PickupRequest({
    required String id,
    required String userId,
    String? userName,
    String? userPhone,
    String? city,
    String? zone,
    required PickupMode pickupMode,
    String? matchType,
    required WasteType wasteType,
    required double estimatedWeight,
    required PickupStatus status,
    String? assignedAgentId,
    String? assignedAgentName,
    String? slaDeadline,
    PickupPricing? pricing,
    PickupCoordinates? coordinates,
    String? address,
    String? notes,
    @Default([]) List<MatchingTimelineEvent> matchingTimeline,
    String? cancellationReason,
    String? cancelledAt,
    String? createdAt,
    String? updatedAt,
  }) = _PickupRequest;

  factory PickupRequest.fromJson(Map<String, dynamic> json) =>
      _$PickupRequestFromJson(json);
}

@freezed
class PickupRespondRequest with _$PickupRespondRequest {
  const factory PickupRespondRequest({
    required String response, // 'accept' or 'decline'
    String? reason, // Required if response=decline
    int? estimatedArrivalMinutes, // Optional if response=accept
  }) = _PickupRespondRequest;

  factory PickupRespondRequest.fromJson(Map<String, dynamic> json) =>
      _$PickupRespondRequestFromJson(json);
}

@freezed
class PickupRespondResponse with _$PickupRespondResponse {
  const factory PickupRespondResponse({
    required PickupRequest pickup,
    @Default(false) bool trackingEnabled,
    String? trackableUserId,
  }) = _PickupRespondResponse;

  factory PickupRespondResponse.fromJson(Map<String, dynamic> json) =>
      _$PickupRespondResponseFromJson(json);
}

@freezed
class TrackingLocation with _$TrackingLocation {
  const factory TrackingLocation({
    required String trackableUserId,
    PickupCoordinates? location,
    String? lastUpdated,
    String? message,
  }) = _TrackingLocation;

  factory TrackingLocation.fromJson(Map<String, dynamic> json) =>
      _$TrackingLocationFromJson(json);
}
