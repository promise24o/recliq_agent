import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/pages/vehicle_document_upload_page.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_form.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class AddVehicleBottomSheet extends StatefulWidget {
  const AddVehicleBottomSheet({super.key});

  @override
  State<AddVehicleBottomSheet> createState() => _AddVehicleBottomSheetState();
}

class _AddVehicleBottomSheetState extends State<AddVehicleBottomSheet> {
  final VehicleDetailsStore _store = getIt<VehicleDetailsStore>();

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
          bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100, // Extra space for floating navbar
        ),
        child: DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
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
                        child: Icon(
                          Icons.directions_car_outlined,
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
                              'Add Vehicle Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            Text(
                              'Register your vehicle to start receiving collection requests',
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

                  // Vehicle Form
                  Observer(
                    builder: (context) {
                      return VehicleForm(
                        onSubmit: _handleCreateVehicle,
                        isLoading: _store.isCreating,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleCreateVehicle(vehicle.CreateVehicleRequest request) async {
    try {
      final success = await _store.createVehicleDetails(request);
      if (success && mounted) {
        Navigator.pop(context);
        // Navigate to document upload page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VehicleDocumentUploadPage(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add vehicle details: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }
}
