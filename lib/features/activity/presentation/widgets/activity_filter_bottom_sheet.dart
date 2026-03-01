import 'package:flutter/material.dart';
import 'package:recliq_agent/features/activity/domain/entities/activity_log.dart';
import 'package:recliq_agent/features/activity/presentation/mobx/activity_store_simple.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ActivityFilterBottomSheet extends StatefulWidget {
  final ActivityStore activityStore;
  final VoidCallback onApply;

  const ActivityFilterBottomSheet({
    super.key,
    required this.activityStore,
    required this.onApply,
  });

  @override
  State<ActivityFilterBottomSheet> createState() => _ActivityFilterBottomSheetState();
}

class _ActivityFilterBottomSheetState extends State<ActivityFilterBottomSheet> {
  late ActionType? _selectedAction;
  late RiskLevel? _selectedRiskLevel;
  late Source? _selectedSource;
  late Outcome? _selectedOutcome;
  late EntityType? _selectedEntityType;
  DateTime? _dateFrom;
  DateTime? _dateTo;

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    _selectedAction = widget.activityStore.selectedAction;
    _selectedRiskLevel = widget.activityStore.selectedRiskLevel;
    _selectedSource = widget.activityStore.selectedSource;
    _selectedOutcome = widget.activityStore.selectedOutcome;
    _selectedEntityType = widget.activityStore.selectedEntityType;
    _dateFrom = widget.activityStore.dateFrom;
    _dateTo = widget.activityStore.dateTo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppTheme.spacing16,
          right: AppTheme.spacing16,
          top: AppTheme.spacing16,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: AppTheme.primaryGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Filter Activity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'Filter by action, risk level, and more',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing24),

              // Action Type
              Text(
                'Action Type',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              DropdownButtonFormField<ActionType?>(
                value: _selectedAction,
                decoration: InputDecoration(
                  hintText: 'All actions',
                  prefixIcon: const Icon(Icons.category_outlined),
                ),
                items: [
                  const DropdownMenuItem<ActionType?>(
                    value: null,
                    child: Text('All actions'),
                  ),
                  ...ActionType.values.map((action) {
                    return DropdownMenuItem<ActionType?>(
                      value: action,
                      child: Text(action.displayName),
                    );
                  }),
                ],
                onChanged: (value) => setState(() => _selectedAction = value),
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Risk Level
              Text(
                'Risk Level',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              DropdownButtonFormField<RiskLevel?>(
                value: _selectedRiskLevel,
                decoration: InputDecoration(
                  hintText: 'All risk levels',
                  prefixIcon: const Icon(Icons.warning_outlined),
                ),
                items: [
                  const DropdownMenuItem<RiskLevel?>(
                    value: null,
                    child: Text('All risk levels'),
                  ),
                  ...RiskLevel.values.map((risk) {
                    return DropdownMenuItem<RiskLevel?>(
                      value: risk,
                      child: Text(risk.displayName),
                    );
                  }),
                ],
                onChanged: (value) => setState(() => _selectedRiskLevel = value),
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Source
              Text(
                'Source',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              DropdownButtonFormField<Source?>(
                value: _selectedSource,
                decoration: InputDecoration(
                  hintText: 'All sources',
                  prefixIcon: const Icon(Icons.devices_outlined),
                ),
                items: [
                  const DropdownMenuItem<Source?>(
                    value: null,
                    child: Text('All sources'),
                  ),
                  ...Source.values.map((source) {
                    return DropdownMenuItem<Source?>(
                      value: source,
                      child: Text(source.displayName),
                    );
                  }),
                ],
                onChanged: (value) => setState(() => _selectedSource = value),
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Outcome
              Text(
                'Outcome',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              DropdownButtonFormField<Outcome?>(
                value: _selectedOutcome,
                decoration: InputDecoration(
                  hintText: 'All outcomes',
                  prefixIcon: const Icon(Icons.flag_outlined),
                ),
                items: [
                  const DropdownMenuItem<Outcome?>(
                    value: null,
                    child: Text('All outcomes'),
                  ),
                  ...Outcome.values.map((outcome) {
                    return DropdownMenuItem<Outcome?>(
                      value: outcome,
                      child: Text(outcome.displayName),
                    );
                  }),
                ],
                onChanged: (value) => setState(() => _selectedOutcome = value),
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Entity Type
              Text(
                'Entity Type',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              DropdownButtonFormField<EntityType?>(
                value: _selectedEntityType,
                decoration: InputDecoration(
                  hintText: 'All entity types',
                  prefixIcon: const Icon(Icons.category_outlined),
                ),
                items: [
                  const DropdownMenuItem<EntityType?>(
                    value: null,
                    child: Text('All entity types'),
                  ),
                  ...EntityType.values.map((entity) {
                    return DropdownMenuItem<EntityType?>(
                      value: entity,
                      child: Text(entity.displayName),
                    );
                  }),
                ],
                onChanged: (value) => setState(() => _selectedEntityType = value),
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Date Range
              Text(
                'Date Range',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'From',
                        hintText: _dateFrom != null 
                            ? '${_dateFrom!.day}/${_dateFrom!.month}/${_dateFrom!.year}'
                            : 'Select date',
                        prefixIcon: const Icon(Icons.calendar_today),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, 'from'),
                        ),
                      ),
                      onTap: () => _selectDate(context, 'from'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'To',
                        hintText: _dateTo != null 
                            ? '${_dateTo!.day}/${_dateTo!.month}/${_dateTo!.year}'
                            : 'Select date',
                        prefixIcon: const Icon(Icons.calendar_today),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, 'to'),
                        ),
                      ),
                      onTap: () => _selectDate(context, 'to'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clearFilters,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.borderSoft),
                        foregroundColor: AppTheme.textSecondary,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                      ),
                      child: const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                      ),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (type == 'from') {
          _dateFrom = picked;
          if (_dateTo != null && _dateTo!.isBefore(_dateFrom!)) {
            _dateTo = _dateFrom;
          }
        } else {
          _dateTo = picked;
          if (_dateFrom != null && _dateFrom!.isAfter(_dateTo!)) {
            _dateFrom = _dateTo;
          }
        }
      });
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedAction = null;
      _selectedRiskLevel = null;
      _selectedSource = null;
      _selectedOutcome = null;
      _selectedEntityType = null;
      _dateFrom = null;
      _dateTo = null;
    });
  }

  void _applyFilters() {
    widget.activityStore.setFilters(
      action: _selectedAction,
      riskLevel: _selectedRiskLevel,
      source: _selectedSource,
      outcome: _selectedOutcome,
      entityType: _selectedEntityType,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
    );
    widget.onApply();
  }
}
