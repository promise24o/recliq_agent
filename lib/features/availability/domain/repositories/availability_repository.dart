import 'package:recliq_agent/features/availability/domain/entities/agent_availability.dart';

abstract class AvailabilityRepository {
  Future<AgentAvailability> getAvailability();
  Future<AgentAvailability> updateAvailability(AgentAvailability availability);
  Future<bool> updateOnlineStatus(
    bool isOnline, {
    double? lat,
    double? lng,
    double? accuracy,
  });
  Future<bool> updateLocation(double lat, double lng, double accuracy);
}
