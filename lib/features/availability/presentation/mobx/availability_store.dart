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
      errorMessage = e.toString();
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
      errorMessage = e.toString();
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
      final success = await _repository.updateOnlineStatus(newStatus);
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
      errorMessage = 'Sync issue: ${e.toString()}';
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
