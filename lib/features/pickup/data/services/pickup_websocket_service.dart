import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/constants/app_config.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

@lazySingleton
class PickupWebSocketService {
  final FlutterSecureStorage _secureStorage;
  
  io.Socket? _socket;
  bool _isConnected = false;
  
  // Stream controllers for different events
  final _newRequestController = StreamController<PickupRequest>.broadcast();
  final _statusUpdateController = StreamController<PickupRequest>.broadcast();
  final _cancelledController = StreamController<String>.broadcast();
  final _connectionStatusController = StreamController<bool>.broadcast();

  PickupWebSocketService(this._secureStorage);

  Stream<PickupRequest> get onNewRequest => _newRequestController.stream;
  Stream<PickupRequest> get onStatusUpdate => _statusUpdateController.stream;
  Stream<String> get onCancelled => _cancelledController.stream;
  Stream<bool> get onConnectionStatus => _connectionStatusController.stream;
  
  bool get isConnected => _isConnected;

  Future<void> connect() async {
    if (_isConnected && _socket != null) return;

    final token = await _secureStorage.read(key: AppConfig.authTokenKey);
    if (token == null) {
      print('[PickupWS] No auth token found, cannot connect');
      return;
    }

    final wsUrl = AppConfig.baseUrl.replaceFirst('https://', 'wss://').replaceFirst('http://', 'ws://');
    
    _socket = io.io(
      '$wsUrl/pickup',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(10)
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(30000)
          .build(),
    );

    _setupEventListeners();
    _socket!.connect();
  }

  void _setupEventListeners() {
    _socket!.onConnect((_) {
      print('[PickupWS] Connected to pickup namespace');
      _isConnected = true;
      _connectionStatusController.add(true);
    });

    _socket!.onDisconnect((_) {
      print('[PickupWS] Disconnected from pickup namespace');
      _isConnected = false;
      _connectionStatusController.add(false);
    });

    _socket!.onConnectError((error) {
      print('[PickupWS] Connection error: $error');
      _isConnected = false;
      _connectionStatusController.add(false);
    });

    _socket!.onError((error) {
      print('[PickupWS] Error: $error');
    });

    // Agent Events
    _socket!.on('pickup:new_request', (data) {
      print('[PickupWS] New pickup request received');
      try {
        final pickup = PickupRequest.fromJson(data as Map<String, dynamic>);
        _newRequestController.add(pickup);
      } catch (e) {
        print('[PickupWS] Error parsing new request: $e');
      }
    });

    _socket!.on('pickup:status_update', (data) {
      print('[PickupWS] Pickup status update received');
      try {
        final pickup = PickupRequest.fromJson(data as Map<String, dynamic>);
        _statusUpdateController.add(pickup);
      } catch (e) {
        print('[PickupWS] Error parsing status update: $e');
      }
    });

    _socket!.on('pickup:cancelled', (data) {
      print('[PickupWS] Pickup cancelled');
      try {
        final pickupId = data['pickupId'] as String;
        _cancelledController.add(pickupId);
      } catch (e) {
        print('[PickupWS] Error parsing cancelled event: $e');
      }
    });

    // Acknowledgment events
    _socket!.on('connected', (data) {
      print('[PickupWS] Server acknowledged connection: $data');
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _isConnected = false;
    _connectionStatusController.add(false);
    print('[PickupWS] Disconnected and disposed');
  }

  void dispose() {
    disconnect();
    _newRequestController.close();
    _statusUpdateController.close();
    _cancelledController.close();
    _connectionStatusController.close();
  }
}
