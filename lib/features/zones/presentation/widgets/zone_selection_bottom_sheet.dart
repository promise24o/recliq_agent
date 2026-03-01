import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/zones/presentation/mobx/service_radius_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ZoneSelectionBottomSheet extends StatefulWidget {
  final ServiceRadiusStore store;

  const ZoneSelectionBottomSheet({
    super.key,
    required this.store,
  });

  @override
  State<ZoneSelectionBottomSheet> createState() => _ZoneSelectionBottomSheetState();
}

class _ZoneSelectionBottomSheetState extends State<ZoneSelectionBottomSheet> {
  @override
  void initState() {
    super.initState();
    if (widget.store.zones.isEmpty) {
      widget.store.loadZones();
    }
    if (widget.store.cities.isEmpty) {
      widget.store.loadCities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        decoration: const BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: AppTheme.spacing16,
            right: AppTheme.spacing16,
            top: AppTheme.spacing16,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 80,
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
                      color: AppTheme.primaryGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: AppTheme.primaryGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Select Service Zones',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'Choose zones you want to serve',
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

              // City Selector
              _buildCitySelector(),
              const SizedBox(height: AppTheme.spacing16),

              // Zones List
              Expanded(
                child: _buildZonesList(),
              ),

              // Footer
              const SizedBox(height: AppTheme.spacing16),
              _buildFooter(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCitySelector() {
    return Observer(
      builder: (_) {
        if (widget.store.cities.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.radius12),
            border: Border.all(color: AppTheme.borderSoft),
          ),
          child: DropdownButtonFormField<String?>(
            value: widget.store.selectedCity,
            decoration: InputDecoration(
              labelText: 'Filter by City',
              labelStyle: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              prefixIcon: const Icon(
                Icons.location_city_outlined,
                color: AppTheme.textSecondary,
                size: 20,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            dropdownColor: AppTheme.surfaceColor,
            items: [
              const DropdownMenuItem<String?>(
                value: null,
                child: Text(
                  'All Cities',
                  style: TextStyle(color: AppTheme.textPrimary),
                ),
              ),
              ...widget.store.cities.map(
                (city) => DropdownMenuItem<String?>(
                  value: city.name,
                  child: Text(
                    city.name,
                    style: const TextStyle(color: AppTheme.textPrimary),
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              widget.store.setSelectedCity(value);
            },
          ),
        );
      },
    );
  }

  Widget _buildZonesList() {
    return Observer(
      builder: (_) {
        if (widget.store.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryGreen,
            ),
          );
        }

        if (widget.store.zones.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(AppTheme.radius12),
                  ),
                  child: Icon(
                    Icons.location_off_outlined,
                    size: 48,
                    color: AppTheme.textTertiary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing16),
                const Text(
                  'No zones available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                const Text(
                  'Try selecting a different city',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.store.zones.length,
          itemBuilder: (context, index) {
            final zone = widget.store.zones[index];

            return Observer(
              builder: (_) {
                final isSelected = widget.store.selectedZoneIds.contains(zone.id);

                return Container(
                  margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGreen.withOpacity(0.1)
                        : AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(AppTheme.radius12),
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryGreen : AppTheme.borderSoft,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: (value) {
                      widget.store.toggleZoneSelection(zone.id);
                    },
                    title: Text(
                      zone.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppTheme.primaryGreen : AppTheme.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      '${zone.city}, ${zone.state}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    activeColor: AppTheme.primaryGreen,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing16,
                      vertical: AppTheme.spacing4,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFooter() {
    return Observer(
      builder: (_) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.store.selectedZoneIds.length} zone(s) selected',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  if (widget.store.selectedZoneIds.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    const Text(
                      'Ready to serve in selected areas',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing24,
                  vertical: AppTheme.spacing12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}