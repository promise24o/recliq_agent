import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/core/services/agent_location_service.dart';
import 'package:recliq_agent/features/availability/domain/entities/agent_availability.dart';
import 'package:recliq_agent/features/availability/domain/repositories/availability_repository.dart';

part 'availability_store.g.dart';

@injectable
class AvailabilityStore = _AvailabilityStore with _$AvailabilityStore;

abstract class _AvailabilityStore with Store {
  final AvailabilityRepository _repository;

  _AvailabilityStore(this._repository);

  /// Convert technical errors to user-friendly messages
  String _getHumanizedErrorMessage(String technicalError) {
    if (technicalError.contains('500') || technicalError.contains('Internal Server Error')) {
      return 'Our servers are having a bit of trouble right now. Please try again in a moment.';
    } else if (technicalError.contains('401') || technicalError.contains('Unauthorized')) {
      return 'Your session has expired. Please log in again to continue.';
    } else if (technicalError.contains('403') || technicalError.contains('Forbidden')) {
      return 'You don\'t have permission to access this feature.';
    } else if (technicalError.contains('404') || technicalError.contains('Not Found')) {
      return 'We couldn\'t find what you\'re looking for. It may not exist or may have been moved.';
    } else if (technicalError.contains('timeout') || technicalError.contains('TimeoutException')) {
      return 'The connection is taking too long. Please check your internet connection and try again.';
    } else if (technicalError.contains('network') || technicalError.contains('SocketException')) {
      return 'Unable to connect to our servers. Please check your internet connection.';
    } else if (technicalError.contains('DioException')) {
      return 'Having trouble connecting to our servers. Please try again.';
    } else {
      return 'Something unexpected happened. Our team has been notified and is working on it.';
    }
  }

  AgentLocationService get _locationService => GetIt.instance<AgentLocationService>();

  @observable
  AgentAvailability? availability;

  @observable
  bool isLoading = false;

  @observable
  bool isSaving = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  bool _isTogglingOnline = false;

  @computed
  bool get hasChanges => availability != null;

  @action
  Future<void> loadAvailability() async {
    isLoading = true;
    errorMessage = null;

    try {
      final newAvailability = await _repository.getAvailability();
      // Don't overwrite if user is currently toggling online status
      if (!_isTogglingOnline) {
        availability = newAvailability;
      }
    } catch (e) {
      errorMessage = _getHumanizedErrorMessage(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> saveAvailability() async {
    if (availability == null) return false;

    isSaving = true;
    errorMessage = null;
    successMessage = null;

    try {
      availability = await _repository.updateAvailability(availability!);
      successMessage = 'Schedule updated successfully';
      return true;
    } catch (e) {
      errorMessage = _getHumanizedErrorMessage(e.toString());
      return false;
    } finally {
      isSaving = false;
    }
  }

  @action
  Future<bool> toggleOnlineStatus() async {
    if (availability == null) return false;

    final newStatus = !availability!.isOnline;
    
    // Set flag to prevent loadAvailability from overwriting
    _isTogglingOnline = true;
    
    // Optimistic update - update UI immediately
    availability = availability!.copyWith(isOnline: newStatus);
    
    try {
      // Get current location when going online to store in Redis
      double? lat;
      double? lng;
      double? accuracy;
      
      if (newStatus) {
        // Request location permission and get current position
        final hasPermission = await _locationService.requestPermissionOnly();
        if (hasPermission) {
          final location = await _locationService.getCurrentLocation();
          if (location != null) {
            lat = location.latitude;
            lng = location.longitude;
            accuracy = location.accuracy;
            print('[AvailabilityStore] Got location: $lat, $lng (accuracy: $accuracy)');
          }
        }
      }
      
      final success = await _repository.updateOnlineStatus(
        newStatus,
        lat: lat,
        lng: lng,
        accuracy: accuracy,
      );
      
      if (success) {
        // Start/stop location tracking based on online status
        if (newStatus) {
          await _locationService.goOnline();
        } else {
          _locationService.goOffline();
        }
      }
      return success;
    } catch (e) {
      // Only show error but don't revert - user's intent should be preserved
      errorMessage = 'Having trouble updating your status. Please check your connection and try again.';
      return false;
    } finally {
      // Clear flag after operation completes
      _isTogglingOnline = false;
    }
  }

  @action
  void updateDaySchedule(String day, DaySchedule schedule) {
    if (availability == null) return;
    
    final updatedWeekly = availability!.weeklySchedule.updateDay(day, schedule);
    availability = availability!.copyWith(weeklySchedule: updatedWeekly);
  }

  @action
  void toggleDayEnabled(String day) {
    if (availability == null) return;

    final currentDay = availability!.weeklySchedule.getDay(day);
    final updatedDay = currentDay.copyWith(enabled: !currentDay.enabled);
    updateDaySchedule(day, updatedDay);
  }

  @action
  void addTimeSlot(String day, TimeSlot slot) {
    if (availability == null) return;

    final currentDay = availability!.weeklySchedule.getDay(day);
    final updatedSlots = [...currentDay.timeSlots, slot];
    final updatedDay = currentDay.copyWith(timeSlots: updatedSlots);
    updateDaySchedule(day, updatedDay);
  }

  @action
  void removeTimeSlot(String day, int index) {
    if (availability == null) return;

    final currentDay = availability!.weeklySchedule.getDay(day);
    final updatedSlots = [...currentDay.timeSlots];
    updatedSlots.removeAt(index);
    final updatedDay = currentDay.copyWith(timeSlots: updatedSlots);
    updateDaySchedule(day, updatedDay);
  }

  @action
  void updateTimeSlot(String day, int index, TimeSlot slot) {
    if (availability == null) return;

    final currentDay = availability!.weeklySchedule.getDay(day);
    final updatedSlots = [...currentDay.timeSlots];
    updatedSlots[index] = slot;
    final updatedDay = currentDay.copyWith(timeSlots: updatedSlots);
    updateDaySchedule(day, updatedDay);
  }

  @action
  void toggleEnterpriseJobs(bool value) {
    if (availability == null) return;
    availability = availability!.copyWith(availableForEnterpriseJobs: value);
  }

  @action
  void toggleAutoGoOnline(bool value) {
    if (availability == null) return;
    availability = availability!.copyWith(autoGoOnlineDuringSchedule: value);
  }

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }
}
