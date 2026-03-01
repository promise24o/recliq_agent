import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_form.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class VehicleCreateForm extends StatelessWidget {
  final VehicleDetailsStore store;
  final Function(vehicle.CreateVehicleRequest) onSubmit;

  const VehicleCreateForm({
    super.key,
    required this.store,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Your Vehicle',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        const Text(
          'Tell us about your vehicle to get started with recycling collections.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing24),
        Observer(
          builder: (context) {
            return VehicleForm(
              onSubmit: onSubmit,
              isLoading: store.isCreating,
            );
          },
        ),
      ],
    );
  }
}
