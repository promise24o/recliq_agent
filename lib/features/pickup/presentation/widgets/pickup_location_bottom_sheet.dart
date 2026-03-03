import 'package:flutter/material.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/pickup_location_map.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class PickupLocationBottomSheet extends StatelessWidget {
  final PickupRequest pickup;

  const PickupLocationBottomSheet({
    super.key,
    required this.pickup,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.darkBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.borderSoft,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pickup Location',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          if (pickup.address != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              pickup.address!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.borderSoft,
                        foregroundColor: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Map
              Expanded(
                child: PickupLocationMap(pickup: pickup),
              ),

              // Bottom padding
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  static void show(BuildContext context, PickupRequest pickup) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PickupLocationBottomSheet(pickup: pickup),
    );
  }
}
