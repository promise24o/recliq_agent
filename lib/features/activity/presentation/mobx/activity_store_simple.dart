import 'package:flutter/material.dart';
import 'package:recliq_agent/features/activity/domain/entities/activity_log.dart';
import 'package:recliq_agent/features/activity/domain/repositories/activity_repository.dart';

class ActivityStore extends ChangeNotifier {
  final ActivityRepository _repository;

  ActivityStore(this._repository);

  ActivityLogResponse? activityResponse;
  List<ActivityLog> activityLogs = [];
  bool isLoading = false;
  String? errorMessage;
  int currentPage = 1;
  int totalPages = 1;

  ActionType? selectedAction;
  RiskLevel? selectedRiskLevel;
  Source? selectedSource;
  Outcome? selectedOutcome;
  EntityType? selectedEntityType;
  DateTime? dateFrom;
  DateTime? dateTo;

  bool get hasMorePages => currentPage < totalPages;
  bool get hasActivityLogs => activityLogs.isNotEmpty;

  Future<void> loadActivityLogs({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      activityLogs.clear();
    }

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await _repository.getActivityLogs(
        action: selectedAction,
        riskLevel: selectedRiskLevel,
        source: selectedSource,
        outcome: selectedOutcome,
        entityType: selectedEntityType,
        dateFrom: dateFrom,
        dateTo: dateTo,
        page: currentPage,
        limit: 20,
      );

      result.fold(
        (failure) {
          print("Store error: ${failure.message}");
          errorMessage = _getHumanizedError(failure.message);
        },
        (response) {
          print("Store success: ${response.logs.length} logs");
          activityResponse = response;
          if (refresh) {
            activityLogs = response.logs;
          } else {
            activityLogs.addAll(response.logs);
          }
          totalPages = response.totalPages;
          currentPage = response.page;
        },
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreActivityLogs() async {
    if (isLoading || !hasMorePages) return;

    currentPage++;
    await loadActivityLogs();
  }

  void setFilters({
    ActionType? action,
    RiskLevel? riskLevel,
    Source? source,
    Outcome? outcome,
    EntityType? entityType,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) {
    selectedAction = action;
    selectedRiskLevel = riskLevel;
    selectedSource = source;
    selectedOutcome = outcome;
    selectedEntityType = entityType;
    this.dateFrom = dateFrom;
    this.dateTo = dateTo;
  }

  void clearFilters() {
    selectedAction = null;
    selectedRiskLevel = null;
    selectedSource = null;
    selectedOutcome = null;
    selectedEntityType = null;
    dateFrom = null;
    dateTo = null;
  }

  void refresh() {
    loadActivityLogs(refresh: true);
  }

  String _getHumanizedError(String technicalError) {
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
}
