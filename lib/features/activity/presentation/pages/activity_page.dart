import 'package:flutter/material.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/activity/domain/entities/activity_log.dart';
import 'package:recliq_agent/features/activity/presentation/mobx/activity_store_simple.dart';
import 'package:recliq_agent/features/activity/presentation/widgets/activity_filter_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late final ActivityStore _activityStore;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _activityStore = getIt<ActivityStore>();
    _scrollController.addListener(_onScroll);
    _activityStore.loadActivityLogs(refresh: true);
    _activityStore.addListener(_onStoreChanged);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _activityStore.removeListener(_onStoreChanged);
    super.dispose();
  }

  void _onStoreChanged() {
    if (mounted) setState(() {});
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _activityStore.loadMoreActivityLogs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: RecliqAppBar(
        title: 'Activity Logs',
        showBackButton: true,
        showNotifications: false,
        actions: [
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(
              Icons.filter_list,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
      body: LoadingOverlay(
        isVisible: _activityStore.isLoading && _activityStore.activityLogs.isEmpty,
        message: 'Loading activity...',
        child: SizedBox.expand(
          child: RefreshIndicator(
            onRefresh: () async => _activityStore.refresh(),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_activityStore.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cloud_off_rounded,
                  size: 48,
                  color: AppTheme.errorColor,
                ),
              ),
              const SizedBox(height: AppTheme.spacing20),
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                _getHumanizedErrorMessage(_activityStore.errorMessage!),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.borderSoft),
                      foregroundColor: AppTheme.textSecondary,
                    ),
                    child: const Text('Go Back'),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  ElevatedButton(
                    onPressed: _activityStore.refresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    if (!_activityStore.hasActivityLogs && !_activityStore.isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.history_outlined,
                  size: 48,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(height: AppTheme.spacing20),
              const Text(
                'No Activity Found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              const Text(
                'You haven\'t performed any actions yet. Your activity will appear here once you start using the app.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing24),
              ElevatedButton(
                onPressed: _activityStore.refresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Filter chips
        if (_hasActiveFilters) ...[
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Action: ${_activityStore.selectedAction?.displayName ?? 'All'}'),
                  if (_activityStore.selectedRiskLevel != null)
                    _buildFilterChip('Risk: ${_activityStore.selectedRiskLevel!.displayName}'),
                  if (_activityStore.selectedSource != null)
                    _buildFilterChip('Source: ${_activityStore.selectedSource!.displayName}'),
                  if (_activityStore.selectedOutcome != null)
                    _buildFilterChip('Status: ${_activityStore.selectedOutcome!.displayName}'),
                  if (_activityStore.selectedEntityType != null)
                    _buildFilterChip('Type: ${_activityStore.selectedEntityType!.displayName}'),
                  const SizedBox(width: AppTheme.spacing8),
                  TextButton(
                    onPressed: () {
                      _activityStore.clearFilters();
                      _activityStore.refresh();
                    },
                    child: const Text('Clear All'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
        ],
        
        // Activity list
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(AppTheme.spacing16),
            itemCount: _activityStore.activityLogs.length + (_activityStore.hasMorePages ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _activityStore.activityLogs.length) {
                return const Padding(
                  padding: EdgeInsets.all(AppTheme.spacing16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final activity = _activityStore.activityLogs[index];
              return _buildActivityCard(activity);
            },
          ),
        ),
        SizedBox(height: 100)
      ],
    );
  }

  Widget _buildActivityCard(ActivityLog activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: _getRiskLevelColor(activity.riskLevel).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Icon(
                  _getActionIcon(activity.action),
                  color: _getRiskLevelColor(activity.riskLevel),
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.entityName.isNotEmpty ? activity.entityName : activity.entityType.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      activity.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: _getOutcomeColor(activity.outcome).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Text(
                  activity.outcome.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getOutcomeColor(activity.outcome),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: AppTheme.textTertiary,
              ),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                _formatDate(activity.timestamp),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textTertiary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.devices,
                size: 16,
                color: AppTheme.textTertiary,
              ),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                activity.source.displayName,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: AppTheme.spacing8),
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing4,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.primaryGreen,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  bool get _hasActiveFilters {
    return _activityStore.selectedAction != null ||
        _activityStore.selectedRiskLevel != null ||
        _activityStore.selectedSource != null ||
        _activityStore.selectedOutcome != null ||
        _activityStore.selectedEntityType != null ||
        _activityStore.dateFrom != null ||
        _activityStore.dateTo != null;
  }

  Color _getRiskLevelColor(RiskLevel riskLevel) {
    switch (riskLevel) {
      case RiskLevel.low:
        return AppTheme.primaryGreen;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return AppTheme.errorColor;
    }
  }

  Color _getOutcomeColor(Outcome outcome) {
    switch (outcome) {
      case Outcome.success:
        return AppTheme.primaryGreen;
      case Outcome.failed:
        return AppTheme.errorColor;
      case Outcome.pending:
        return Colors.orange;
    }
  }

  IconData _getActionIcon(ActionType action) {
    switch (action) {
      case ActionType.login:
        return Icons.login;
      case ActionType.agentAction:
        return Icons.directions_car_outlined;
      case ActionType.userAction:
        return Icons.person_outline;
      case ActionType.financeAction:
        return Icons.account_balance_outlined;
      case ActionType.zoneAction:
        return Icons.map_outlined;
      case ActionType.sensitiveView:
        return Icons.visibility_outlined;
      case ActionType.passwordChange:
        return Icons.lock_outline;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes} min ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ActivityFilterBottomSheet(
        activityStore: _activityStore,
        onApply: () {
          Navigator.pop(context);
          _activityStore.refresh();
        },
      ),
    );
  }

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
}
