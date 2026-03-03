import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // Cache the sound asset to avoid repeated loading
  AssetSource? _alertSound;
  
  SoundService() {
    _preloadSound();
  }
  
  /// Preload the alert sound for faster playback
  void _preloadSound() {
    if (!kReleaseMode) {
      print('[SoundService] Preloading alert sound');
    }
    _alertSound = AssetSource('sounds/alert.mp3');
  }
  
  /// Play alert sound multiple times with a small delay between plays
  Future<void> playAlertSound({int repeatCount = 10, Duration delay = const Duration(milliseconds: 500)}) async {
    if (_alertSound == null) {
      if (!kReleaseMode) {
        print('[SoundService] Alert sound not loaded, cannot play');
      }
      return;
    }
    
    if (!kReleaseMode) {
      print('[SoundService] Playing alert sound $repeatCount times');
    }
    
    // Set volume to maximum
    await _audioPlayer.setVolume(1.0);
    
    for (int i = 0; i < repeatCount; i++) {
      try {
        await _audioPlayer.play(_alertSound!);
        
        // Wait for the sound to finish playing plus a small delay
        // Alert sound is typically ~0.5 seconds, so we wait 1 second total
        await Future.delayed(const Duration(milliseconds: 1000));
      } catch (e) {
        if (!kReleaseMode) {
          print('[SoundService] Error playing alert sound (attempt ${i + 1}): $e');
        }
      }
    }
  }
  
  /// Play a single alert sound
  Future<void> playSingleAlert() async {
    if (_alertSound == null) return;
    
    try {
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.play(_alertSound!);
    } catch (e) {
      if (!kReleaseMode) {
        print('[SoundService] Error playing single alert: $e');
      }
    }
  }
  
  /// Stop any currently playing sound
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      if (!kReleaseMode) {
        print('[SoundService] Error stopping sound: $e');
      }
    }
  }
  
  /// Dispose the audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}
