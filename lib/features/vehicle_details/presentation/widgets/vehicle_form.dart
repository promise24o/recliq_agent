import 'package:flutter/material.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/shared/themes/app_theme.dart';

class VehicleForm extends StatefulWidget {
  final Function(vehicle.CreateVehicleRequest) onSubmit;
  final bool isLoading;

  const VehicleForm({
    super.key,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _plateNumberController = TextEditingController();
  final _vehicleColorController = TextEditingController();
  final _maxLoadWeightController = TextEditingController();
  final _maxLoadVolumeController = TextEditingController();

  vehicle.VehicleType _selectedVehicleType = vehicle.VehicleType.mini_truck;
  vehicle.FuelType _selectedFuelType = vehicle.FuelType.diesel;
  DateTime _registrationExpiryDate = DateTime.now().add(const Duration(days: 365));
  DateTime _insuranceExpiryDate = DateTime.now().add(const Duration(days: 180));
  List<vehicle.MaterialType> _selectedMaterials = [vehicle.MaterialType.PET, vehicle.MaterialType.Plastic];

  @override
  void dispose() {
    _plateNumberController.dispose();
    _vehicleColorController.dispose();
    _maxLoadWeightController.dispose();
    _maxLoadVolumeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, DateTime initialDate, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final request = vehicle.CreateVehicleRequest(
        vehicleType: _selectedVehicleType,
        maxLoadWeight: int.parse(_maxLoadWeightController.text),
        maxLoadVolume: int.parse(_maxLoadVolumeController.text),
        materialCompatibility: _selectedMaterials,
        plateNumber: _plateNumberController.text.trim(),
        vehicleColor: _vehicleColorController.text.trim(),
        registrationExpiryDate: _registrationExpiryDate,
        insuranceExpiryDate: _insuranceExpiryDate,
        fuelType: _selectedFuelType,
      );
      widget.onSubmit(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vehicle Type
          _buildDropdownField(
            'Vehicle Type',
            _selectedVehicleType,
            vehicle.VehicleType.values,
            (value) => setState(() => _selectedVehicleType = value!),
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Plate Number
          _buildTextField(
            'Plate Number',
            'e.g., ABC-123-XYZ',
            _plateNumberController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter plate number';
              }
              return null;
            },
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Vehicle Color
          _buildTextField(
            'Vehicle Color',
            'e.g., Blue, Red, White',
            _vehicleColorController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter vehicle color';
              }
              return null;
            },
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Load Capacity Row
          Row(
            children: [
              Expanded(
                child: _buildNumberField(
                  'Max Load Weight (kg)',
                  '800',
                  _maxLoadWeightController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    final weight = int.tryParse(value);
                    if (weight == null || weight <= 0) {
                      return 'Invalid weight';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildNumberField(
                  'Max Load Volume (L)',
                  '1200',
                  _maxLoadVolumeController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    final volume = int.tryParse(value);
                    if (volume == null || volume <= 0) {
                      return 'Invalid volume';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Fuel Type
          _buildDropdownField(
            'Fuel Type',
            _selectedFuelType,
            vehicle.FuelType.values,
            (value) => setState(() => _selectedFuelType = value!),
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Material Compatibility
          _buildMaterialCompatibilityField(),
          const SizedBox(height: AppTheme.spacing16),

          // Registration Expiry Date
          _buildDateField(
            'Registration Expiry Date',
            _registrationExpiryDate,
            (date) => setState(() => _registrationExpiryDate = date),
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Insurance Expiry Date
          _buildDateField(
            'Insurance Expiry Date',
            _insuranceExpiryDate,
            (date) => setState(() => _insuranceExpiryDate = date),
          ),
          const SizedBox(height: AppTheme.spacing24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Add Vehicle'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        TextFormField(
          controller: controller,
          validator: validator,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppTheme.textTertiary),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberField(
    String label,
    String hint,
    TextEditingController controller, {
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppTheme.textTertiary),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField<T>(
    String label,
    T value,
    List<T> items,
    Function(T?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: AppTheme.textTertiary),
          ),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMaterialCompatibilityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Material Compatibility',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.radius12),
            border: Border.all(color: AppTheme.borderSoft),
          ),
          child: Wrap(
            spacing: AppTheme.spacing8,
            runSpacing: AppTheme.spacing8,
            children: vehicle.MaterialType.values.map((material) {
              final isSelected = _selectedMaterials.contains(material);
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
                  setState(() {
                    if (selected) {
                      _selectedMaterials.add(material);
                    } else {
                      _selectedMaterials.remove(material);
                    }
                  });
                },
                backgroundColor: AppTheme.cardBackground,
                selectedColor: AppTheme.primaryGreen,
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius20),
                  side: BorderSide(
                    color: isSelected ? AppTheme.primaryGreen : AppTheme.borderSoft,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(
    String label,
    DateTime date,
    Function(DateTime) onDateSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        InkWell(
          onTap: () => _selectDate(context, date, onDateSelected),
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              border: Border.all(color: AppTheme.borderSoft),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
