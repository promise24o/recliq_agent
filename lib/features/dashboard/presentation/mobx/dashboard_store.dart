import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/core/services/agent_location_service.dart';
import 'package:recliq_agent/features/availability/domain/repositories/availability_repository.dart';
import 'package:recliq_agent/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:recliq_agent/features/dashboard/domain/repositories/dashboard_repository.dart';

part 'dashboard_store.g.dart';

@injectable
class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  final DashboardRepository _repository;

  _DashboardStore(this._repository);

  AvailabilityRepository get _availabilityRepository => GetIt.instance<AvailabilityRepository>();
  AgentLocationService get _locationService => GetIt.instance<AgentLocationService>();

  @observable
  DashboardData? dashboardData;

  @observable
  AgentStats? agentStats;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool isOnline = true;

  @observable
  bool _isTogglingOnline = false;

  @computed
  bool get hasData => dashboardData != null;

  @action
  Future<void> loadDashboard() async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.getDashboardData();
    result.fold(
      (failure) => errorMessage = failure.message,
      (data) {
        dashboardData = data;
        // Don't overwrite if user is currently toggling online status
        if (!_isTogglingOnline) {
          isOnline = data.isOnline;
        }
      },
    );

    isLoading = false;
  }

  @action
  Future<void> loadStats() async {
    final result = await _repository.getAgentStats();
    result.fold(
      (failure) => errorMessage = failure.message,
      (stats) => agentStats = stats,
    );
  }

  @action
  Future<void> toggleOnline() async {
    final newStatus = !isOnline;
    
    // Set flag to prevent loadDashboard from overwriting
    _isTogglingOnline = true;
    
    // Optimistic update - update UI immediately
    isOnline = newStatus;
    
    try {
      final success = await _availabilityRepository.updateOnlineStatus(newStatus);
      if (!success) {
        errorMessage = 'Failed to update online status';
      } else {
        // Start/stop location tracking based on online status
        if (newStatus) {
          await _locationService.goOnline();
        } else {
          _locationService.goOffline();
        }
      }
    } catch (e) {
      errorMessage = 'Sync issue: ${e.toString()}';
    }
    
    // Clear flag after operation completes
    _isTogglingOnline = false;
  }

  @action
  Future<void> refresh() async {
    await Future.wait([loadDashboard(), loadStats()]);
  }
}
