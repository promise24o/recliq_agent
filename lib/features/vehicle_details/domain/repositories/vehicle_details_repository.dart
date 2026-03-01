import 'dart:io';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;

abstract class VehicleDetailsRepository {
  Future<vehicle.VehicleDetails> getVehicleDetails();
  Future<vehicle.VehicleDetails> createVehicleDetails(vehicle.CreateVehicleRequest request);
  Future<vehicle.VehicleDetails> updateVehicleDetails(vehicle.UpdateVehicleRequest request);
  Future<vehicle.VehicleDetails> updateVehicleStatus(vehicle.UpdateVehicleStatusRequest request);
  Future<vehicle.VehicleDetails> uploadVehicleDocument({
    required String documentType,
    required File document,
  });
}
