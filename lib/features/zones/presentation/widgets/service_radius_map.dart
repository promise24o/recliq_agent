import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recliq_agent/features/zones/domain/entities/service_radius.dart';
import 'package:recliq_agent/features/zones/presentation/mobx/service_radius_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ServiceRadiusMap extends StatefulWidget {
  final ServiceRadiusStore store;
  final ServiceRadius? serviceRadius;

  const ServiceRadiusMap({
    super.key,
    required this.store,
    this.serviceRadius,
  });

  @override
  State<ServiceRadiusMap> createState() => _ServiceRadiusMapState();
}

class _ServiceRadiusMapState extends State<ServiceRadiusMap> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};
  bool _isMapReady = false;
  String? _selectedZoneId;

  @override
  void initState() {
    super.initState();
    _rebuildMapOverlays();
  }

  @override
  void didUpdateWidget(covariant ServiceRadiusMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.serviceRadius != widget.serviceRadius ||
        oldWidget.store.currentRadius != widget.store.currentRadius ||
        oldWidget.store.selectedZoneIds != widget.store.selectedZoneIds) {
      _rebuildMapOverlays();
    }
  }

  void _rebuildMapOverlays() {
    setState(() {
      _markers.clear();
      _circles.clear();

      final center = _getCurrentCenter();
      final radiusKm = widget.store.currentRadius.clamp(1.0, 100.0);

      // Center marker
      _markers.add(
        Marker(
          markerId: const MarkerId('service_center'),
          position: center,
          infoWindow: InfoWindow(title: _getCenterTitle()),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );

      // Service radius circle
      _circles.add(
        Circle(
          circleId: const CircleId('service_radius'),
          center: center,
          radius: radiusKm * 1000,
          strokeWidth: 2,
          strokeColor: AppTheme.primaryGreen,
          fillColor: AppTheme.primaryGreen.withOpacity(0.15),
        ),
      );

      // Add markers for all selected zones
      _addSelectedZonesMarkers();
    });

    if (_mapController != null && _isMapReady) {
      _animateCameraToCenter();
    }
  }

  LatLng _getCurrentCenter() {
    // Priority 1: User-selected zone preview
    if (_selectedZoneId != null) {
      final zone = widget.serviceRadius?.serviceZones
          .where((z) => z.id == _selectedZoneId)
          .firstOrNull;
      if (zone != null) {
        if (zone.boundary?.center != null) return zone.boundary!.center;
        if (zone.center != null) return zone.center!;
      }
    }

    // Priority 2: Current location from service-radius API
    if (widget.serviceRadius?.currentLocation != null) {
      final loc = widget.serviceRadius!.currentLocation!;
      return LatLng(loc.latitude, loc.longitude);
    }

    // Priority 3: First selected zone (if any)
    if (widget.store.selectedZoneIds.isNotEmpty) {
      final firstId = widget.store.selectedZoneIds.first;
      final zone = widget.serviceRadius?.serviceZones
          .where((z) => z.id == firstId)
          .firstOrNull;
      if (zone != null) {
        if (zone.boundary?.center != null) return zone.boundary!.center;
        if (zone.center != null) return zone.center!;
      }
    }

    // Ultimate fallback (should rarely happen)
    return const LatLng(6.5244, 3.3792);
  }

  String _getCenterTitle() {
    if (_selectedZoneId != null) {
      final zone = widget.serviceRadius?.serviceZones
          .where((z) => z.id == _selectedZoneId)
          .firstOrNull;
      return zone?.name ?? 'Selected Zone';
    }
    return 'Service Center';
  }

  void _addSelectedZonesMarkers() {
    if (widget.serviceRadius?.serviceZones == null) return;

    for (final zone in widget.serviceRadius!.serviceZones) {
      if (!widget.store.selectedZoneIds.contains(zone.id)) continue;

      LatLng? pos;
      if (zone.boundary?.center != null) {
        pos = zone.boundary!.center;
      } else if (zone.center != null) {
        pos = zone.center;
      }

      if (pos != null) {
        _markers.add(
          Marker(
            markerId: MarkerId('zone_${zone.id}'),
            position: pos,
            infoWindow: InfoWindow(title: zone.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          ),
        );
      }
    }
  }

  void _animateCameraToCenter() {
    final center = _getCurrentCenter();
    final zoom = _getAppropriateZoom(widget.store.currentRadius);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(center, zoom),
    );
  }

  double _getAppropriateZoom(double radiusKm) {
    if (radiusKm <= 2) return 14.8;
    if (radiusKm <= 5) return 13.2;
    if (radiusKm <= 10) return 11.8;
    if (radiusKm <= 20) return 10.5;
    return 9.2;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // Force rebuild when these change
        widget.store.currentRadius;
        widget.store.selectedZoneIds;
        widget.store.isLoading;

        final selectedCount = widget.store.selectedZoneIds.length;
        final showDropdown = selectedCount > 1;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Zone preview selector (only when >1 zone selected)
            if (showDropdown)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: DropdownButtonFormField<String?>(
                  value: _selectedZoneId,
                  decoration: InputDecoration(
                    labelText: 'Preview Zone',
                    labelStyle: TextStyle(color: AppTheme.textSecondary),
                    prefixIcon: Icon(Icons.filter_center_focus, color: AppTheme.primaryGreen),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppTheme.borderSoft),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Service Center (default)'),
                    ),
                    ...widget.store.selectedZoneIds.map((id) {
                      final zone = widget.serviceRadius?.serviceZones
                          .where((z) => z.id == id)
                          .firstOrNull;
                      return DropdownMenuItem<String?>(
                        value: id,
                        child: Text(zone?.name ?? 'Zone $id'),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedZoneId = value);
                    _rebuildMapOverlays();
                  },
                ),
              ),

            // Map
            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderSoft),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    setState(() => _isMapReady = true);
                    _rebuildMapOverlays();
                  },
                  initialCameraPosition: CameraPosition(
                    target: _getCurrentCenter(),
                    zoom: _getAppropriateZoom(widget.store.currentRadius),
                  ),
                  markers: _markers,
                  circles: _circles,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  compassEnabled: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}