import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/zones/data/datasources/zones_remote_data_source.dart';
import 'package:recliq_agent/features/zones/domain/entities/city.dart';
import 'package:recliq_agent/features/zones/domain/entities/zone.dart';
import 'package:recliq_agent/features/zones/domain/entities/service_radius.dart';
import 'package:recliq_agent/features/zones/domain/repositories/zones_repository.dart';

@LazySingleton(as: ZonesRepository)
class ZonesRepositoryImpl implements ZonesRepository {
  final ZonesRemoteDataSource remoteDataSource;

  ZonesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<City>>> getCitiesList() async {
    try {
      final cities = await remoteDataSource.getCitiesList();
      return Right(cities);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(const Failure.unknownError('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<Zone>>> getZonesList({String? city}) async {
    try {
      final zones = await remoteDataSource.getZonesList(city: city);
      return Right(zones);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(const Failure.unknownError('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ServiceRadius>> getServiceRadius() async {
    try {
      final serviceRadius = await remoteDataSource.getServiceRadius();
      return Right(serviceRadius);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(const Failure.unknownError('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ServiceRadius>> updateServiceRadius({
    required double radius,
    required bool autoExpandRadius,
    required bool restrictDuringPeakHours,
    required List<String> serviceZones,
  }) async {
    try {
      final serviceRadius = await remoteDataSource.updateServiceRadius(
        radius: radius,
        autoExpandRadius: autoExpandRadius,
        restrictDuringPeakHours: restrictDuringPeakHours,
        serviceZones: serviceZones,
      );
      return Right(serviceRadius);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(const Failure.unknownError('An unexpected error occurred'));
    }
  }
}
