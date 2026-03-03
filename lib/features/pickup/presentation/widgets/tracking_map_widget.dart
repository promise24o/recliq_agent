import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/presentation/mobx/pickup_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class TrackingMapWidget extends StatefulWidget {
  final String pickupId;
  final PickupCoordinates? pickupCoordinates;

  const TrackingMapWidget({
    super.key,
    required this.pickupId,
    this.pickupCoordinates,
  });

  @override
  State<TrackingMapWidget> createState() => _TrackingMapWidgetState();
}

class _TrackingMapWidgetState extends State<TrackingMapWidget> {
  final _store = getIt<PickupStore>();
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  bool _isMapReady = false;
  Timer? _trackingTimer;

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  void _startTracking() {
    // Load initial tracking data
    _store.loadTrackingLocation(widget.pickupId);
    
    // Set up periodic updates every 10 seconds
    _trackingTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _store.loadTrackingLocation(widget.pickupId);
    });
  }

  void _updateMapOverlays() {
    if (!_isMapReady) return;

    setState(() {
      _markers.clear();
      _polylines.clear();

      // Add pickup location marker
      if (widget.pickupCoordinates != null) {
        final pickupLocation = LatLng(
          widget.pickupCoordinates!.lat,
          widget.pickupCoordinates!.lng,
        );
        
        _markers.add(
          Marker(
            markerId: const MarkerId('pickup_location'),
            position: pickupLocation,
            infoWindow: const InfoWindow(title: 'Pickup Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      }

      // Add agent tracking location marker
      if (_store.trackingLocation?.location != null) {
        final agentLocation = LatLng(
          _store.trackingLocation!.location!.lat,
          _store.trackingLocation!.location!.lng,
        );
        
        _markers.add(
          Marker(
            markerId: const MarkerId('agent_location'),
            position: agentLocation,
            infoWindow: const InfoWindow(title: 'Agent Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );

        // Draw route line if both locations are available
        if (widget.pickupCoordinates != null) {
          final pickupLocation = LatLng(
            widget.pickupCoordinates!.lat,
            widget.pickupCoordinates!.lng,
          );
          
          _polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: [agentLocation, pickupLocation],
              color: AppTheme.primaryGreen,
              width: 3,
              patterns: [PatternItem.dash(10), PatternItem.gap(5)],
            ),
          );
        }

        // Center map on agent location
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(agentLocation, 15.0),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        // Update map when tracking data changes
        _updateMapOverlays();

        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: AppTheme.darkBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Stack(
            children: [
              // Google Map
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    setState(() => _isMapReady = true);
                    _updateMapOverlays();
                  },
                  initialCameraPosition: CameraPosition(
                    target: widget.pickupCoordinates != null
                        ? LatLng(
                            widget.pickupCoordinates!.lat,
                            widget.pickupCoordinates!.lng,
                          )
                        : const LatLng(6.5244, 3.3792), // Default to Lagos
                    zoom: 15.0,
                  ),
                  markers: _markers,
                  polylines: _polylines,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  compassEnabled: true,
                ),
              ),

              // Loading overlay
              if (_store.isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Updating location...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Status message
              if (_store.trackingLocation?.message != null)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.borderSoft),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _store.trackingLocation!.message!,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Live tracking indicator
              if (_store.trackingLocation?.lastUpdated != null)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Live',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Last updated time
              if (_store.trackingLocation?.lastUpdated != null)
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _formatLastUpdated(_store.trackingLocation!.lastUpdated!),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _formatLastUpdated(String lastUpdated) {
    try {
      final dateTime = DateTime.parse(lastUpdated);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else {
        return '${difference.inDays}d ago';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  void dispose() {
    _trackingTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }
}
