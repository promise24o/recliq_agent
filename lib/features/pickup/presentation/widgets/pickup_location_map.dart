import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class PickupLocationMap extends StatefulWidget {
  final PickupRequest pickup;

  const PickupLocationMap({
    super.key,
    required this.pickup,
  });

  @override
  State<PickupLocationMap> createState() => _PickupLocationMapState();
}

class _PickupLocationMapState extends State<PickupLocationMap> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _setupMapMarkers();
  }

  void _setupMapMarkers() {
    if (widget.pickup.coordinates == null) return;

    final pickupLocation = LatLng(
      widget.pickup.coordinates!.lat,
      widget.pickup.coordinates!.lng,
    );

    setState(() {
      _markers.clear();
      
      // Pickup location marker
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup_location'),
          position: pickupLocation,
          infoWindow: InfoWindow(
            title: 'Pickup Location',
            snippet: widget.pickup.address ?? 'No address provided',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    });

    // Animate camera to pickup location after map is ready
    if (_isMapReady) {
      _animateToPickupLocation();
    }
  }

  void _animateToPickupLocation() {
    if (widget.pickup.coordinates == null) return;
    
    final pickupLocation = LatLng(
      widget.pickup.coordinates!.lat,
      widget.pickup.coordinates!.lng,
    );
    
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(pickupLocation, 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pickup.coordinates == null) {
      return Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderSoft),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off,
                size: 48,
                color: AppTheme.textSecondary,
              ),
              SizedBox(height: 8),
              Text(
                'Location not available',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
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
            _animateToPickupLocation();
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.pickup.coordinates!.lat,
              widget.pickup.coordinates!.lng,
            ),
            zoom: 16.0,
          ),
          markers: _markers,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          compassEnabled: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
