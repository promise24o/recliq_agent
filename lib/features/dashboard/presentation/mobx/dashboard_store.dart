import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:recliq_agent/features/dashboard/domain/repositories/dashboard_repository.dart';

part 'dashboard_store.g.dart';

@injectable
class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  final DashboardRepository _repository;

  _DashboardStore(this._repository);

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
        isOnline = data.isOnline;
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
    final result = await _repository.toggleOnlineStatus(newStatus);
    result.fold(
      (failure) => errorMessage = failure.message,
      (_) => isOnline = newStatus,
    );
  }

  @action
  Future<void> refresh() async {
    await Future.wait([loadDashboard(), loadStats()]);
  }
}
