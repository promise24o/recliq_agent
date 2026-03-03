import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/services/sound_service.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/pickup_request_bottom_sheet.dart';
import 'fcm_remote_data_source.dart';
import '../widgets/fcm_permission_bottom_sheet.dart';
import '../router/app_router.dart';

/// Parse waste type from string to enum
WasteType _parseWasteType(String? wasteType) {
  switch (wasteType?.toLowerCase()) {
    case 'plastic':
      return WasteType.plastic;
    case 'paper':
      return WasteType.paper;
    case 'metal':
      return WasteType.metal;
    case 'glass':
      return WasteType.glass;
    case 'organic':
      return WasteType.organic;
    case 'e_waste':
    case 'e-waste':
      return WasteType.eWaste;
    case 'mixed':
      return WasteType.mixed;
    default:
      return WasteType.mixed;
  }
}

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('[FCM] Background message: ${message.messageId}');
  print('[FCM] Title: ${message.notification?.title}');
  print('[FCM] Body: ${message.notification?.body}');
  print('[FCM] Data: ${message.data}');
  
  // Play sound for pickup notifications in background
  final notificationType = message.data['type'] ?? '';
  if (notificationType == 'new_pickup_request' || 
      notificationType == 'agent_assigned') {
    // Initialize GetIt for background
    await configureDependencies();
    
    try {
      final soundService = getIt<SoundService>();
      await soundService.playAlertSound(repeatCount: 6);
      print('[FCM] Background sound played for pickup notification');
    } catch (e) {
      print('[FCM] Error playing background sound: $e');
    }
  }
}

@lazySingleton
class FcmService {
  final FirebaseMessaging _firebaseMessaging;
  final FcmRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;
  final FlutterLocalNotificationsPlugin _localNotifications;
  
  // Navigation callbacks - settable after construction
  void Function(String)? onNavigateToPickup;
  void Function()? onNavigateToPendingPickups;
  void Function()? onNavigateToWallet;
  void Function()? onNavigateToEarnings;
  void Function()? onNavigateToProfile;
  void Function()? onNavigateToDashboard;
  void Function()? onNavigateToKyc;
  
  // Queue for pending notifications when context isn't available
  static final List<RemoteMessage> _pendingNotifications = [];

  FcmService(
    this._firebaseMessaging,
    this._remoteDataSource,
    this._prefs,
  ) : _localNotifications = FlutterLocalNotificationsPlugin();

  /// Initialize FCM and set up listeners
  Future<void> initialize() async {
    print('[FCM] Initializing FCM service...');

    // Initialize local notifications
    await _initializeLocalNotifications();
    
    // Listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(_AppLifecycleObserver(this));

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('[FCM] Foreground message: ${message.messageId}');
      print('[FCM] Title: ${message.notification?.title}');
      print('[FCM] Body: ${message.notification?.body}');
      print('[FCM] Data: ${message.data}');
      
      // Play alert sound for pickup notifications
      final notificationType = message.data['type'] ?? '';
      print('[FCM] Notification type: $notificationType');
      if (notificationType == 'new_pickup_request' || 
          notificationType == 'agent_assigned') {
        print('[FCM] Processing pickup notification...');
        try {
          print('[FCM] Getting sound service...');
          final soundService = getIt<SoundService>();
          print('[FCM] Playing sound...');
          soundService.playAlertSound(repeatCount: 6);
          print('[FCM] Sound service called');
          
          // Show pickup request bottom sheet
          final context = rootNavigatorKey.currentContext;
          print('[FCM] Current context available: ${context != null}');
          print('[FCM] Navigator key state: ${rootNavigatorKey.currentState}');
          if (context != null) {
            print('[FCM] Creating pickup request...');
            final pickupRequest = PickupRequest(
              id: message.data['pickupId'] ?? '',
              userId: '', // Not provided in FCM data
              userName: message.data['userName'],
              userPhone: null, // Not provided in FCM data
              address: message.data['address'],
              pickupMode: PickupMode.pickup,
              wasteType: _parseWasteType(message.data['wasteType']),
              estimatedWeight: double.tryParse(message.data['estimatedWeight']?.toString() ?? '0') ?? 0,
              status: PickupStatus.newRequest,
              coordinates: null, // Not provided in FCM data
              pricing: message.data['totalAmount'] != null
                ? PickupPricing(
                    totalAmount: double.tryParse(message.data['totalAmount']?.toString() ?? '0') ?? 0,
                  )
                : null,
              createdAt: DateTime.now().toIso8601String(),
              updatedAt: DateTime.now().toIso8601String(),
            );
            print('[FCM] Pickup request created: ${pickupRequest.userName}, ${pickupRequest.address}');
            
            // Add delay to ensure context is ready and app is fully resumed
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted && rootNavigatorKey.currentState != null) {
                showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => PickupRequestBottomSheet(
                request: pickupRequest,
                onAccept: () {
                  Navigator.of(context).pop();
                  onNavigateToPickup?.call(pickupRequest.id);
                },
                onDecline: () {
                  Navigator.of(context).pop();
                },
                onClose: () {
                  Navigator.of(context).pop();
                },
              ),
                );
                print('[FCM] Bottom sheet shown successfully');
              } else {
                print('[FCM] Context not mounted - cannot show bottom sheet');
              }
            });
          } else {
            print('[FCM] No context available - queuing notification');
            _pendingNotifications.add(message);
            showPendingNotificationWhenReady();
          }
        } catch (e) {
          print('[FCM] Error handling pickup notification: $e');
        }
      }
    });

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('[FCM] Notification tapped: ${message.messageId}');
      print('[FCM] Data: ${message.data}');
      
      // Handle navigation based on notification data
      _handleNotificationTap(message);
    });

    // Check if app was opened from a notification
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('[FCM] App opened from notification: ${initialMessage.messageId}');
      _handleNotificationTap(initialMessage);
    }

    print('[FCM] FCM service initialized');
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'pickup_requests',
      'Pickup Requests',
      description: 'Notifications for new pickup requests',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  
  /// Show pending notifications when context becomes available
  void showPendingNotificationWhenReady() {
    // Check periodically if context is available
    Future.delayed(const Duration(seconds: 1), () {
      final context = rootNavigatorKey.currentContext;
      if (context != null && _pendingNotifications.isNotEmpty) {
        print('[FCM] Context available, showing ${_pendingNotifications.length} pending notifications');
        final message = _pendingNotifications.removeAt(0);
        _showPickupBottomSheet(message, context);
      } else if (_pendingNotifications.isNotEmpty) {
        // Try again
        showPendingNotificationWhenReady();
      }
    });
  }
  
  /// Show pickup bottom sheet
  void _showPickupBottomSheet(RemoteMessage message, BuildContext context) {
    final pickupRequest = PickupRequest(
      id: message.data['pickupId'] ?? '',
      userId: '', // Not provided in FCM data
      userName: message.data['userName'],
      userPhone: null, // Not provided in FCM data
      address: message.data['address'],
      pickupMode: PickupMode.pickup,
      wasteType: _parseWasteType(message.data['wasteType']),
      estimatedWeight: double.tryParse(message.data['estimatedWeight']?.toString() ?? '0') ?? 0,
      status: PickupStatus.newRequest,
      coordinates: null, // Not provided in FCM data
      pricing: message.data['totalAmount'] != null
        ? PickupPricing(
            totalAmount: double.tryParse(message.data['totalAmount']?.toString() ?? '0') ?? 0,
          )
        : null,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PickupRequestBottomSheet(
        request: pickupRequest,
        onAccept: () {
          Navigator.of(context).pop();
          onNavigateToPickup?.call(pickupRequest.id);
        },
        onDecline: () {
          Navigator.of(context).pop();
        },
        onClose: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
  
  /// Handle notification tap from local notifications
  void _onNotificationTapped(NotificationResponse notificationResponse) {
    print('[FCM] Local notification tapped: ${notificationResponse.payload}');
    
    if (notificationResponse.payload != null) {
      try {
        final data = Map<String, dynamic>.from(
          {'data': notificationResponse.payload}
        );
        _handleNotificationTap(RemoteMessage(data: data));
      } catch (e) {
        print('[FCM] Error parsing notification payload: $e');
      }
    }
  }

  /// Request notification permissions and show custom bottom sheet
  Future<bool> requestPermission(BuildContext context) async {
    // First, check if system permission is already granted
    final currentSettings = await _firebaseMessaging.getNotificationSettings();
    final isAlreadyGranted = currentSettings.authorizationStatus == AuthorizationStatus.authorized ||
        currentSettings.authorizationStatus == AuthorizationStatus.provisional;
    
    print('[FCM] Current permission status: ${currentSettings.authorizationStatus}');
    
    // If permission is already granted, just register token and return
    if (isAlreadyGranted) {
      print('[FCM] Permission already granted, registering token...');
      await registerToken();
      return true;
    }
    
    // Permission not granted - always show bottom sheet to encourage user to enable
    final shouldRequest = await _showPermissionBottomSheet(context);
    
    if (!shouldRequest) {
      print('[FCM] User declined to enable notifications');
      return false;
    }

    // Request permission from system
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final granted = settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    print('[FCM] Permission status after request: ${settings.authorizationStatus}');
    
    if (granted) {
      // Get and register FCM token
      await registerToken();
    }

    return granted;
  }

  /// Show custom permission bottom sheet
  Future<bool> _showPermissionBottomSheet(BuildContext context) async {
    return await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return const FcmPermissionBottomSheet();
      },
    ) ?? false;
  }

  /// Get FCM token and register with backend
  Future<void> registerToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      
      if (token != null) {
        print('[FCM] Token obtained: ${token.substring(0, 20)}...');
        
        final deviceType = Platform.isAndroid ? 'android' : 'ios';
        
        final success = await _remoteDataSource.registerFcmToken(
          fcmToken: token,
          deviceType: deviceType,
        );

        if (success) {
          print('[FCM] Token registered successfully with backend');
          await _prefs.setString('fcm_token', token);
          await _prefs.setString('fcm_device_type', deviceType);
        } else {
          print('[FCM] Failed to register token with backend');
        }
      } else {
        print('[FCM] Failed to get FCM token');
      }
    } catch (e) {
      print('[FCM] Error registering token: $e');
    }
  }

  /// Unregister FCM token from backend
  Future<void> unregisterToken() async {
    try {
      final deviceType = Platform.isAndroid ? 'android' : 'ios';
      
      final success = await _remoteDataSource.unregisterFcmToken(
        deviceType: deviceType,
      );

      if (success) {
        print('[FCM] Token unregistered successfully');
        await _prefs.remove('fcm_token');
        await _prefs.remove('fcm_device_type');
      } else {
        print('[FCM] Failed to unregister token');
      }
    } catch (e) {
      print('[FCM] Error unregistering token: $e');
    }
  }

  /// Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    final data = message.data;
    
    // Handle different notification types for agent app
    if (data.containsKey('type')) {
      switch (data['type']) {
        case 'new_pickup_request':
          print('[FCM] Navigate to new pickup request: ${data['pickupId']}');
          _navigateToPickup(data['pickupId']);
          break;
        case 'agent_assigned':
          print('[FCM] Navigate to assigned pickup: ${data['pickupId']}');
          _navigateToPickup(data['pickupId']);
          break;
        case 'pickup_cancelled':
          print('[FCM] Pickup cancelled: ${data['pickupId']}');
          _navigateToPendingPickups();
          break;
        case 'payment_received':
          print('[FCM] Navigate to wallet');
          _navigateToWallet();
          break;
        case 'kyc_approved':
          print('[FCM] KYC approved notification');
          _navigateToDashboard();
          break;
        case 'kyc_rejected':
          print('[FCM] KYC rejected notification');
          _navigateToKyc();
          break;
        default:
          print('[FCM] Unknown notification type: ${data['type']}');
      }
    }
  }

  void _navigateToPickup(String? pickupId) {
    if (pickupId != null && onNavigateToPickup != null) {
      onNavigateToPickup!(pickupId);
    }
  }

  void _navigateToPendingPickups() {
    onNavigateToPendingPickups?.call();
  }

  void _navigateToWallet() {
    onNavigateToWallet?.call();
  }

  void _navigateToDashboard() {
    onNavigateToDashboard?.call();
  }

  void _navigateToKyc() {
    onNavigateToKyc?.call();
  }

  /// Check and show any pending notifications (can be called manually)
  void checkPendingNotifications() {
    if (_pendingNotifications.isNotEmpty) {
      print('[FCM] Manually checking for ${_pendingNotifications.length} pending notifications');
      showPendingNotificationWhenReady();
    }
  }
  
  /// Listen for token refresh
  void listenForTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      print('[FCM] Token refreshed: ${newToken.substring(0, 20)}...');
      
      final deviceType = Platform.isAndroid ? 'android' : 'ios';
      
      await _remoteDataSource.registerFcmToken(
        fcmToken: newToken,
        deviceType: deviceType,
      );
      
      await _prefs.setString('fcm_token', newToken);
    });
  }
}

/// App lifecycle observer to handle notification display when app resumes
class _AppLifecycleObserver extends WidgetsBindingObserver {
  final FcmService _fcmService;
  
  _AppLifecycleObserver(this._fcmService);
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (state == AppLifecycleState.resumed) {
      print('[FCM] App resumed, checking for pending notifications');
      // Check for pending notifications when app is resumed
      Future.delayed(const Duration(milliseconds: 500), () {
        _fcmService.showPendingNotificationWhenReady();
      });
    }
  }
}
