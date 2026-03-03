import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class PickupRequestCard extends StatelessWidget {
  final PickupRequest request;
  final VoidCallback onTap;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const PickupRequestCard({
    super.key,
    required this.request,
    required this.onTap,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getStatusColor().withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(color: AppTheme.borderSoft, height: 1),
            _buildContent(),
            const Divider(color: AppTheme.borderSoft, height: 1),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getWasteTypeColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getWasteTypeIcon(),
              color: _getWasteTypeColor(),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.userName ?? 'Customer',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatWasteType(request.wasteType),
                  style: TextStyle(
                    fontSize: 13,
                    color: _getWasteTypeColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getStatusColor().withOpacity(0.3),
        ),
      ),
      child: Text(
        _formatStatus(request.status),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _getStatusColor(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoRow(
            Icons.location_on_outlined,
            request.address ?? 'No address provided',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  Icons.scale_outlined,
                  '${request.estimatedWeight} kg',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoChip(
                  Icons.payments_outlined,
                  '${request.pricing?.currency ?? 'NGN'} ${request.pricing?.totalAmount.toStringAsFixed(0) ?? '0'}',
                ),
              ),
            ],
          ),
          if (request.slaDeadline != null) ...[
            const SizedBox(height: 12),
            _buildSlaTimer(),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppTheme.textSecondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppTheme.primaryGreen,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlaTimer() {
    final deadline = DateTime.tryParse(request.slaDeadline!);
    if (deadline == null) return const SizedBox.shrink();

    final now = DateTime.now();
    final remaining = deadline.difference(now);
    final isUrgent = remaining.inMinutes < 30;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isUrgent
            ? AppTheme.errorColor.withOpacity(0.1)
            : AppTheme.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUrgent
              ? AppTheme.errorColor.withOpacity(0.3)
              : AppTheme.warningColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 16,
            color: isUrgent ? AppTheme.errorColor : AppTheme.warningColor,
          ),
          const SizedBox(width: 6),
          Text(
            'SLA: ${_formatDuration(remaining)}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isUrgent ? AppTheme.errorColor : AppTheme.warningColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onDecline,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.errorColor,
                side: const BorderSide(color: AppTheme.errorColor),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Decline',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onAccept,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Accept',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (request.status) {
      case PickupStatus.pendingAcceptance:
        return AppTheme.warningColor;
      case PickupStatus.assigned:
        return AppTheme.primaryGreen;
      case PickupStatus.agentEnRoute:
        return Colors.blue;
      case PickupStatus.arrived:
        return Colors.purple;
      case PickupStatus.completed:
        return AppTheme.successColor;
      case PickupStatus.cancelled:
      case PickupStatus.failed:
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatStatus(PickupStatus status) {
    switch (status) {
      case PickupStatus.newRequest:
        return 'New';
      case PickupStatus.matching:
        return 'Matching';
      case PickupStatus.pendingAcceptance:
        return 'Pending';
      case PickupStatus.assigned:
        return 'Assigned';
      case PickupStatus.agentEnRoute:
        return 'En Route';
      case PickupStatus.arrived:
        return 'Arrived';
      case PickupStatus.completed:
        return 'Completed';
      case PickupStatus.cancelled:
        return 'Cancelled';
      case PickupStatus.failed:
        return 'Failed';
    }
  }

  Color _getWasteTypeColor() {
    switch (request.wasteType) {
      case WasteType.plastic:
        return Colors.blue;
      case WasteType.paper:
        return Colors.brown;
      case WasteType.metal:
        return Colors.grey;
      case WasteType.glass:
        return Colors.teal;
      case WasteType.organic:
        return Colors.green;
      case WasteType.eWaste:
        return Colors.orange;
      case WasteType.mixed:
        return Colors.purple;
    }
  }

  IconData _getWasteTypeIcon() {
    switch (request.wasteType) {
      case WasteType.plastic:
        return Icons.local_drink_outlined;
      case WasteType.paper:
        return Icons.description_outlined;
      case WasteType.metal:
        return Icons.settings_outlined;
      case WasteType.glass:
        return Icons.wine_bar_outlined;
      case WasteType.organic:
        return Icons.eco_outlined;
      case WasteType.eWaste:
        return Icons.devices_outlined;
      case WasteType.mixed:
        return Icons.delete_outline;
    }
  }

  String _formatWasteType(WasteType type) {
    switch (type) {
      case WasteType.plastic:
        return 'Plastic';
      case WasteType.paper:
        return 'Paper';
      case WasteType.metal:
        return 'Metal';
      case WasteType.glass:
        return 'Glass';
      case WasteType.organic:
        return 'Organic';
      case WasteType.eWaste:
        return 'E-Waste';
      case WasteType.mixed:
        return 'Mixed';
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) {
      return 'Overdue';
    }
    
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    }
    return '${duration.inMinutes}m';
  }
}
