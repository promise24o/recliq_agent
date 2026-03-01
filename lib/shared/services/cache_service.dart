import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';

class CacheService {
  static const String _banksCacheKey = 'cached_banks';
  static const String _banksCacheTimestampKey = 'cached_banks_timestamp';
  static const Duration _cacheExpiry = Duration(hours: 24); // Cache for 24 hours

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static bool _isStorageAvailable = true;

  static Future<bool> get _isAvailable async {
    if (!_isStorageAvailable) return false;
    
    try {
      // Test if secure storage is available
      await _secureStorage.read(key: 'test_key');
      return true;
    } catch (e) {
      _isStorageAvailable = false;
      print('Secure storage not available: $e');
      return false;
    }
  }

  // Cache bank list
  static Future<void> cacheBanks(List<Bank> banks) async {
    try {
      if (!await _isAvailable) return; // Storage not available, skip caching
      
      final banksJson = banks.map((bank) => bank.toJson()).toList();
      await _secureStorage.write(
        key: _banksCacheKey,
        value: jsonEncode(banksJson),
      );
      await _secureStorage.write(
        key: _banksCacheTimestampKey,
        value: DateTime.now().toIso8601String(),
      );
    } catch (e) {
      // Silently fail caching - app will still work without cache
      print('Failed to cache banks: $e');
    }
  }

  // Get cached bank list
  static Future<List<Bank>?> getCachedBanks() async {
    try {
      if (!await _isAvailable) return null; // Storage not available
      
      final banksJsonString = await _secureStorage.read(key: _banksCacheKey);
      final timestampString = await _secureStorage.read(key: _banksCacheTimestampKey);

      if (banksJsonString == null || timestampString == null) {
        return null;
      }

      // Check if cache is expired
      final timestamp = DateTime.parse(timestampString);
      if (DateTime.now().difference(timestamp) > _cacheExpiry) {
        // Cache expired, clear it
        await clearBanksCache();
        return null;
      }

      final banksJson = jsonDecode(banksJsonString) as List;
      return banksJson.map((bankJson) => Bank.fromJson(bankJson as Map<String, dynamic>)).toList();
    } catch (e) {
      // Silently fail cache retrieval - app will fetch from API
      print('Failed to get cached banks: $e');
      return null;
    }
  }

  // Clear banks cache
  static Future<void> clearBanksCache() async {
    try {
      if (!await _isAvailable) return; // Storage not available
      
      await _secureStorage.delete(key: _banksCacheKey);
      await _secureStorage.delete(key: _banksCacheTimestampKey);
    } catch (e) {
      print('Failed to clear banks cache: $e');
    }
  }

  // Check if banks cache exists and is valid
  static Future<bool> hasValidBanksCache() async {
    try {
      if (!await _isAvailable) return false; // Storage not available
      
      final timestampString = await _secureStorage.read(key: _banksCacheTimestampKey);
      
      if (timestampString == null) {
        return false;
      }

      final timestamp = DateTime.parse(timestampString);
      return DateTime.now().difference(timestamp) <= _cacheExpiry;
    } catch (e) {
      return false;
    }
  }
}
