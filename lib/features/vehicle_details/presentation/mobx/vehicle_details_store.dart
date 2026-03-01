import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'dart:io';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/domain/repositories/vehicle_details_repository.dart';

part 'vehicle_details_store.g.dart';

@injectable
class VehicleDetailsStore = _VehicleDetailsStore with _$VehicleDetailsStore;

abstract class _VehicleDetailsStore with Store {
  final VehicleDetailsRepository _repository;

  _VehicleDetailsStore(this._repository);

  @observable
  vehicle.VehicleDetails? vehicleDetails;

  @observable
  bool isLoading = false;

  @observable
  bool isSaving = false;

  @observable
  bool isCreating = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @computed
  bool get hasVehicle => vehicleDetails != null;

  @computed
  bool get canEditVehicle => vehicleDetails != null;

  @action
  Future<void> loadVehicleDetails() async {
    isLoading = true;
    errorMessage = null;

    try {
      vehicleDetails = await _repository.getVehicleDetails();
    } catch (e) {
      errorMessage = _getHumanizedErrorMessage(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> createVehicleDetails(vehicle.CreateVehicleRequest request) async {
    isCreating = true;
    errorMessage = null;
    successMessage = null;

    try {
      vehicleDetails = await _repository.createVehicleDetails(request);
      successMessage = 'Vehicle details created successfully';
      return true;
    } catch (e) {
      errorMessage = _getHumanizedErrorMessage(e.toString());
      return false;
    } finally {
      isCreating = false;
    }
  }

  @action
  Future<bool> updateVehicleDetails(vehicle.UpdateVehicleRequest request) async {
    if (vehicleDetails == null) return false;

    isSaving = true;
    errorMessage = null;
    successMessage = null;

    try {
      vehicleDetails = await _repository.updateVehicleDetails(request);
      successMessage = 'Vehicle details updated successfully';
      return true;
    } catch (e) {
      errorMessage = _getHumanizedErrorMessage(e.toString());
      return false;
    } finally {
      isSaving = false;
    }
  }

  @action
  Future<bool> updateVehicleStatus(vehicle.UpdateVehicleStatusRequest request) async {
    if (vehicleDetails == null) return false;

    isSaving = true;
    errorMessage = null;
    successMessage = null;

    try {
      vehicleDetails = await _repository.updateVehicleStatus(request);
      successMessage = 'Vehicle status updated successfully';
      return true;
    } catch (e) {
      errorMessage = _getHumanizedErrorMessage(e.toString());
      return false;
    } finally {
      isSaving = false;
    }
  }

  @action
  Future<bool> uploadVehicleDocument({
    required String documentType,
    required File document,
  }) async {
    isSaving = true;
    errorMessage = null;
    successMessage = null;

    try {
      vehicleDetails = await _repository.uploadVehicleDocument(
        documentType: documentType,
        document: document,
      );
      successMessage = 'Document uploaded successfully';
      return true;
    } catch (e) {
      errorMessage = _getHumanizedErrorMessage(e.toString());
      return false;
    } finally {
      isSaving = false;
    }
  }

  @action
  Future<void> refreshVehicleDetails() async {
    await loadVehicleDetails();
  }

  @action
  void updateVehicleType(vehicle.VehicleType type) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(vehicleType: type);
  }

  @action
  void updateMaxLoadWeight(int weight) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(maxLoadWeight: weight);
  }

  @action
  void updateMaxLoadVolume(int volume) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(maxLoadVolume: volume);
  }

  @action
  void updateMaterialCompatibility(List<vehicle.MaterialType> materials) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(materialCompatibility: materials);
  }

  @action
  void updatePlateNumber(String plateNumber) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(plateNumber: plateNumber);
  }

  @action
  void updateVehicleColor(String color) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(vehicleColor: color);
  }

  @action
  void updateRegistrationExpiryDate(DateTime date) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(registrationExpiryDate: date);
  }

  @action
  void updateInsuranceExpiryDate(DateTime date) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(insuranceExpiryDate: date);
  }

  @action
  void updateFuelType(vehicle.FuelType fuelType) {
    if (vehicleDetails == null) return;
    vehicleDetails = vehicleDetails!.copyWith(fuelType: fuelType);
  }

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  String _getHumanizedErrorMessage(String technicalError) {
    if (technicalError.contains('Vehicle details not found')) {
      return 'No vehicle details found. Please add your vehicle information to get started.';
    } else if (technicalError.contains('Failed to create vehicle details')) {
      return 'Couldn\'t save your vehicle information. Please check your details and try again.';
    } else if (technicalError.contains('Failed to update vehicle details')) {
      return 'Couldn\'t update your vehicle information. Please check your details and try again.';
    } else if (technicalError.contains('Failed to update vehicle status')) {
      return 'Couldn\'t update your vehicle status. Please try again.';
    } else if (technicalError.contains('Failed to upload document')) {
      return 'Couldn\'t upload your document. Please check the file and try again.';
    } else if (technicalError.contains('File size must be less than 10MB')) {
      return 'File is too large. Please choose a file smaller than 10MB.';
    } else if (technicalError.contains('Invalid file type')) {
      return 'Invalid file format. Please use JPG, PNG, GIF, or PDF files only.';
    } else if (technicalError.contains('File too large')) {
      return 'File is too large. Please choose a file smaller than 10MB.';
    } else if (technicalError.contains('500') || technicalError.contains('Internal Server Error')) {
      return 'Our servers are having a bit of trouble right now. Please try again in a moment.';
    } else if (technicalError.contains('401') || technicalError.contains('Unauthorized')) {
      return 'Your session has expired. Please log in again to continue.';
    } else if (technicalError.contains('403') || technicalError.contains('Forbidden')) {
      return 'You don\'t have permission to access this feature.';
    } else if (technicalError.contains('404') || technicalError.contains('Not Found')) {
      return 'We couldn\'t find what you\'re looking for. It may not exist or may have been moved.';
    } else if (technicalError.contains('timeout') || technicalError.contains('TimeoutException')) {
      return 'The connection is taking too long. Please check your internet connection and try again.';
    } else if (technicalError.contains('network') || technicalError.contains('SocketException')) {
      return 'Unable to connect to our servers. Please check your internet connection.';
    } else if (technicalError.contains('DioException')) {
      return 'Having trouble connecting to our servers. Please try again.';
    } else {
      return 'Something unexpected happened. Our team has been notified and is working on it.';
    }
  }
}
