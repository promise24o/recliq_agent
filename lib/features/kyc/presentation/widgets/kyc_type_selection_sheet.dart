import 'package:flutter/material.dart';
import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../../domain/entities/kyc_status.dart';

class KycTypeSelectionSheet extends StatefulWidget {
  final Function(KycUserType) onTypeSelected;

  const KycTypeSelectionSheet({
    super.key,
    required this.onTypeSelected,
  });

  @override
  State<KycTypeSelectionSheet> createState() => _KycTypeSelectionSheetState();
}

class _KycTypeSelectionSheetState extends State<KycTypeSelectionSheet> {
  bool _isLoading = false;

  Future<void> _handleTypeSelection(KycUserType userType) async {
    setState(() {
      _isLoading = true;
    });

    try {
      Navigator.pop(context);
      await widget.onTypeSelected(userType);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isVisible: _isLoading,
      message: 'Initializing KYC...',
      child: Container(
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
              const SizedBox(height: AppTheme.spacing24),

              // Header
              const Text(
                'Select KYC Type',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              const Text(
                'Complete your agent verification to unlock all features',
                style: TextStyle(
                  color: AppTheme.textTertiary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: AppTheme.spacing24),

              // Agent option only
              _buildTypeOption(
                context,
                icon: Icons.support_agent,
                title: 'Agent',
                description: 'For agent accounts - Verify with BVN and documents',
                userType: KycUserType.agent,
                color: AppTheme.primaryGreen,
              ),
              const SizedBox(height: AppTheme.spacing16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required KycUserType userType,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _handleTypeSelection(userType),
      borderRadius: BorderRadius.circular(AppTheme.radius12),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: AppTheme.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing8),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
