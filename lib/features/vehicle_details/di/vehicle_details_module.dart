import 'package:injectable/injectable.dart';
import 'package:recliq_agent/features/vehicle_details/data/repositories/vehicle_details_repository_impl.dart';
import 'package:recliq_agent/features/vehicle_details/domain/repositories/vehicle_details_repository.dart';

@module
abstract class VehicleDetailsModule {
  @LazySingleton(as: VehicleDetailsRepository)
  VehicleDetailsRepositoryImpl get vehicleDetailsRepository;
}
