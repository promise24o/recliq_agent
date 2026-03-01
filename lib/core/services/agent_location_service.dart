import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recliq_agent/core/constants/app_config.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/core/services/location_manager.dart';
import 'package:recliq_agent/core/services/websocket_manager.dart';

/// Orchestrates location tracking + WebSocket + HTTP fallback.
/// This is the single entry point for the agent's live location flow.
class AgentLocationService {
  final LocationManager _locationManager;
  final WebSocketManager _webSocketManager;
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage;

  StreamSubscription<LocationData>? _locationSub;
  StreamSubscription<WebSocketState>? _wsSub;
  Timer? _httpFallbackTimer;
  bool _isOnline = false;
  int _consecutiveWsFailures = 0;
  static const int _wsFailureThresholdForFallback = 3;

  AgentLocationService({
    required LocationManager locationManager,
    required WebSocketManager webSocketManager,
    required DioClient dioClient,
    required FlutterSecureStorage secureStorage,
  })  : _locationManager = locationManager,
        _webSocketManager = webSocketManager,
        _dioClient = dioClient,
        _secureStorage = secureStorage;

  bool get isOnline => _isOnline;
  bool get isTracking => _locationManager.isTracking;
  bool get isWsConnected => _webSocketManager.isConnected;
  LocationData? get lastLocation => _locationManager.lastLocation;

  /// Called when agent goes ONLINE.
  /// 1. Request location permission
  /// 2. Connect WebSocket
  /// 3. Start GPS polling
  /// 4. Listen for location updates → send via WS or HTTP
  Future<bool> goOnline() async {
    if (_isOnline) return true;

    // 1. Check location permission
    final hasPermission = await _locationManager.requestPermission();
    if (!hasPermission) {
      print('[AgentLocation] Cannot go online - no location permission');
      return false;
    }

    // 2. Get auth token for WebSocket
    final token = await _secureStorage.read(key: AppConfig.authTokenKey);
    if (token == null) {
      print('[AgentLocation] Cannot go online - no auth token');
      return false;
    }

    _isOnline = true;
    print('[AgentLocation] Going online...');

    // 3. Connect WebSocket
    _webSocketManager.connect(token);

    // 4. Listen for WebSocket state changes
    _wsSub = _webSocketManager.stateStream.listen(_onWsStateChange);

    // 5. Start location tracking
    await _locationManager.startTracking();

    // 6. Listen for location updates
    _locationSub = _locationManager.locationStream.listen(_onLocationUpdate);

    // 7. Send agent online via WS
    _webSocketManager.sendAgentOnline();

    print('[AgentLocation] Online - tracking started');
    return true;
  }

  /// Called when agent goes OFFLINE.
  /// 1. Stop GPS polling
  /// 2. Send offline event
  /// 3. Disconnect WebSocket
  void goOffline() {
    if (!_isOnline) return;

    _isOnline = false;
    print('[AgentLocation] Going offline...');

    // Stop location tracking
    _locationSub?.cancel();
    _locationSub = null;
    _locationManager.stopTracking();

    // Stop HTTP fallback
    _httpFallbackTimer?.cancel();
    _httpFallbackTimer = null;

    // Send offline event and disconnect WS
    _webSocketManager.sendAgentOffline();
    _wsSub?.cancel();
    _wsSub = null;
    _webSocketManager.disconnect();

    _consecutiveWsFailures = 0;
    print('[AgentLocation] Offline - tracking stopped');
  }

  /// Update the location polling frequency
  void setFrequency(LocationUpdateFrequency frequency) {
    _locationManager.setFrequency(frequency);
  }

  void _onLocationUpdate(LocationData location) {
    if (!_isOnline) return;

    if (_webSocketManager.isConnected) {
      // Primary: send via WebSocket
      _webSocketManager.sendLocationUpdate(location.toJson());
      _consecutiveWsFailures = 0;
    } else {
      _consecutiveWsFailures++;
      // After repeated WS failures, use HTTP fallback directly
      if (_consecutiveWsFailures >= _wsFailureThresholdForFallback) {
        _sendLocationViaHttp(location);
      }
    }
  }

  void _onWsStateChange(WebSocketState state) {
    switch (state) {
      case WebSocketState.connected:
        print('[AgentLocation] WebSocket connected - using WS for updates');
        _httpFallbackTimer?.cancel();
        _httpFallbackTimer = null;
        _consecutiveWsFailures = 0;
        break;

      case WebSocketState.disconnected:
        if (_isOnline) {
          print('[AgentLocation] WebSocket disconnected - switching to HTTP fallback');
          _startHttpFallback();
        }
        break;

      case WebSocketState.connecting:
        break;
    }
  }

  /// Start HTTP fallback when WebSocket is down
  void _startHttpFallback() {
    if (_httpFallbackTimer != null) return;

    print('[AgentLocation] Starting HTTP fallback (every 30s)');
    _httpFallbackTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        final location = _locationManager.lastLocation;
        if (location != null && _isOnline) {
          _sendLocationViaHttp(location);
        }
      },
    );
  }

  /// Send location update via HTTP POST
  Future<void> _sendLocationViaHttp(LocationData location) async {
    try {
      await _dioClient.post(
        AppConfig.locationUpdateEndpoint,
        data: location.toJson(),
      );
    } catch (e) {
      print('[AgentLocation] HTTP fallback error: $e');
    }
  }

  void dispose() {
    goOffline();
    _locationManager.dispose();
    _webSocketManager.dispose();
  }
}
