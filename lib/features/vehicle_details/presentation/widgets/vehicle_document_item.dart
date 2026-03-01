import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/shared/themes/app_theme.dart';

class VehicleDocumentItem extends StatelessWidget {
  final vehicle.VehicleDocument document;

  const VehicleDocumentItem({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDocumentBottomSheet(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(color: AppTheme.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing8),
              decoration: BoxDecoration(
                color: _getDocumentStatusColor(document.status).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Icon(
                _getDocumentIcon(document.documentType),
                color: _getDocumentStatusColor(document.status),
                size: 20,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getDocumentDisplayName(document.documentType),
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    'Uploaded ${_formatDate(document.uploadedAt)}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing8,
                vertical: AppTheme.spacing4,
              ),
              decoration: BoxDecoration(
                color: _getDocumentStatusColor(document.status).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radius12),
              ),
              child: Text(
                document.status.toString().split('.').last.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _getDocumentStatusColor(document.status),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacing8),
            Icon(
              Icons.open_in_new_outlined,
              color: AppTheme.textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Color _getDocumentStatusColor(vehicle.DocumentStatus status) {
    switch (status) {
      case vehicle.DocumentStatus.verified:
        return AppTheme.successColor;
      case vehicle.DocumentStatus.pending:
        return AppTheme.warningColor;
      case vehicle.DocumentStatus.rejected:
        return AppTheme.errorColor;
    }
  }

  IconData _getDocumentIcon(vehicle.DocumentType type) {
    switch (type) {
      case vehicle.DocumentType.registration:
        return Icons.description_outlined;
      case vehicle.DocumentType.insurance:
        return Icons.security_outlined;
      case vehicle.DocumentType.roadworthiness:
        return Icons.eco_outlined;
      case vehicle.DocumentType.inspection_certificate:
        return Icons.fact_check_outlined;
    }
  }

  String _getDocumentDisplayName(vehicle.DocumentType type) {
    switch (type) {
      case vehicle.DocumentType.registration:
        return 'Vehicle Registration';
      case vehicle.DocumentType.insurance:
        return 'Vehicle Insurance';
      case vehicle.DocumentType.roadworthiness:
        return 'Roadworthiness Certificate';
      case vehicle.DocumentType.inspection_certificate:
        return 'Inspection Certificate';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showDocumentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.darkBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radius20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.borderSoft,
                borderRadius: BorderRadius.circular(AppTheme.radius4),
              ),
            ),
            const SizedBox(height: AppTheme.spacing20),
            
            // Document icon and title
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing20),
              decoration: BoxDecoration(
                color: _getDocumentStatusColor(document.status).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getDocumentIcon(document.documentType),
                color: _getDocumentStatusColor(document.status),
                size: 32,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Document name
            Text(
              _getDocumentDisplayName(document.documentType),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            
            // Status
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing12,
                vertical: AppTheme.spacing6,
              ),
              decoration: BoxDecoration(
                color: _getDocumentStatusColor(document.status).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radius20),
              ),
              child: Text(
                document.status.toString().split('.').last.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _getDocumentStatusColor(document.status),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            // Document Image - Full Width
            Container(
              width: double.infinity,
              height: 250,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radius12),
                ),
                child: Image.network(
                  document.documentUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      color: AppTheme.surfaceColor,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image_outlined,
                            size: 48,
                            color: AppTheme.textTertiary,
                          ),
                          SizedBox(height: AppTheme.spacing8),
                          Text(
                            'Failed to load image',
                            style: TextStyle(
                              color: AppTheme.textTertiary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      color: AppTheme.surfaceColor,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            // Document details - Make scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing20),
                child: Column(
                  children: [
                    _buildDetailRow(
                      'Document Type',
                      _getDocumentDisplayName(document.documentType),
                      Icons.description_outlined,
                    ),
                    _buildDetailRow(
                      'Status',
                      document.status.toString().split('.').last.toUpperCase(),
                      _getStatusIcon(document.status),
                      valueColor: _getDocumentStatusColor(document.status),
                    ),
                    _buildDetailRow(
                      'Uploaded',
                      _formatFullDate(document.uploadedAt),
                      Icons.upload_outlined,
                    ),
                    if (document.verifiedAt != null)
                      _buildDetailRow(
                        'Verified',
                        _formatFullDate(document.verifiedAt!),
                        Icons.verified_outlined,
                        valueColor: AppTheme.successColor,
                      ),
                    if (document.rejectionReason != null) ...[
                      _buildRejectionReason(),                     
                    ],
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon, {
    bool isUrl = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing16),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.textTertiary,
            size: 20,
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: AppTheme.spacing2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUrl 
                        ? AppTheme.primaryGreen 
                        : (valueColor ?? AppTheme.textPrimary),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (isUrl)
            Icon(
              Icons.open_in_new,
              color: AppTheme.primaryGreen,
              size: 16,
            ),
        ],
      ),
    );
  }

  Widget _buildRejectionReason() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.errorColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: AppTheme.errorColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: AppTheme.errorColor,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              const Text(
                'Rejection Reason',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.errorColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            document.rejectionReason!,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(vehicle.DocumentStatus status) {
    switch (status) {
      case vehicle.DocumentStatus.verified:
        return Icons.verified_outlined;
      case vehicle.DocumentStatus.pending:
        return Icons.pending_outlined;
      case vehicle.DocumentStatus.rejected:
        return Icons.error_outline;
    }
  }

  String _formatFullDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _extractDocumentId(String url) {
    // Extract filename from URL for document ID
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.isNotEmpty) {
      return segments.last;
    }
    return 'Unknown';
  }
}
