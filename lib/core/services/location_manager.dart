import 'dart:async';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:recliq_agent/core/constants/app_config.dart';

enum LocationUpdateFrequency {
  active, // 5s - on pickup
  available, // 10s - nearby requests
  idle, // 30s - no activity
  lowBattery, // 120s - battery < 20%
  background, // 300s - background only
}

class LocationData {
  final double latitude;
  final double longitude;
  final double accuracy;
  final int timestamp;

  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'lat': latitude,
        'lng': longitude,
        'accuracy': accuracy,
        'timestamp': timestamp,
      };

  @override
  String toString() =>
      'LocationData(lat: $latitude, lng: $longitude, accuracy: ${accuracy.toStringAsFixed(1)}m)';
}

class LocationManager {
  Timer? _locationTimer;
  LocationData? _lastLocation;
  LocationUpdateFrequency _currentFrequency = LocationUpdateFrequency.idle;
  bool _isTracking = false;

  final StreamController<LocationData> _locationController =
      StreamController<LocationData>.broadcast();

  Stream<LocationData> get locationStream => _locationController.stream;
  LocationData? get lastLocation => _lastLocation;
  bool get isTracking => _isTracking;

  int get _currentIntervalSeconds {
    switch (_currentFrequency) {
      case LocationUpdateFrequency.active:
        return AppConfig.locationUpdateIntervalActive;
      case LocationUpdateFrequency.available:
        return AppConfig.locationUpdateIntervalAvailable;
      case LocationUpdateFrequency.idle:
        return AppConfig.locationUpdateIntervalIdle;
      case LocationUpdateFrequency.lowBattery:
        return AppConfig.locationUpdateIntervalLowBattery;
      case LocationUpdateFrequency.background:
        return AppConfig.locationUpdateIntervalBackground;
    }
  }

  /// Check and request location permissions
  Future<bool> requestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('[LocationManager] Location services disabled');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('[LocationManager] Location permission denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('[LocationManager] Location permission permanently denied');
      return false;
    }

    return true;
  }

  /// Start GPS polling at the current frequency
  Future<void> startTracking() async {
    if (_isTracking) return;

    final hasPermission = await requestPermission();
    if (!hasPermission) {
      print('[LocationManager] Cannot start tracking - no permission');
      return;
    }

    _isTracking = true;
    print('[LocationManager] Started tracking (${_currentFrequency.name}, ${_currentIntervalSeconds}s)');

    // Get initial position immediately
    await _pollLocation();

    // Start periodic polling
    _startTimer();
  }

  /// Stop GPS polling
  void stopTracking() {
    _isTracking = false;
    _locationTimer?.cancel();
    _locationTimer = null;
    print('[LocationManager] Stopped tracking');
  }

  /// Update the polling frequency
  void setFrequency(LocationUpdateFrequency frequency) {
    if (_currentFrequency == frequency) return;

    _currentFrequency = frequency;
    print('[LocationManager] Frequency changed to ${frequency.name} (${_currentIntervalSeconds}s)');

    if (_isTracking) {
      _locationTimer?.cancel();
      _startTimer();
    }
  }

  void _startTimer() {
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(
      Duration(seconds: _currentIntervalSeconds),
      (_) => _pollLocation(),
    );
  }

  Future<void> _pollLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final locationData = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      // Validate accuracy
      if (locationData.accuracy > AppConfig.locationAccuracyThreshold) {
        print('[LocationManager] Rejected: accuracy ${locationData.accuracy.toStringAsFixed(1)}m > ${AppConfig.locationAccuracyThreshold}m');
        return;
      }

      // Validate coordinates
      if (!_isValidCoordinate(locationData.latitude, locationData.longitude)) {
        print('[LocationManager] Rejected: invalid coordinates (${locationData.latitude}, ${locationData.longitude})');
        return;
      }

      // Check if stationary (skip if not moved significantly)
      if (_lastLocation != null && _isStationary(locationData)) {
        return;
      }

      _lastLocation = locationData;
      _locationController.add(locationData);
    } catch (e) {
      print('[LocationManager] GPS error: $e');
    }
  }

  bool _isValidCoordinate(double lat, double lng) {
    return lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180;
  }

  bool _isStationary(LocationData newLocation) {
    if (_lastLocation == null) return false;

    final distance = _calculateDistance(
      _lastLocation!.latitude,
      _lastLocation!.longitude,
      newLocation.latitude,
      newLocation.longitude,
    );

    return distance < AppConfig.locationStationaryThreshold;
  }

  /// Haversine formula for distance in meters
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000.0; // Earth radius in meters
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;

  void dispose() {
    stopTracking();
    _locationController.close();
  }
}
