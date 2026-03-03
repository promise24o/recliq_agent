import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/availability/domain/entities/agent_availability.dart';
import 'package:recliq_agent/features/availability/domain/repositories/availability_repository.dart';

@LazySingleton(as: AvailabilityRepository)
class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final DioClient _dioClient;

  AvailabilityRepositoryImpl(this._dioClient);

  @override
  Future<AgentAvailability> getAvailability() async {
    try {
      final response = await _dioClient.get('/agent-availability');
      return AgentAvailability.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to load availability: ${e.message}');
    }
  }

  @override
  Future<AgentAvailability> updateAvailability(AgentAvailability availability) async {
    try {
      final payload = {
        'isOnline': availability.isOnline,
        'weeklySchedule': availability.weeklySchedule.toJson(),
        'availableForEnterpriseJobs': availability.availableForEnterpriseJobs,
        'autoGoOnlineDuringSchedule': availability.autoGoOnlineDuringSchedule,
      };

      final response = await _dioClient.put(
        '/agent-availability',
        data: payload,
      );

      return AgentAvailability.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to update availability: ${e.message}');
    }
  }

  @override
  Future<bool> updateOnlineStatus(
    bool isOnline, {
    double? lat,
    double? lng,
    double? accuracy,
  }) async {
    try {
      final payload = <String, dynamic>{'isOnline': isOnline};
      
      // Include location when going online (for Redis geo storage)
      if (isOnline && lat != null && lng != null) {
        payload['lat'] = lat;
        payload['lng'] = lng;
        if (accuracy != null) {
          payload['accuracy'] = accuracy;
        }
      }
      
      final response = await _dioClient.patch(
        '/agent-availability/online-status',
        data: payload,
      );

      final data = response.data as Map<String, dynamic>;
      return data['isOnline'] as bool;
    } on DioException catch (e) {
      throw Exception('Failed to update online status: ${e.message}');
    }
  }

  @override
  Future<bool> updateLocation(double lat, double lng, double accuracy) async {
    try {
      await _dioClient.post(
        '/agent-availability/location',
        data: {
          'lat': lat,
          'lng': lng,
          'accuracy': accuracy,
        },
      );
      return true;
    } on DioException catch (e) {
      throw Exception('Failed to update location: ${e.message}');
    }
  }
}
