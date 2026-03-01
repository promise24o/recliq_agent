import 'package:flutter/material.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class VehicleInfoCard extends StatelessWidget {
  final vehicle.VehicleDetails vehicleDetails;
  final bool isEditing;
  final VehicleDetailsStore store;

  const VehicleInfoCard({
    super.key,
    required this.vehicleDetails,
    required this.isEditing,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
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
                Icons.directions_car_outlined,
                color: AppTheme.primaryGreen,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              const Text(
                'Vehicle Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing20),
          
          // Basic Info Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Type',
                  vehicleDetails.vehicleType.toString(),
                  isEditing,
                  () => _showVehicleTypeDialog(context),
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildInfoItem(
                  'Fuel',
                  vehicleDetails.fuelType.toString(),
                  isEditing,
                  () => _showFuelTypeDialog(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          // Plate Number and Color Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Plate Number',
                  vehicleDetails.plateNumber,
                  isEditing,
                  () => _showPlateNumberDialog(context),
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildInfoItem(
                  'Color',
                  vehicleDetails.vehicleColor,
                  isEditing,
                  () => _showVehicleColorDialog(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          // Load Capacity Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Max Load Weight',
                  '${vehicleDetails.maxLoadWeight} kg',
                  isEditing,
                  () => _showLoadWeightDialog(context),
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildInfoItem(
                  'Max Load Volume',
                  '${vehicleDetails.maxLoadVolume} L',
                  isEditing,
                  () => _showLoadVolumeDialog(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          // Dates Row
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Registration Expires',
                  _formatDate(vehicleDetails.registrationExpiryDate),
                  isEditing,
                  () => _showRegistrationDateDialog(context),
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildInfoItem(
                  'Insurance Expires',
                  _formatDate(vehicleDetails.insuranceExpiryDate),
                  isEditing,
                  () => _showInsuranceDateDialog(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          // Material Compatibility
          _buildMaterialCompatibility(context),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    bool isEditable,
    VoidCallback? onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppTheme.spacing4),
        GestureDetector(
          onTap: isEditable && onTap != null ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12,
              vertical: AppTheme.spacing8,
            ),
            decoration: BoxDecoration(
              color: isEditable ? AppTheme.surfaceColor : Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.radius8),
              border: isEditable ? Border.all(color: AppTheme.borderSoft) : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isEditable && onTap != null) ...[
                  const SizedBox(width: AppTheme.spacing4),
                  Icon(
                    Icons.edit_outlined,
                    size: 14,
                    color: AppTheme.primaryGreen,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialCompatibility(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Material Compatibility',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        GestureDetector(
          onTap: isEditing ? () => _showMaterialCompatibilityDialog(context) : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: isEditing ? AppTheme.surfaceColor : Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.radius8),
              border: isEditing ? Border.all(color: AppTheme.borderSoft) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppTheme.spacing4,
                  runSpacing: AppTheme.spacing4,
                  children: vehicleDetails.materialCompatibility.map((material) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8,
                        vertical: AppTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radius12),
                      ),
                      child: Text(
                        material.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (isEditing) ...[
                  const SizedBox(height: AppTheme.spacing4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 14,
                        color: AppTheme.primaryGreen,
                      ),
                      const SizedBox(width: AppTheme.spacing4),
                      const Text(
                        'Tap to edit',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.primaryGreen,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showVehicleTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildSelectionDialog<vehicle.VehicleType>(
        context,
        'Select Vehicle Type',
        vehicle.VehicleType.values,
        vehicleDetails.vehicleType,
        (value) {
          store.updateVehicleType(value);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showFuelTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _buildSelectionDialog<vehicle.FuelType>(
        context,
        'Select Fuel Type',
        vehicle.FuelType.values,
        vehicleDetails.fuelType,
        (value) {
          store.updateFuelType(value);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showPlateNumberDialog(BuildContext context) {
    final controller = TextEditingController(text: vehicleDetails.plateNumber);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Plate Number',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter plate number',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              store.updatePlateNumber(controller.text.trim());
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showVehicleColorDialog(BuildContext context) {
    final controller = TextEditingController(text: vehicleDetails.vehicleColor);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Edit Vehicle Color',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: const InputDecoration(
            hintText: 'Enter vehicle color',
            hintStyle: TextStyle(color: AppTheme.textTertiary),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                store.updateVehicleColor(controller.text.trim());
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showLoadWeightDialog(BuildContext context) {
    final controller = TextEditingController(text: vehicleDetails.maxLoadWeight.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Edit Max Load Weight',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: const InputDecoration(
            hintText: 'Enter weight in kg',
            hintStyle: TextStyle(color: AppTheme.textTertiary),
            suffixText: 'kg',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final weight = int.tryParse(controller.text);
              if (weight != null && weight > 0) {
                store.updateMaxLoadWeight(weight);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showLoadVolumeDialog(BuildContext context) {
    final controller = TextEditingController(text: vehicleDetails.maxLoadVolume.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Edit Max Load Volume',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: const InputDecoration(
            hintText: 'Enter volume in liters',
            hintStyle: TextStyle(color: AppTheme.textTertiary),
            suffixText: 'L',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final volume = int.tryParse(controller.text);
              if (volume != null && volume > 0) {
                store.updateMaxLoadVolume(volume);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showRegistrationDateDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: vehicleDetails.registrationExpiryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    ).then((date) {
      if (date != null) {
        store.updateRegistrationExpiryDate(date);
      }
    });
  }

  void _showInsuranceDateDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: vehicleDetails.insuranceExpiryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    ).then((date) {
      if (date != null) {
        store.updateInsuranceExpiryDate(date);
      }
    });
  }

  void _showMaterialCompatibilityDialog(BuildContext context) {
    final selectedMaterials = List<vehicle.MaterialType>.from(vehicleDetails.materialCompatibility);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Material Compatibility',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Wrap(
            spacing: AppTheme.spacing8,
            runSpacing: AppTheme.spacing8,
            children: vehicle.MaterialType.values.map((material) {
              final isSelected = selectedMaterials.contains(material);
              return FilterChip(
                label: Text(
                  material.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    selectedMaterials.add(material);
                  } else {
                    selectedMaterials.remove(material);
                  }
                },
                backgroundColor: AppTheme.surfaceColor,
                selectedColor: AppTheme.primaryGreen,
                checkmarkColor: Colors.white,
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              store.updateMaterialCompatibility(selectedMaterials);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionDialog<T>(
    BuildContext context,
    String title,
    List<T> items,
    T currentValue,
    Function(T) onSelected,
  ) {
    return AlertDialog(
      backgroundColor: AppTheme.cardBackground,
      title: Text(
        title,
        style: const TextStyle(color: AppTheme.textPrimary),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) {
            final isSelected = item == currentValue;
            return ListTile(
              title: Text(
                item.toString(),
                style: const TextStyle(color: AppTheme.textPrimary),
              ),
              trailing: isSelected
                  ? Icon(Icons.check, color: AppTheme.primaryGreen)
                  : null,
              onTap: () => onSelected(item),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
