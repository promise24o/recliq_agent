import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/zones/presentation/mobx/service_radius_store.dart';
import 'package:recliq_agent/features/zones/presentation/widgets/operational_impact_card.dart';
import 'package:recliq_agent/features/zones/presentation/widgets/radius_slider_card.dart';
import 'package:recliq_agent/features/zones/presentation/widgets/service_zones_card.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class ServiceRadiusPage extends StatefulWidget {
  const ServiceRadiusPage({super.key});

  @override
  State<ServiceRadiusPage> createState() => _ServiceRadiusPageState();
}

class _ServiceRadiusPageState extends State<ServiceRadiusPage> {
  final _store = getIt<ServiceRadiusStore>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _store.loadServiceRadius(),
      _store.loadCities(),
    ]);
  }

  Future<void> _handleSave() async {
    final success = await _store.updateServiceRadius();
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.successMessage ?? 'Service radius updated'),
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
      appBar: PageAppBar(
        title: 'Service Radius',
      ),
      body: Observer(
        builder: (_) {
          return LoadingOverlay(
            isVisible: _store.isLoading && _store.serviceRadius == null,
            message: 'Loading service radius...',
            child: RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    RadiusSliderCard(store: _store),
                    const SizedBox(height: 16),
                    ServiceZonesCard(store: _store),
                    const SizedBox(height: 16),
                    _buildAutoAdjustOptions(),
                    const SizedBox(height: 16),
                    if (_store.serviceRadius != null)
                      OperationalImpactCard(serviceRadius: _store.serviceRadius!),
                    if (_store.hasLargeRadius) ...[
                      const SizedBox(height: 16),
                      _buildWarningCard(),
                    ],
                    const SizedBox(height: 24),
                    _buildSaveButton(),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set Your Working Area',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Define how far you\'re willing to travel to accept jobs',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAutoAdjustOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Auto-Adjust Options',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Observer(
            builder: (_) => CheckboxListTile(
              value: _store.autoExpandRadius,
              onChanged: (value) {
                if (value != null) {
                  _store.setAutoExpandRadius(value);
                }
              },
              title: const Text(
                'Auto-expand radius when demand is low',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
              activeColor: AppTheme.primaryGreen,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          Observer(
            builder: (_) => CheckboxListTile(
              value: _store.restrictDuringPeakHours,
              onChanged: (value) {
                if (value != null) {
                  _store.setRestrictDuringPeakHours(value);
                }
              },
              title: const Text(
                'Restrict radius during peak hours',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
              activeColor: AppTheme.primaryGreen,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_rounded,
            color: Colors.orange,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Observer(
              builder: (_) => Text(
                _store.radiusWarning,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: Observer(
        builder: (_) => ElevatedButton(
          onPressed: _store.isLoading ? null : _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _store.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
