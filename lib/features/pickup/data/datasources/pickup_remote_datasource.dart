import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';

abstract class PickupRemoteDataSource {
  Future<List<PickupRequest>> getPendingRequests();
  Future<PickupRequest> getPickupDetails(String pickupId);
  Future<PickupRespondResponse> respondToPickup({
    required String pickupId,
    required String response,
    String? reason,
    int? estimatedArrivalMinutes,
  });
  Future<TrackingLocation> getTrackingLocation(String pickupId);
  Future<PickupRequest> updatePickupStatus({
    required String pickupId,
    required String status,
  });
  Future<PickupRequest> completePickup({
    required String pickupId,
    required double actualWeight,
    String? proofImageUrl,
  });
}

@LazySingleton(as: PickupRemoteDataSource)
class PickupRemoteDataSourceImpl implements PickupRemoteDataSource {
  final DioClient _dioClient;

  PickupRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<PickupRequest>> getPendingRequests() async {
    try {
      final response = await _dioClient.get('/pickup/agent/pending');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => PickupRequest.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch pending requests',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PickupRequest> getPickupDetails(String pickupId) async {
    try {
      final response = await _dioClient.get('/pickup/$pickupId');
      return PickupRequest.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch pickup details',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PickupRespondResponse> respondToPickup({
    required String pickupId,
    required String response,
    String? reason,
    int? estimatedArrivalMinutes,
  }) async {
    try {
      final payload = <String, dynamic>{
        'response': response,
      };
      if (reason != null) {
        payload['reason'] = reason;
      }
      if (estimatedArrivalMinutes != null) {
        payload['estimatedArrivalMinutes'] = estimatedArrivalMinutes;
      }

      final apiResponse = await _dioClient.patch(
        '/pickup/$pickupId/respond',
        data: payload,
      );
      return PickupRespondResponse.fromJson(apiResponse.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to respond to pickup',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<TrackingLocation> getTrackingLocation(String pickupId) async {
    try {
      final response = await _dioClient.get('/pickup/$pickupId/track-location');
      return TrackingLocation.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get tracking location',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PickupRequest> updatePickupStatus({
    required String pickupId,
    required String status,
  }) async {
    try {
      final response = await _dioClient.patch(
        '/pickup/$pickupId/status',
        data: {'status': status},
      );
      return PickupRequest.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to update pickup status',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PickupRequest> completePickup({
    required String pickupId,
    required double actualWeight,
    String? proofImageUrl,
  }) async {
    try {
      final payload = <String, dynamic>{
        'actualWeight': actualWeight,
      };
      if (proofImageUrl != null) {
        payload['proofImageUrl'] = proofImageUrl;
      }

      final response = await _dioClient.patch(
        '/pickup/$pickupId/complete',
        data: payload,
      );
      return PickupRequest.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to complete pickup',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
