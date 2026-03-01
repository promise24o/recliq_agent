import 'dart:async';
import 'dart:collection';
import 'package:recliq_agent/core/constants/app_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum WebSocketState {
  disconnected,
  connecting,
  connected,
}

class WebSocketManager {
  io.Socket? _socket;
  WebSocketState _state = WebSocketState.disconnected;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  String? _authToken;

  final Queue<Map<String, dynamic>> _messageQueue = Queue();
  static const int _maxQueueSize = 50;

  final StreamController<WebSocketState> _stateController =
      StreamController<WebSocketState>.broadcast();
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<WebSocketState> get stateStream => _stateController.stream;
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
  WebSocketState get state => _state;
  bool get isConnected => _state == WebSocketState.connected;

  void _setState(WebSocketState newState) {
    _state = newState;
    _stateController.add(newState);
    print('[WebSocket] State: ${newState.name}');
  }

  /// Connect to the WebSocket server
  void connect(String token) {
    if (_state == WebSocketState.connected || _state == WebSocketState.connecting) {
      return;
    }

    _authToken = token;
    _setState(WebSocketState.connecting);
    _reconnectAttempts = 0;

    final wsUrl = AppConfig.baseUrl;

    _socket = io.io(
      '$wsUrl${AppConfig.wsLocationNamespace}',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(_maxReconnectAttempts)
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(30000)
          .build(),
    );

    _socket!.onConnect((_) {
      print('[WebSocket] Connected');
      _setState(WebSocketState.connected);
      _reconnectAttempts = 0;
      _flushQueue();
    });

    _socket!.onDisconnect((_) {
      print('[WebSocket] Disconnected');
      _setState(WebSocketState.disconnected);
    });

    _socket!.onConnectError((error) {
      print('[WebSocket] Connection error: $error');
      _setState(WebSocketState.disconnected);
      _scheduleReconnect();
    });

    _socket!.onError((error) {
      print('[WebSocket] Error: $error');
    });

    // Listen for server responses
    _socket!.on('connected', (data) {
      print('[WebSocket] Server confirmed: $data');
      _messageController.add({'event': 'connected', 'data': data});
    });

    _socket!.on('location:ack', (data) {
      _messageController.add({'event': 'location:ack', 'data': data});
    });

    _socket!.on('location:error', (data) {
      print('[WebSocket] Location error: $data');
      _messageController.add({'event': 'location:error', 'data': data});
    });

    _socket!.on('status:updated', (data) {
      print('[WebSocket] Status updated: $data');
      _messageController.add({'event': 'status:updated', 'data': data});
    });

    _socket!.on('error', (data) {
      print('[WebSocket] Server error: $data');
      _messageController.add({'event': 'error', 'data': data});
    });
  }

  /// Disconnect from the WebSocket server
  void disconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempts = 0;

    if (_socket != null) {
      _socket!.emit('agent:offline');
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }

    _setState(WebSocketState.disconnected);
    print('[WebSocket] Disconnected and cleaned up');
  }

  /// Send a location update via WebSocket
  void sendLocationUpdate(Map<String, dynamic> locationData) {
    if (_state == WebSocketState.connected && _socket != null) {
      _socket!.emit('location:update', locationData);
    } else {
      // Queue the message for when we reconnect
      _enqueueMessage({'event': 'location:update', 'data': locationData});
    }
  }

  /// Send agent online event
  void sendAgentOnline() {
    if (_state == WebSocketState.connected && _socket != null) {
      _socket!.emit('agent:online');
    }
  }

  /// Send agent offline event
  void sendAgentOffline() {
    if (_state == WebSocketState.connected && _socket != null) {
      _socket!.emit('agent:offline');
    }
  }

  void _enqueueMessage(Map<String, dynamic> message) {
    if (_messageQueue.length >= _maxQueueSize) {
      _messageQueue.removeFirst(); // Drop oldest
    }
    _messageQueue.add(message);
    print('[WebSocket] Queued message (${_messageQueue.length} pending)');
  }

  void _flushQueue() {
    if (_messageQueue.isEmpty) return;

    print('[WebSocket] Flushing ${_messageQueue.length} queued messages');
    while (_messageQueue.isNotEmpty) {
      final msg = _messageQueue.removeFirst();
      final event = msg['event'] as String;
      final data = msg['data'];
      _socket?.emit(event, data);
    }
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      print('[WebSocket] Max reconnection attempts reached');
      return;
    }

    _reconnectTimer?.cancel();

    // Exponential backoff: 1s, 2s, 4s, 8s, 16s, max 30s
    final delay = Duration(
      milliseconds: (1000 * (1 << _reconnectAttempts)).clamp(1000, 30000),
    );

    print('[WebSocket] Reconnecting in ${delay.inSeconds}s (attempt ${_reconnectAttempts + 1}/$_maxReconnectAttempts)');

    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      if (_authToken != null) {
        _socket?.connect();
      }
    });
  }

  void dispose() {
    disconnect();
    _stateController.close();
    _messageController.close();
  }
}
