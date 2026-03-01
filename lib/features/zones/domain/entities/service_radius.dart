import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCoordinates {
  final double latitude;
  final double longitude;

  const LocationCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) {
    return LocationCoordinates(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Boundary {
  final LatLng center;
  final List<LatLng> polygon;
  final double? areaKm2;

  const Boundary({
    required this.center,
    required this.polygon,
    this.areaKm2,
  });

  factory Boundary.fromJson(Map<String, dynamic> json) {
    return Boundary(
      center: LatLng(
        (json['center']['lat'] as num).toDouble(),
        (json['center']['lng'] as num).toDouble(),
      ),
      polygon: (json['polygon'] as List<dynamic>)
          .map((point) => LatLng(
                (point['lat'] as num).toDouble(),
                (point['lng'] as num).toDouble(),
              ))
          .toList(),
      areaKm2: json['areaKm2']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'center': {
        'lat': center.latitude,
        'lng': center.longitude,
      },
      'polygon': polygon.map((point) => {
        'lat': point.latitude,
        'lng': point.longitude,
      }).toList(),
      if (areaKm2 != null) 'areaKm2': areaKm2,
    };
  }
}

class ServiceZone {
  final String id;
  final String name;
  final String city;
  final String state;
  final String? description;
  final Boundary? boundary;
  final double? areaKm2;
  final LatLng? center;

  const ServiceZone({
    required this.id,
    required this.name,
    required this.city,
    required this.state,
    this.description,
    this.boundary,
    this.areaKm2,
    this.center,
  });

  factory ServiceZone.fromJson(Map<String, dynamic> json) {
    return ServiceZone(
      id: json['_id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      description: json['description'] as String?,
      boundary: json['boundary'] != null 
          ? Boundary.fromJson(json['boundary'] as Map<String, dynamic>)
          : null,
      areaKm2: json['areaKm2']?.toDouble(),
      center: json['center'] != null
          ? LatLng(
              (json['center']['lat'] as num).toDouble(),
              (json['center']['lng'] as num).toDouble(),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'name': name,
      'city': city,
      'state': state,
    };
    
    if (description != null) {
      data['description'] = description;
    }
    
    if (boundary != null) {
      data['boundary'] = boundary!.toJson();
    }
    
    if (areaKm2 != null) {
      data['areaKm2'] = areaKm2;
    }
    
    if (center != null) {
      data['center'] = {
        'lat': center!.latitude,
        'lng': center!.longitude,
      };
    }
    
    return data;
  }
}

class ServiceRadius {
  final double radius;
  final bool autoExpandRadius;
  final bool restrictDuringPeakHours;
  final List<ServiceZone> serviceZones;
  final LocationCoordinates? currentLocation;
  final int? estimatedDailyRequests;
  final double? averagePayoutPerJob;
  final double? estimatedFuelCost;
  final int? averageResponseTime;
  final DateTime? updatedAt;

  const ServiceRadius({
    required this.radius,
    required this.autoExpandRadius,
    required this.restrictDuringPeakHours,
    required this.serviceZones,
    this.currentLocation,
    this.estimatedDailyRequests,
    this.averagePayoutPerJob,
    this.estimatedFuelCost,
    this.averageResponseTime,
    this.updatedAt,
  });

  factory ServiceRadius.fromJson(Map<String, dynamic> json) {
    return ServiceRadius(
      radius: (json['radius'] as num).toDouble(),
      autoExpandRadius: json['autoExpandRadius'] as bool,
      restrictDuringPeakHours: json['restrictDuringPeakHours'] as bool,
      serviceZones: (json['serviceZones'] as List<dynamic>)
          .map((e) => ServiceZone.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentLocation: json['currentLocation'] != null
          ? LocationCoordinates.fromJson(
              json['currentLocation'] as Map<String, dynamic>)
          : null,
      estimatedDailyRequests: json['estimatedDailyRequests'] as int?,
      averagePayoutPerJob: json['averagePayoutPerJob'] != null
          ? (json['averagePayoutPerJob'] as num).toDouble()
          : null,
      estimatedFuelCost: json['estimatedFuelCost'] != null
          ? (json['estimatedFuelCost'] as num).toDouble()
          : null,
      averageResponseTime: json['averageResponseTime'] as int?,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'radius': radius,
      'autoExpandRadius': autoExpandRadius,
      'restrictDuringPeakHours': restrictDuringPeakHours,
      'serviceZones': serviceZones,
      if (currentLocation != null) 'currentLocation': currentLocation!.toJson(),
      if (estimatedDailyRequests != null)
        'estimatedDailyRequests': estimatedDailyRequests,
      if (averagePayoutPerJob != null) 'averagePayoutPerJob': averagePayoutPerJob,
      if (estimatedFuelCost != null) 'estimatedFuelCost': estimatedFuelCost,
      if (averageResponseTime != null) 'averageResponseTime': averageResponseTime,
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  ServiceRadius copyWith({
    double? radius,
    bool? autoExpandRadius,
    bool? restrictDuringPeakHours,
    List<ServiceZone>? serviceZones,
    LocationCoordinates? currentLocation,
    int? estimatedDailyRequests,
    double? averagePayoutPerJob,
    double? estimatedFuelCost,
    int? averageResponseTime,
    DateTime? updatedAt,
  }) {
    return ServiceRadius(
      radius: radius ?? this.radius,
      autoExpandRadius: autoExpandRadius ?? this.autoExpandRadius,
      restrictDuringPeakHours:
          restrictDuringPeakHours ?? this.restrictDuringPeakHours,
      serviceZones: serviceZones ?? this.serviceZones,
      currentLocation: currentLocation ?? this.currentLocation,
      estimatedDailyRequests:
          estimatedDailyRequests ?? this.estimatedDailyRequests,
      averagePayoutPerJob: averagePayoutPerJob ?? this.averagePayoutPerJob,
      estimatedFuelCost: estimatedFuelCost ?? this.estimatedFuelCost,
      averageResponseTime: averageResponseTime ?? this.averageResponseTime,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
