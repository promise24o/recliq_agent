import 'dart:io';
import 'package:dio/dio.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/domain/repositories/vehicle_details_repository.dart';

class VehicleDetailsRepositoryImpl implements VehicleDetailsRepository {
  final DioClient _dioClient;

  VehicleDetailsRepositoryImpl(this._dioClient);

  @override
  Future<vehicle.VehicleDetails> getVehicleDetails() async {
    try {
      final response = await _dioClient.get('/vehicle-details');
      return vehicle.VehicleDetails.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Vehicle details not found');
      }
      throw Exception('Failed to load vehicle details: ${e.message}');
    }
  }

  @override
  Future<vehicle.VehicleDetails> createVehicleDetails(vehicle.CreateVehicleRequest request) async {
    try {
      final response = await _dioClient.post(
        '/vehicle-details',
        data: request.toJson(),
      );
      return vehicle.VehicleDetails.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to create vehicle details: ${e.message}');
    }
  }

  @override
  Future<vehicle.VehicleDetails> updateVehicleDetails(vehicle.UpdateVehicleRequest request) async {
    try {
      final response = await _dioClient.put(
        '/vehicle-details',
        data: request.toJson(),
      );
      return vehicle.VehicleDetails.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to update vehicle details: ${e.message}');
    }
  }

  @override
  Future<vehicle.VehicleDetails> updateVehicleStatus(vehicle.UpdateVehicleStatusRequest request) async {
    try {
      final response = await _dioClient.patch(
        '/vehicle-details/status',
        data: request.toJson(),
      );
      return vehicle.VehicleDetails.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to update vehicle status: ${e.message}');
    }
  }

  @override
  Future<vehicle.VehicleDetails> uploadVehicleDocument({
    required String documentType,
    required File document,
  }) async {
    try {
      // Validate file size (10MB limit)
      final fileSize = await document.length();
      if (fileSize > 10 * 1024 * 1024) {
        throw Exception('File size must be less than 10MB');
      }

      // Validate file type
      final fileName = document.path.toLowerCase();
      final validExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.pdf'];
      final isValidFileType = validExtensions.any((ext) => fileName.endsWith(ext));
      
      if (!isValidFileType) {
        throw Exception('Invalid file type. Only JPG, PNG, GIF, and PDF files are allowed');
      }

      // Create multipart request
      final formData = FormData.fromMap({
        'documentType': documentType,
        'document': await MultipartFile.fromFile(
          document.path,
          filename: document.path.split('/').last,
        ),
      });

      final response = await _dioClient.post(
        '/vehicle-details/documents/upload',
        data: formData,
      );

      return vehicle.VehicleDetails.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 413) {
        throw Exception('File too large. Maximum size is 10MB');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid file format or type');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized. Please log in again');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Vehicle details not found. Please add your vehicle first');
      }
      throw Exception('Failed to upload document: ${e.message}');
    } catch (e) {
      throw Exception('Failed to upload document: ${e.toString()}');
    }
  }
}
