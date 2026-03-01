import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class VehicleStatusCard extends StatelessWidget {
  final VehicleDetailsStore store;

  const VehicleStatusCard({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (store.vehicleDetails == null) return const SizedBox();
        
        final vehicleDetails = store.vehicleDetails!;
        
        return Container(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(AppTheme.radius16),
            border: Border.all(color: AppTheme.borderSoft),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: AppTheme.primaryGreen,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  const Text(
                    'Vehicle Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  _buildVerificationStatusBadge(vehicleDetails),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatusIndicator(
                      context,
                      'Active Status',
                      vehicleDetails.isActive ? Icons.check_circle_outlined : Icons.cancel_outlined,
                      vehicleDetails.isActive,
                      () => _showActiveStatusBottomSheet(context, vehicleDetails),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildStatusIndicator(
                      context,
                      'Maintenance',
                      vehicleDetails.isUnderMaintenance ? Icons.build_outlined : Icons.build_circle_outlined,
                      !vehicleDetails.isUnderMaintenance,
                      () => _showMaintenanceBottomSheet(context, vehicleDetails),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              
              _buildEnterpriseEligibility(vehicleDetails),
              const SizedBox(height: AppTheme.spacing16),
              
              _buildLastUpdated(vehicleDetails),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusIndicator(
    BuildContext context,
    String label,
    IconData icon,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.successColor.withValues(alpha: 0.1)
              : AppTheme.errorColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(
            color: isActive
                ? AppTheme.successColor.withValues(alpha: 0.3)
                : AppTheme.errorColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.successColor : AppTheme.errorColor,
              size: 24,
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              isActive ? 'Active' : 'Inactive',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? AppTheme.successColor : AppTheme.errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnterpriseEligibility(vehicle.VehicleDetails vehicleDetails) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: vehicleDetails.isEnterpriseEligible
            ? AppTheme.primaryGreen.withValues(alpha: 0.1)
            : AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: vehicleDetails.isEnterpriseEligible
              ? AppTheme.primaryGreen.withValues(alpha: 0.3)
              : AppTheme.borderSoft,
        ),
      ),
      child: Row(
        children: [
          Icon(
            vehicleDetails.isEnterpriseEligible
                ? Icons.workspace_premium_outlined
                : Icons.workspace_premium,
            color: vehicleDetails.isEnterpriseEligible
                ? AppTheme.primaryGreen
                : AppTheme.textTertiary,
            size: 20,
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enterprise Eligibility',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  vehicleDetails.isEnterpriseEligible
                      ? 'Eligible for enterprise jobs'
                      : 'Not eligible for enterprise jobs',
                  style: TextStyle(
                    fontSize: 12,
                    color: vehicleDetails.isEnterpriseEligible
                        ? AppTheme.primaryGreen
                        : AppTheme.textSecondary,
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
              color: vehicleDetails.isEnterpriseEligible
                  ? AppTheme.primaryGreen.withValues(alpha: 0.2)
                  : AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
            child: Text(
              vehicleDetails.isEnterpriseEligible ? 'ELIGIBLE' : 'NOT ELIGIBLE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: vehicleDetails.isEnterpriseEligible
                    ? AppTheme.primaryGreen
                    : AppTheme.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdated(vehicle.VehicleDetails vehicleDetails) {
    return Row(
      children: [
        Icon(
          Icons.update_outlined,
          color: AppTheme.textTertiary,
          size: 16,
        ),
        const SizedBox(width: AppTheme.spacing8),
        Text(
          'Last updated ${_formatRelativeTime(vehicleDetails.updatedAt)}',
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textTertiary,
          ),
        ),
      ],
    );
  }

  void _showActiveStatusBottomSheet(BuildContext context, vehicle.VehicleDetails vehicleDetails) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: AppTheme.spacing16,
            right: AppTheme.spacing16,
            top: AppTheme.spacing16,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100, // Extra space for floating navbar
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
              const SizedBox(height: AppTheme.spacing16),
              
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing8),
                    decoration: BoxDecoration(
                      color: vehicleDetails.isActive 
                          ? AppTheme.errorColor.withValues(alpha: 0.15)
                          : AppTheme.successColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: Icon(
                      vehicleDetails.isActive ? Icons.power_settings_new : Icons.check_circle_outline,
                      color: vehicleDetails.isActive ? AppTheme.errorColor : AppTheme.successColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicleDetails.isActive ? 'Deactivate Vehicle?' : 'Activate Vehicle?',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          vehicleDetails.isActive
                              ? 'You will not receive new collection requests while deactivated'
                              : 'You will start receiving new collection requests',
                          style: const TextStyle(
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

              // Description
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                  border: Border.all(color: AppTheme.borderSoft),
                ),
                child: Text(
                  vehicleDetails.isActive
                      ? 'Are you sure you want to deactivate this vehicle? You will not receive new collection requests while deactivated.'
                      : 'Are you sure you want to activate this vehicle? You will start receiving new collection requests.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.borderSoft),
                        foregroundColor: AppTheme.textSecondary,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        store.updateVehicleStatus(vehicle.UpdateVehicleStatusRequest(
                          isActive: !vehicleDetails.isActive,
                          isUnderMaintenance: vehicleDetails.isUnderMaintenance,
                        ));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: vehicleDetails.isActive ? AppTheme.errorColor : AppTheme.successColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                      ),
                      child: Text(vehicleDetails.isActive ? 'Deactivate' : 'Activate'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaintenanceBottomSheet(BuildContext context, vehicle.VehicleDetails vehicleDetails) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: AppTheme.spacing16,
            right: AppTheme.spacing16,
            top: AppTheme.spacing16,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100, // Extra space for floating navbar
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
              const SizedBox(height: AppTheme.spacing16),
              
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing8),
                    decoration: BoxDecoration(
                      color: vehicleDetails.isUnderMaintenance 
                          ? AppTheme.successColor.withValues(alpha: 0.15)
                          : AppTheme.warningColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: Icon(
                      vehicleDetails.isUnderMaintenance ? Icons.check_circle_outline : Icons.build_outlined,
                      color: vehicleDetails.isUnderMaintenance ? AppTheme.successColor : AppTheme.warningColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicleDetails.isUnderMaintenance ? 'End Maintenance?' : 'Start Maintenance?',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          vehicleDetails.isUnderMaintenance
                              ? 'Your vehicle will be available for new collection requests'
                              : 'Your vehicle will be temporarily unavailable for new collection requests',
                          style: const TextStyle(
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

              // Description
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                  border: Border.all(color: AppTheme.borderSoft),
                ),
                child: Text(
                  vehicleDetails.isUnderMaintenance
                      ? 'Are you sure you want to end maintenance? Your vehicle will be available for new collection requests.'
                      : 'Are you sure you want to start maintenance? Your vehicle will be temporarily unavailable for new collection requests.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.borderSoft),
                        foregroundColor: AppTheme.textSecondary,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        store.updateVehicleStatus(vehicle.UpdateVehicleStatusRequest(
                          isActive: vehicleDetails.isActive,
                          isUnderMaintenance: !vehicleDetails.isUnderMaintenance,
                        ));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: vehicleDetails.isUnderMaintenance ? AppTheme.successColor : AppTheme.warningColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                      ),
                      child: Text(vehicleDetails.isUnderMaintenance ? 'End Maintenance' : 'Start Maintenance'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
            ],
          ),
        ),
      ),
    );
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  Widget _buildVerificationStatusBadge(vehicle.VehicleDetails vehicleDetails) {
    final status = vehicleDetails.status.name;
    final statusColor = _getVerificationStatusColor(vehicleDetails.status);
    final statusIcon = _getVerificationStatusIcon(vehicleDetails.status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing6,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius20),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            size: 14,
            color: statusColor,
          ),
          const SizedBox(width: AppTheme.spacing4),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: statusColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Color _getVerificationStatusColor(vehicle.VehicleStatus status) {
    switch (status) {
      case vehicle.VehicleStatus.verified:
        return AppTheme.successColor;
      case vehicle.VehicleStatus.pending:
        return AppTheme.warningColor;
      case vehicle.VehicleStatus.rejected:
        return AppTheme.errorColor;
      case vehicle.VehicleStatus.approved:
        return AppTheme.successColor;
    }
  }

  IconData _getVerificationStatusIcon(vehicle.VehicleStatus status) {
    switch (status) {
      case vehicle.VehicleStatus.verified:
        return Icons.verified_outlined;
      case vehicle.VehicleStatus.pending:
        return Icons.pending_outlined;
      case vehicle.VehicleStatus.rejected:
        return Icons.close_outlined;
      case vehicle.VehicleStatus.approved:
        return Icons.verified_outlined;
    }
  }
}
