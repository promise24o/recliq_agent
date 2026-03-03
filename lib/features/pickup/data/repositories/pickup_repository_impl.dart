import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/pickup/data/datasources/pickup_remote_datasource.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/domain/repositories/pickup_repository.dart';

@LazySingleton(as: PickupRepository)
class PickupRepositoryImpl implements PickupRepository {
  final PickupRemoteDataSource _remoteDataSource;

  PickupRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<PickupRequest>>> getPendingRequests() async {
    try {
      final result = await _remoteDataSource.getPendingRequests();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PickupRequest>> getPickupDetails(String pickupId) async {
    try {
      final result = await _remoteDataSource.getPickupDetails(pickupId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PickupRespondResponse>> respondToPickup({
    required String pickupId,
    required String response,
    String? reason,
    int? estimatedArrivalMinutes,
  }) async {
    try {
      final result = await _remoteDataSource.respondToPickup(
        pickupId: pickupId,
        response: response,
        reason: reason,
        estimatedArrivalMinutes: estimatedArrivalMinutes,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrackingLocation>> getTrackingLocation(String pickupId) async {
    try {
      final result = await _remoteDataSource.getTrackingLocation(pickupId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PickupRequest>> updatePickupStatus({
    required String pickupId,
    required String status,
  }) async {
    try {
      final result = await _remoteDataSource.updatePickupStatus(
        pickupId: pickupId,
        status: status,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PickupRequest>> completePickup({
    required String pickupId,
    required double actualWeight,
    String? proofImageUrl,
  }) async {
    try {
      final result = await _remoteDataSource.completePickup(
        pickupId: pickupId,
        actualWeight: actualWeight,
        proofImageUrl: proofImageUrl,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
