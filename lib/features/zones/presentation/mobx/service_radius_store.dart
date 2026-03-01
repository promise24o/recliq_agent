import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/zones/domain/entities/city.dart';
import 'package:recliq_agent/features/zones/domain/entities/zone.dart';
import 'package:recliq_agent/features/zones/domain/entities/service_radius.dart';
import 'package:recliq_agent/features/zones/domain/repositories/zones_repository.dart';

part 'service_radius_store.g.dart';

@injectable
class ServiceRadiusStore = _ServiceRadiusStore with _$ServiceRadiusStore;

abstract class _ServiceRadiusStore with Store {
  final ZonesRepository _repository;

  _ServiceRadiusStore(this._repository);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  List<City> cities = [];

  @observable
  List<Zone> zones = [];

  @observable
  ServiceRadius? serviceRadius;

  @observable
  double currentRadius = 5.0;

  @observable
  bool autoExpandRadius = false;

  @observable
  bool restrictDuringPeakHours = false;

  @observable
  ObservableSet<String> selectedZoneIds = ObservableSet<String>();

  @observable
  String? selectedCity;

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  @action
  Future<void> loadCities() async {
    isLoading = true;
    clearMessages();
    final result = await _repository.getCitiesList();
    result.fold(
      (failure) => errorMessage = failure.message,
      (citiesList) => cities = citiesList,
    );
    isLoading = false;
  }

  @action
  Future<void> loadZones({String? city}) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.getZonesList(city: city);
    result.fold(
      (failure) => errorMessage = failure.message,
      (zonesList) => zones = zonesList,
    );
    isLoading = false;
  }

  @action
  Future<void> loadServiceRadius() async {
    isLoading = true;
    clearMessages();
    final result = await _repository.getServiceRadius();
    result.fold(
      (failure) {
        // Use default values if service radius API fails
        errorMessage = 'Using default settings: ${failure.message}';
        serviceRadius = null;
        currentRadius = 10.0; // Default 10km radius
        autoExpandRadius = false;
        restrictDuringPeakHours = false;
        selectedZoneIds = ObservableSet<String>();
      },
      (radius) {
        serviceRadius = radius;
        currentRadius = radius.radius;
        autoExpandRadius = radius.autoExpandRadius;
        restrictDuringPeakHours = radius.restrictDuringPeakHours;
        selectedZoneIds.clear();
        selectedZoneIds.addAll(radius.serviceZones.map((zone) => zone.id));
        
        // Load zones to ensure we have the zone data for selected IDs
        _loadZonesForSelectedIds();
      },
    );
    isLoading = false;
  }

  Future<void> _loadZonesForSelectedIds() async {
    if (selectedZoneIds.isEmpty) return;
    
    // If zones list is empty or doesn't contain selected zones, load all zones
    final hasAllZones = selectedZoneIds.every((id) => zones.any((zone) => zone.id == id));
    if (!hasAllZones) {
      await loadZones(); // Load all zones for the default city
    }
  }

  @action
  void setRadius(double value) {
    currentRadius = value;
  }

  @action
  void setAutoExpandRadius(bool value) {
    autoExpandRadius = value;
  }

  @action
  void setRestrictDuringPeakHours(bool value) {
    restrictDuringPeakHours = value;
  }

  @action
  void toggleZoneSelection(String zoneId) {
    if (selectedZoneIds.contains(zoneId)) {
      selectedZoneIds.remove(zoneId);
    } else {
      selectedZoneIds.add(zoneId);
    }
  }

  @action
  void setSelectedCity(String? city) {
    selectedCity = city;
    if (city != null) {
      loadZones(city: city);
    }
  }

  @action
  Future<bool> updateServiceRadius() async {
    isLoading = true;
    clearMessages();
    final result = await _repository.updateServiceRadius(
      radius: currentRadius,
      autoExpandRadius: autoExpandRadius,
      restrictDuringPeakHours: restrictDuringPeakHours,
      serviceZones: selectedZoneIds.toList(),
    );
    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (updatedRadius) {
        serviceRadius = updatedRadius;
        successMessage = 'Service radius updated successfully';
        success = true;
      },
    );
    isLoading = false;
    return success;
  }

  List<Zone> get selectedZones {
    return zones.where((zone) => selectedZoneIds.contains(zone.id)).toList();
  }

  bool get hasLargeRadius {
    return currentRadius > 20;
  }

  String get radiusWarning {
    if (currentRadius > 20) {
      return '⚠ Large radius may affect response time and performance score.';
    }
    return '';
  }
}
