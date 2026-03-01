import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/zones/domain/entities/city.dart';
import 'package:recliq_agent/features/zones/domain/entities/zone.dart';
import 'package:recliq_agent/features/zones/domain/entities/service_radius.dart';

abstract class ZonesRemoteDataSource {
  Future<List<City>> getCitiesList();
  Future<List<Zone>> getZonesList({String? city});
  Future<ServiceRadius> getServiceRadius();
  Future<ServiceRadius> updateServiceRadius({
    required double radius,
    required bool autoExpandRadius,
    required bool restrictDuringPeakHours,
    required List<String> serviceZones,
  });
}

@LazySingleton(as: ZonesRemoteDataSource)
class ZonesRemoteDataSourceImpl implements ZonesRemoteDataSource {
  final DioClient dioClient;

  ZonesRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<City>> getCitiesList() async {
    try {
      final response = await dioClient.get('/zones/cities/list');
      final cities = (response.data['cities'] as List<dynamic>)
          .map((json) => City.fromJson(json as Map<String, dynamic>))
          .toList();
      return cities;
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response?.data['message'] ?? 'Failed to fetch cities';
        throw ServerException(message: message);
      }
      throw ServerException(message: 'Network error occurred');
    }
  }

  @override
  Future<List<Zone>> getZonesList({String? city}) async {
    try {
      final queryParams = city != null ? {'city': city} : null;
      final response = await dioClient.get(
        '/zones/zones/list',
        queryParameters: queryParams,
      );
      final zones = (response.data['zones'] as List<dynamic>)
          .map((json) => Zone.fromJson(json as Map<String, dynamic>))
          .toList();
      return zones;
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response?.data['message'] ?? 'Failed to fetch zones';
        throw ServerException(message: message);
      }
      throw ServerException(message: 'Network error occurred');
    }
  }

  @override
  Future<ServiceRadius> getServiceRadius() async {
    try {
      final response = await dioClient.get('/service-radius');
      return ServiceRadius.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response != null) {
        final message =
            e.response?.data['message'] ?? 'Failed to fetch service radius';
        throw ServerException(message: message);
      }
      throw ServerException(message: 'Network error occurred');
    }
  }

  @override
  Future<ServiceRadius> updateServiceRadius({
    required double radius,
    required bool autoExpandRadius,
    required bool restrictDuringPeakHours,
    required List<String> serviceZones,
  }) async {
    try {
      final response = await dioClient.put(
        '/service-radius',
        data: {
          'radius': radius,
          'autoExpandRadius': autoExpandRadius,
          'restrictDuringPeakHours': restrictDuringPeakHours,
          'serviceZones': serviceZones,
        },
      );
      return ServiceRadius.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response != null) {
        final message =
            e.response?.data['message'] ?? 'Failed to update service radius';
        throw ServerException(message: message);
      }
      throw ServerException(message: 'Network error occurred');
    }
  }
}
