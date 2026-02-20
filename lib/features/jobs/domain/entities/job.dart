import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';
part 'job.g.dart';

enum JobStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('arrived')
  arrived,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

enum JobType {
  @JsonValue('nearby')
  nearby,
  @JsonValue('assigned')
  assigned,
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('enterprise')
  enterprise,
}

@freezed
class Job with _$Job {
  const factory Job({
    required String id,
    required String wasteType,
    required double estimatedWeight,
    required double estimatedPayout,
    required double distance,
    required JobStatus status,
    required JobType type,
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
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}
