import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';

abstract class PickupRepository {
  /// Get all pending pickup requests for the agent
  Future<Either<Failure, List<PickupRequest>>> getPendingRequests();

  /// Get pickup request details by ID
  Future<Either<Failure, PickupRequest>> getPickupDetails(String pickupId);

  /// Respond to a pickup request (accept or decline)
  Future<Either<Failure, PickupRespondResponse>> respondToPickup({
    required String pickupId,
    required String response,
    String? reason,
    int? estimatedArrivalMinutes,
  });

  /// Get tracking location for a pickup
  Future<Either<Failure, TrackingLocation>> getTrackingLocation(String pickupId);

  /// Update pickup status (agent_en_route, arrived, etc.)
  Future<Either<Failure, PickupRequest>> updatePickupStatus({
    required String pickupId,
    required String status,
  });

  /// Complete a pickup
  Future<Either<Failure, PickupRequest>> completePickup({
    required String pickupId,
    required double actualWeight,
    String? proofImageUrl,
  });
}
