import 'package:flutter/material.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/services/fcm_service.dart';

class FcmPermissionHelper {
  static Future<bool> requestNotificationPermission(BuildContext context) async {
    try {
      final fcmService = getIt<FcmService>();
      return await fcmService.requestPermission(context);
    } catch (e) {
      print('[FCM] Error requesting permission: $e');
      return false;
    }
  }
}
