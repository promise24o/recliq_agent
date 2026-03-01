import 'package:flutter/material.dart';
import 'package:recliq_agent/features/availability/domain/entities/agent_availability.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class DayScheduleCard extends StatelessWidget {
  final String day;
  final DaySchedule schedule;
  final VoidCallback onToggle;
  final Function(TimeSlot) onAddTimeSlot;
  final Function(int) onRemoveTimeSlot;
  final Function(int, TimeSlot) onUpdateTimeSlot;

  const DayScheduleCard({
    super.key,
    required this.day,
    required this.schedule,
    required this.onToggle,
    required this.onAddTimeSlot,
    required this.onRemoveTimeSlot,
    required this.onUpdateTimeSlot,
  });

  String get _dayName => day[0].toUpperCase() + day.substring(1);

  @override
  Widget build(BuildContext context) {
    final isEnabled = schedule.enabled;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEnabled ? AppTheme.primaryGreen.withOpacity(0.4) : AppTheme.borderSoft,
          width: isEnabled ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isEnabled ? AppTheme.primaryGreen.withOpacity(0.08) : Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with toggle
          Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: InkWell(
              onTap: onToggle,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isEnabled
                            ? AppTheme.primaryGreen.withOpacity(0.15)
                            : AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _dayName.substring(0, 3).toUpperCase(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: isEnabled ? AppTheme.primaryGreen : AppTheme.textTertiary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _dayName,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: isEnabled ? AppTheme.textPrimary : AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isEnabled
                                ? (schedule.timeSlots.isEmpty
                                    ? 'No slots added'
                                    : _getTimeSlotsSummary())
                                : 'Unavailable',
                            style: TextStyle(
                              fontSize: 13,
                              color: isEnabled ? AppTheme.textSecondary : AppTheme.textTertiary,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: isEnabled,
                      onChanged: (_) => onToggle(),
                      activeColor: AppTheme.primaryGreen,
                      inactiveThumbColor: AppTheme.textTertiary,
                      inactiveTrackColor: AppTheme.surfaceColor,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Time slots section
          if (isEnabled) ...[
            const Divider(height: 1, thickness: 1, color: AppTheme.borderSoft),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (schedule.timeSlots.isEmpty)
                    _buildEmptyState()
                  else
                    ...schedule.timeSlots.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildTimeSlotTile(context, entry.key, entry.value),
                      );
                    }),

                  const SizedBox(height: 12),
                  _buildAddButton(context),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getTimeSlotsSummary() {
    if (schedule.timeSlots.isEmpty) return 'No slots';
    if (schedule.timeSlots.length == 1) {
      final s = schedule.timeSlots.first;
      return '${s.startTime} – ${s.endTime}';
    }
    return '${schedule.timeSlots.length} time slots';
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty_rounded,
              color: AppTheme.textTertiary, size: 20),
          const SizedBox(width: 12),
          Text(
            'No time slots added yet',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotTile(BuildContext context, int index, TimeSlot slot) {
    return Material(
      color: AppTheme.primaryGreen.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showEditTimeSlotDialog(context, index, slot),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.access_time_rounded,
                    color: AppTheme.primaryGreen, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '${slot.startTime} – ${slot.endTime}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                color: AppTheme.primaryGreen,
                onPressed: () => _showEditTimeSlotDialog(context, index, slot),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 20),
                color: AppTheme.errorColor.withOpacity(0.85),
                onPressed: () => onRemoveTimeSlot(index),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showAddTimeSlotDialog(context),
        icon: const Icon(Icons.add_rounded, size: 20),
        label: const Text(
          'Add Time Slot',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primaryGreen,
          side: BorderSide(color: AppTheme.primaryGreen.withOpacity(0.5)),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _showAddTimeSlotDialog(BuildContext context) {
    _showTimeSlotDialog(
      context,
      title: 'Add Time Slot',
      onSave: (start, end) => onAddTimeSlot(TimeSlot(startTime: start, endTime: end)),
    );
  }

  void _showEditTimeSlotDialog(BuildContext context, int index, TimeSlot slot) {
    _showTimeSlotDialog(
      context,
      title: 'Edit Time Slot',
      initialStart: slot.startTime,
      initialEnd: slot.endTime,
      onSave: (start, end) => onUpdateTimeSlot(index, TimeSlot(startTime: start, endTime: end)),
    );
  }

  void _showTimeSlotDialog(
    BuildContext context, {
    required String title,
    String? initialStart,
    String? initialEnd,
    required Function(String, String) onSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TimeSlotBottomSheet(
        title: title,
        initialStart: initialStart,
        initialEnd: initialEnd,
        onSave: onSave,
      ),
    );
  }
}

class _TimePickerField extends StatefulWidget {
  final String label;
  final String initialTime;
  final Function(String) onChanged;

  const _TimePickerField({
    required this.label,
    required this.initialTime,
    required this.onChanged,
  });

  @override
  State<_TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<_TimePickerField> {
  late String _time;

  @override
  void initState() {
    super.initState();
    _time = widget.initialTime;
  }

  Future<void> _pickTime() async {
    final parts = _time.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 9,
      minute: int.tryParse(parts[1]) ?? 0,
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: AppTheme.primaryGreen,
            onPrimary: Colors.white,
            surface: AppTheme.cardBackground,
            onSurface: AppTheme.textPrimary,
          ),
          dialogBackgroundColor: AppTheme.cardBackground,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppTheme.primaryGreen),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null && mounted) {
      final formatted = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      setState(() => _time = formatted);
      widget.onChanged(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickTime,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderSoft),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time_rounded, color: AppTheme.primaryGreen, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _time,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded,
                color: AppTheme.textSecondary, size: 24),
          ],
        ),
      ),
    );
  }
}

class _TimeSlotBottomSheet extends StatefulWidget {
  final String title;
  final String? initialStart;
  final String? initialEnd;
  final Function(String, String) onSave;

  const _TimeSlotBottomSheet({
    required this.title,
    this.initialStart,
    this.initialEnd,
    required this.onSave,
  });

  @override
  State<_TimeSlotBottomSheet> createState() => _TimeSlotBottomSheetState();
}

class _TimeSlotBottomSheetState extends State<_TimeSlotBottomSheet> {
  late String startTime;
  late String endTime;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    startTime = widget.initialStart ?? '09:00';
    endTime = widget.initialEnd ?? '17:00';
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
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16 + 100, // Extra space for floating navbar
        ),
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
            const SizedBox(height: 16),
            
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.schedule_outlined,
                    color: AppTheme.primaryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Text(
                        'Select your working hours',
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
            const SizedBox(height: 24),

            // Start Time
            _TimePickerField(
              label: 'Start Time',
              initialTime: startTime,
              onChanged: (value) => startTime = value,
            ),
            const SizedBox(height: 16),

            // End Time
            _TimePickerField(
              label: 'End Time',
              initialTime: endTime,
              onChanged: (value) => endTime = value,
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Save Time Slot',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  void _handleSave() {
    // Validate that end time is after start time
    final startParts = startTime.split(':');
    final endParts = endTime.split(':');
    
    final startHour = int.tryParse(startParts[0]) ?? 0;
    final startMinute = int.tryParse(startParts[1]) ?? 0;
    final endHour = int.tryParse(endParts[0]) ?? 0;
    final endMinute = int.tryParse(endParts[1]) ?? 0;
    
    final startTotalMinutes = startHour * 60 + startMinute;
    final endTotalMinutes = endHour * 60 + endMinute;
    
    if (endTotalMinutes <= startTotalMinutes) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End time must be after start time'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }
    
    setState(() => isLoading = true);
    
    // Simulate a brief loading state for better UX
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        widget.onSave(startTime, endTime);
        Navigator.pop(context);
      }
    });
  }
}