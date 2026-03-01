import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class VehicleNotFoundState extends StatelessWidget {
  final VoidCallback onAddVehicle;
  final VoidCallback onLearnMore;

  const VehicleNotFoundState({
    super.key,
    required this.onAddVehicle,
    required this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing20),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.no_crash_outlined,
                size: 56,
                color: AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            const Text(
              'No Vehicle Details Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            const Text(
              'Add your vehicle details to start receiving collection requests and build trust with clients.',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing32),
            
            // Benefits section
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(AppTheme.radius16),
                border: Border.all(color: AppTheme.borderSoft),
              ),
              child: Column(
                children: [
                  const Text(
                    'Why Add Your Vehicle?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  _buildBenefitItem(
                    icon: Icons.trending_up_outlined,
                    title: 'More Jobs',
                    description: 'Get access to more collection requests',
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildBenefitItem(
                    icon: Icons.verified_outlined,
                    title: 'Build Trust',
                    description: 'Clients prefer verified vehicles',
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  _buildBenefitItem(
                    icon: Icons.payments_outlined,
                    title: 'Better Earnings',
                    description: 'Higher rates for verified vehicles',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing32),
            
            // Action buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAddVehicle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                    ),
                    child: const Text(
                      'Add Vehicle Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onLearnMore,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.borderSoft),
                      foregroundColor: AppTheme.textSecondary,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                    ),
                    child: const Text(
                      'Learn More About Verification',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radius8),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryGreen,
            size: 20,
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
