import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.icon,
  });

  factory StatusBadge.online() => const StatusBadge(
        label: 'Online',
        color: AppTheme.successColor,
        icon: Icons.circle,
      );

  factory StatusBadge.offline() => const StatusBadge(
        label: 'Offline',
        color: AppTheme.textTertiary,
        icon: Icons.circle,
      );

  factory StatusBadge.pending() => const StatusBadge(
        label: 'Pending',
        color: AppTheme.warningColor,
        icon: Icons.access_time,
      );

  factory StatusBadge.completed() => const StatusBadge(
        label: 'Completed',
        color: AppTheme.successColor,
        icon: Icons.check_circle,
      );

  factory StatusBadge.failed() => const StatusBadge(
        label: 'Failed',
        color: AppTheme.errorColor,
        icon: Icons.error,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radius20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 8, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
