import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class PickupStatusTimeline extends StatelessWidget {
  final List<MatchingTimelineEvent> events;

  const PickupStatusTimeline({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timeline',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            final isLast = index == events.length - 1;
            return _buildTimelineItem(event, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(MatchingTimelineEvent event, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getEventColor(event.type),
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppTheme.borderSoft,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatEventType(event.type),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        _formatTimestamp(event.timestamp),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (event.details != null && event.details!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      event.details!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getEventColor(String type) {
    switch (type) {
      case 'matching_started':
        return Colors.blue;
      case 'agent_notified':
        return AppTheme.warningColor;
      case 'agent_accepted':
        return AppTheme.primaryGreen;
      case 'agent_declined':
        return AppTheme.errorColor;
      case 'agent_en_route':
        return Colors.blue;
      case 'agent_arrived':
        return Colors.purple;
      case 'completed':
        return AppTheme.successColor;
      case 'cancelled':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatEventType(String type) {
    switch (type) {
      case 'matching_started':
        return 'Matching Started';
      case 'agent_notified':
        return 'Agent Notified';
      case 'agent_accepted':
        return 'Agent Accepted';
      case 'agent_declined':
        return 'Agent Declined';
      case 'agent_en_route':
        return 'Agent En Route';
      case 'agent_arrived':
        return 'Agent Arrived';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return type.replaceAll('_', ' ').split(' ').map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        }).join(' ');
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return DateFormat('MMM d, h:mm a').format(dateTime);
    } catch (e) {
      return timestamp;
    }
  }
}
