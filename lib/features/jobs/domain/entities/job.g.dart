// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobImpl _$$JobImplFromJson(Map<String, dynamic> json) => _$JobImpl(
  id: json['id'] as String,
  wasteType: json['wasteType'] as String,
  estimatedWeight: (json['estimatedWeight'] as num).toDouble(),
  estimatedPayout: (json['estimatedPayout'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
  status: $enumDecode(_$JobStatusEnumMap, json['status']),
  type: $enumDecode(_$JobTypeEnumMap, json['type']),
  customerName: json['customerName'] as String?,
  customerPhone: json['customerPhone'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  slaTime: json['slaTime'] as String?,
  scheduledAt: json['scheduledAt'] as String?,
  pricePerKg: (json['pricePerKg'] as num?)?.toDouble(),
  isEscrowSecured: json['isEscrowSecured'] as bool?,
  complianceNotes: json['complianceNotes'] as String?,
  actualWeight: (json['actualWeight'] as num?)?.toDouble(),
  proofImageUrl: json['proofImageUrl'] as String?,
  createdAt: json['createdAt'] as String?,
  completedAt: json['completedAt'] as String?,
);

Map<String, dynamic> _$$JobImplToJson(_$JobImpl instance) => <String, dynamic>{
  'id': instance.id,
  'wasteType': instance.wasteType,
  'estimatedWeight': instance.estimatedWeight,
  'estimatedPayout': instance.estimatedPayout,
  'distance': instance.distance,
  'status': _$JobStatusEnumMap[instance.status]!,
  'type': _$JobTypeEnumMap[instance.type]!,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'slaTime': instance.slaTime,
  'scheduledAt': instance.scheduledAt,
  'pricePerKg': instance.pricePerKg,
  'isEscrowSecured': instance.isEscrowSecured,
  'complianceNotes': instance.complianceNotes,
  'actualWeight': instance.actualWeight,
  'proofImageUrl': instance.proofImageUrl,
  'createdAt': instance.createdAt,
  'completedAt': instance.completedAt,
};

const _$JobStatusEnumMap = {
  JobStatus.pending: 'pending',
  JobStatus.accepted: 'accepted',
  JobStatus.inProgress: 'in_progress',
  JobStatus.arrived: 'arrived',
  JobStatus.completed: 'completed',
  JobStatus.cancelled: 'cancelled',
};

const _$JobTypeEnumMap = {
  JobType.nearby: 'nearby',
  JobType.assigned: 'assigned',
  JobType.scheduled: 'scheduled',
  JobType.enterprise: 'enterprise',
};
