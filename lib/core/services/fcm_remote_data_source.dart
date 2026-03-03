import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/constants/app_config.dart';
import 'package:recliq_agent/core/network/dio_client.dart';

@lazySingleton
class FcmRemoteDataSource {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage;

  FcmRemoteDataSource(this._dioClient, this._secureStorage);

  Future<bool> registerFcmToken({
    required String fcmToken,
    required String deviceType,
  }) async {
    try {
      final token = await _secureStorage.read(key: AppConfig.authTokenKey);
      
      if (token == null) {
        print('[FCM] No access token found, skipping registration');
        return false;
      }

      final response = await _dioClient.dio.post(
        '/auth/fcm/register',
        data: {
          'deviceType': deviceType,
          'fcmToken': fcmToken,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final success = response.statusCode == 200 || response.statusCode == 201;
      
      if (success) {
        print('[FCM] Token registered successfully');
      } else {
        print('[FCM] Failed to register token: ${response.statusCode}');
      }
      
      return success;
    } on DioException catch (e) {
      print('[FCM] DioException registering token: ${e.message}');
      return false;
    } catch (e) {
      print('[FCM] Error registering token: $e');
      return false;
    }
  }

  Future<bool> unregisterFcmToken({required String deviceType}) async {
    try {
      final token = await _secureStorage.read(key: AppConfig.authTokenKey);
      
      if (token == null) {
        print('[FCM] No access token found, skipping unregistration');
        return false;
      }

      final response = await _dioClient.dio.post(
        '/auth/fcm/unregister',
        data: {'deviceType': deviceType},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final success = response.statusCode == 200 || response.statusCode == 201;
      
      if (success) {
        print('[FCM] Token unregistered successfully');
      } else {
        print('[FCM] Failed to unregister token: ${response.statusCode}');
      }
      
      return success;
    } on DioException catch (e) {
      print('[FCM] DioException unregistering token: ${e.message}');
      return false;
    } catch (e) {
      print('[FCM] Error unregistering token: $e');
      return false;
    }
  }

  Future<Map<String, String>?> getFcmTokens() async {
    try {
      final token = await _secureStorage.read(key: AppConfig.authTokenKey);
      
      if (token == null) {
        print('[FCM] No access token found');
        return null;
      }

      final response = await _dioClient.dio.get(
        '/auth/fcm/tokens',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final tokens = response.data['tokens'] as Map<String, dynamic>;
        return tokens.map((key, value) => MapEntry(key, value.toString()));
      }
      return null;
    } on DioException catch (e) {
      print('[FCM] DioException getting tokens: ${e.message}');
      return null;
    } catch (e) {
      print('[FCM] Error getting tokens: $e');
      return null;
    }
  }
}
