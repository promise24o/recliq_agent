import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_status_card.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_info_card.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_documents_section.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class VehicleContentSection extends StatefulWidget {
  final VehicleDetailsStore store;
  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onEdit;
  final VoidCallback onRefresh;

  const VehicleContentSection({
    super.key,
    required this.store,
    required this.isEditing,
    required this.onSave,
    required this.onCancel,
    required this.onEdit,
    required this.onRefresh,
  });

  @override
  State<VehicleContentSection> createState() => _VehicleContentSectionState();
}

class _VehicleContentSectionState extends State<VehicleContentSection> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (widget.store.vehicleDetails == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with edit and refresh buttons
            _buildHeader(),
            const SizedBox(height: AppTheme.spacing24),

            // Vehicle Status Card
            VehicleStatusCard(
              store: widget.store,
            ),
            const SizedBox(height: AppTheme.spacing16),

            // Vehicle Information Card
            VehicleInfoCard(
              vehicleDetails: widget.store.vehicleDetails!,
              isEditing: widget.isEditing,
              store: widget.store,
            ),
            const SizedBox(height: AppTheme.spacing16),

            // Documents Section
            VehicleDocumentsSection(
              documents: widget.store.vehicleDetails!.documents,
              vehicleStatus: widget.store.vehicleDetails!.status,
            ),
            const SizedBox(height: 150),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Your Vehicle',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        Row(
          children: [
            if (!widget.isEditing)
              SizedBox(
                height: 36,
                child: ElevatedButton.icon(
                  onPressed: widget.onEdit,
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing16,
                      vertical: AppTheme.spacing8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                  ),
                ),
              )
            else
              Row(
                children: [
                  SizedBox(
                    height: 36,
                    child: OutlinedButton(
                      onPressed: widget.onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textSecondary,
                        side: const BorderSide(color: AppTheme.borderSoft),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing16,
                          vertical: AppTheme.spacing8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radius8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: widget.store.isSaving ? null : widget.onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing16,
                          vertical: AppTheme.spacing8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radius8),
                        ),
                      ),
                      child: widget.store.isSaving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text('Save'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
