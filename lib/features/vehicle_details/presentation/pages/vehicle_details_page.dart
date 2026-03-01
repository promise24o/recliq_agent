import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/pages/vehicle_verification_info_page.dart' show VehicleRequirementsPage;
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/add_vehicle_bottom_sheet.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_content_section.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_create_form.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_error_state.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/widgets/vehicle_not_found_state.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class VehicleDetailsPage extends StatefulWidget {
  const VehicleDetailsPage({super.key});

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> with WidgetsBindingObserver {
  final _store = getIt<VehicleDetailsStore>();
  final _scrollController = ScrollController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _store.loadVehicleDetails();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh data when app is resumed (after returning from upload)
      _store.loadVehicleDetails();
    }
  }

  Future<void> _handleRefresh() async {
    await _store.loadVehicleDetails();
  }

  Future<void> _handleSave() async {
    if (_store.vehicleDetails == null) return;

    final request = vehicle.UpdateVehicleRequest(
      vehicleType: _store.vehicleDetails!.vehicleType,
      maxLoadWeight: _store.vehicleDetails!.maxLoadWeight,
      maxLoadVolume: _store.vehicleDetails!.maxLoadVolume,
      materialCompatibility: _store.vehicleDetails!.materialCompatibility,
      plateNumber: _store.vehicleDetails!.plateNumber,
      vehicleColor: _store.vehicleDetails!.vehicleColor,
      registrationExpiryDate: _store.vehicleDetails!.registrationExpiryDate,
      insuranceExpiryDate: _store.vehicleDetails!.insuranceExpiryDate,
      fuelType: _store.vehicleDetails!.fuelType,
    );

    final success = await _store.updateVehicleDetails(request);
    if (success && mounted) {
      setState(() => _isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.successMessage ?? 'Vehicle details updated successfully'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    } else if (_store.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.errorMessage!),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: RecliqAppBar(
        title: 'Vehicle Details',
        showNotifications: true,
        showBackButton: true,
      ),
      body: Observer(
        builder: (context) {
          return LoadingOverlay(
            isVisible: _store.isLoading && _store.vehicleDetails == null,
            message: 'Loading vehicle details...',
            child: SizedBox.expand(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: AppTheme.primaryGreen,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  child: _buildBody(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    
    if (_store.errorMessage != null && 
        _store.errorMessage!.isNotEmpty && 
        _store.vehicleDetails == null) {
      return _buildErrorState();
    }

    // if (_store.vehicleDetails == null) {
    //   return _buildCreateVehicleForm();
    // }

    return VehicleContentSection(
      store: _store,
      isEditing: _isEditing,
      onSave: _handleSave,
      onCancel: () => setState(() => _isEditing = false),
      onEdit: () => setState(() => _isEditing = true),
      onRefresh: _handleRefresh,
    );
  }

  Widget _buildErrorState() {
    final isVehicleNotFound = _store.errorMessage?.toLowerCase().contains('no vehicle details found') == true ||
                              _store.errorMessage?.toLowerCase().contains('not found') == true;
    
    if (isVehicleNotFound) {
      return _buildVehicleNotFoundState();
    }

    return VehicleErrorState(
      errorMessage: _store.errorMessage ?? 'Unable to load vehicle details',
      onRetry: _handleRefresh,
    );
  }

  Widget _buildVehicleNotFoundState() {
    return VehicleNotFoundState(
      onAddVehicle: _showAddVehicleBottomSheet,
      onLearnMore: _navigateToVerificationInfo,
    );
  }

  Widget _buildCreateVehicleForm() {
    return VehicleCreateForm(
      store: _store,
      onSubmit: _handleCreateVehicle,
    );
  }

  void _showAddVehicleBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddVehicleBottomSheet(),
    );
  }

  void _navigateToVerificationInfo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VehicleRequirementsPage(),
      ),
    );
  }

  Future<void> _handleCreateVehicle(vehicle.CreateVehicleRequest request) async {
    try {
      final success = await _store.createVehicleDetails(request);
      if (success && mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_store.successMessage ?? 'Vehicle details created successfully'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_store.errorMessage!),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }
}
