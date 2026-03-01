import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/zones/domain/entities/city.dart';
import 'package:recliq_agent/features/zones/domain/entities/zone.dart';
import 'package:recliq_agent/features/zones/domain/entities/service_radius.dart';

abstract class ZonesRepository {
  Future<Either<Failure, List<City>>> getCitiesList();
  Future<Either<Failure, List<Zone>>> getZonesList({String? city});
  Future<Either<Failure, ServiceRadius>> getServiceRadius();
  Future<Either<Failure, ServiceRadius>> updateServiceRadius({
    required double radius,
    required bool autoExpandRadius,
    required bool restrictDuringPeakHours,
    required List<String> serviceZones,
  });
}
