import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class EmptyStateWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Widget? action;
  final double? imageHeight;
  final double? imageWidth;

  const EmptyStateWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.action,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: imageHeight ?? 120,
              width: imageWidth ?? 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: imageHeight ?? 120,
                      width: imageWidth ?? 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorEmptyState extends StatelessWidget {
  final String? error;
  final VoidCallback? onRetry;

  const ErrorEmptyState({
    super.key,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      imagePath: 'assets/images/no-result.png',
      title: 'Something went wrong',
      description:
          error ?? 'An error occurred while loading data. Please try again.',
      action: onRetry != null
          ? ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          : null,
    );
  }
}

class NoDataEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onAction;
  final String? actionText;

  const NoDataEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      imagePath: 'assets/images/no-result.png',
      title: title,
      description: description,
      action: onAction != null
          ? ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(actionText ?? 'Try Again'),
            )
          : null,
    );
  }
}
