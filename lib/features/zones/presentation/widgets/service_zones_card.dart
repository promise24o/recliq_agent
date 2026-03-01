import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/zones/presentation/mobx/service_radius_store.dart';
import 'package:recliq_agent/features/zones/presentation/widgets/zone_selection_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ServiceZonesCard extends StatelessWidget {
  final ServiceRadiusStore store;

  const ServiceZonesCard({
    super.key,
    required this.store,
  });

  void _showZoneSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ZoneSelectionBottomSheet(store: store),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Service Zones',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              TextButton.icon(
                onPressed: () => _showZoneSelection(context),
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 18,
                ),
                label: const Text('Manage'),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Select specific zones you want to serve',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Observer(
            builder: (_) {
              if (store.selectedZones.isNotEmpty) {
                final totalArea = store.selectedZones
                    .where((zone) => zone.areaKm2 != null)
                    .map((zone) => zone.areaKm2!)
                    .fold(0.0, (sum, area) => sum + area);
                
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryGreen.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppTheme.primaryGreen,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${store.selectedZones.length} zone${store.selectedZones.length == 1 ? '' : 's'} selected',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryGreen,
                              ),
                            ),
                            if (totalArea > 0) ...[
                              const SizedBox(height: 2),
                              Text(
                                'Total coverage: ${totalArea.toStringAsFixed(1)} km²',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 12),
          Observer(
            builder: (_) {
              if (store.selectedZones.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_off_outlined,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'No zones selected. Tap "Manage" to add zones.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: store.selectedZones.map((zone) {
                  return Chip(
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          zone.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${zone.city}, ${zone.state}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        if (zone.areaKm2 != null) ...[
                          const SizedBox(height: 1),
                          Text(
                            '${zone.areaKm2?.toStringAsFixed(1)} km²',
                            style: const TextStyle(
                              fontSize: 9,
                              color: AppTheme.textTertiary,
                            ),
                          ),
                        ],
                      ],
                    ),
                    backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                    deleteIcon: const Icon(
                      Icons.close,
                      size: 16,
                    ),
                    onDeleted: () => store.toggleZoneSelection(zone.id),
                    side: BorderSide(
                      color: AppTheme.primaryGreen.withOpacity(0.3),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
