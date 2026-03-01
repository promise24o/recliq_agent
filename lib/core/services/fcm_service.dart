import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'fcm_remote_data_source.dart';
import '../widgets/fcm_permission_bottom_sheet.dart';

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('[FCM] Background message: ${message.messageId}');
  print('[FCM] Title: ${message.notification?.title}');
  print('[FCM] Body: ${message.notification?.body}');
}

class FcmService {
  final FirebaseMessaging _firebaseMessaging;
  final FcmRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;
  final FlutterLocalNotificationsPlugin _localNotifications;

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

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('[FCM] Foreground message: ${message.messageId}');
      print('[FCM] Title: ${message.notification?.title}');
      print('[FCM] Body: ${message.notification?.body}');
      print('[FCM] Data: ${message.data}');
      
      // Show local notification for foreground messages
      _showLocalNotification(message);
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
      'default',
      'Default Notifications',
      description: 'Default notification channel for R-Agent',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Show local notification for foreground messages
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'default',
      'Default Notifications',
      channelDescription: 'Default notification channel for R-Agent',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF1F6B43),
      ledColor: Color(0xFF1F6B43),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'R-Agent',
      message.notification?.body ?? 'You have a new notification',
      platformChannelSpecifics,
      payload: message.data.toString(),
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
        case 'pickup_request':
          print('[FCM] Navigate to pickup request: ${data['pickupId']}');
          // TODO: Navigate to pickup request details
          break;
        case 'pickup_assigned':
          print('[FCM] Navigate to assigned pickup: ${data['pickupId']}');
          // TODO: Navigate to assigned pickup
          break;
        case 'payment_received':
          print('[FCM] Navigate to wallet');
          // TODO: Navigate to wallet page
          break;
        case 'kyc_approved':
          print('[FCM] KYC approved notification');
          // TODO: Navigate to dashboard or show success
          break;
        case 'kyc_rejected':
          print('[FCM] KYC rejected notification');
          // TODO: Navigate to KYC page
          break;
        default:
          print('[FCM] Unknown notification type: ${data['type']}');
      }
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
