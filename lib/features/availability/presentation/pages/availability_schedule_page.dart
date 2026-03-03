import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/availability/presentation/mobx/availability_store.dart';
import 'package:recliq_agent/features/availability/presentation/widgets/day_schedule_card.dart';
import 'package:recliq_agent/features/availability/presentation/widgets/insights_card.dart';
import 'package:recliq_agent/features/availability/presentation/widgets/online_status_card.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class AvailabilitySchedulePage extends StatefulWidget {
  const AvailabilitySchedulePage({super.key});

  @override
  State<AvailabilitySchedulePage> createState() => _AvailabilitySchedulePageState();
}

class _AvailabilitySchedulePageState extends State<AvailabilitySchedulePage> {
  final _store = getIt<AvailabilityStore>();

  @override
  void initState() {
    super.initState();
    _store.loadAvailability();
  }

  Future<void> _handleSave() async {
    final success = await _store.saveAvailability();
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.successMessage ?? 'Schedule updated successfully'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    } else if (_store.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.errorMessage!),
          backgroundColor: AppTheme.errorColor,
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: const PageAppBar(
        title: 'Availability Schedule',
      ),
      body: Observer(
        builder: (_) {
          // Show error if any
          if (_store.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.cloud_off_rounded,
                        size: 48,
                        color: AppTheme.errorColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Oops! Something went wrong',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _store.errorMessage!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
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
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => _store.loadAvailability(),
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
          
          return LoadingOverlay(
            isVisible: _store.isLoading && _store.availability == null,
            message: 'Loading schedule...',
            child: SizedBox.expand(
              child: RefreshIndicator(
                onRefresh: () => _store.loadAvailability(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      
                      // Online Status Card
                      if (_store.availability != null)
                        OnlineStatusCard(store: _store),
                      if (_store.availability != null)
                        const SizedBox(height: 16),

                      // Insights Card
                      if (_store.availability?.insights != null)
                        InsightsCard(insights: _store.availability!.insights!),
                      if (_store.availability?.insights != null)
                        const SizedBox(height: 24),

                      // Weekly Schedule Section
                      _buildWeeklyScheduleSection(),
                      const SizedBox(height: 24),

                      // Settings Section
                      _buildSettingsSection(),
                      const SizedBox(height: 24),

                      // Save Button
                      _buildSaveButton(),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Working Hours',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Set your weekly availability schedule',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyScheduleSection() {
    return Observer(
      builder: (_) {
        if (_store.availability == null) {
          return const SizedBox();
        }

        final days = [
          'monday',
          'tuesday',
          'wednesday',
          'thursday',
          'friday',
          'saturday',
          'sunday',
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: AppTheme.primaryGreen,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Weekly Schedule',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...days.map((day) {
              final schedule = _store.availability!.weeklySchedule.getDay(day);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DayScheduleCard(
                  day: day,
                  schedule: schedule,
                  onToggle: () => _store.toggleDayEnabled(day),
                  onAddTimeSlot: (slot) => _store.addTimeSlot(day, slot),
                  onRemoveTimeSlot: (index) => _store.removeTimeSlot(day, index),
                  onUpdateTimeSlot: (index, slot) => _store.updateTimeSlot(day, index, slot),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildSettingsSection() {
    return Observer(
      builder: (_) {
        if (_store.availability == null) return const SizedBox();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    size: 20,
                    color: AppTheme.primaryGreen,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSettingTile(
                'Available for Enterprise Jobs',
                'Accept jobs from corporate clients',
                _store.availability!.availableForEnterpriseJobs,
                (value) => _store.toggleEnterpriseJobs(value),
              ),
              const Divider(height: 24),
              _buildSettingTile(
                'Auto Go Online',
                'Automatically go online during scheduled hours',
                _store.availability!.autoGoOnlineDuringSchedule,
                (value) => _store.toggleAutoGoOnline(value),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primaryGreen,
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Observer(
      builder: (_) {
        return SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _store.isSaving ? null : _handleSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              disabledBackgroundColor: AppTheme.primaryGreen.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _store.isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Save Schedule',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
