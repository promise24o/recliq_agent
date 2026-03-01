import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/availability/presentation/mobx/availability_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class OnlineStatusCard extends StatelessWidget {
  final AvailabilityStore store;

  const OnlineStatusCard({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (store.availability == null) return const SizedBox();

        final isOnline = store.availability!.isOnline;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isOnline ? AppTheme.primaryGreen : AppTheme.borderSoft,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isOnline
                    ? AppTheme.primaryGreen.withOpacity(0.2)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isOnline
                      ? AppTheme.primaryGreen.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isOnline ? Icons.check_circle : Icons.cancel,
                  color: isOnline ? AppTheme.primaryGreen : Colors.grey,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOnline ? 'You\'re Online' : 'You\'re Offline',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isOnline ? AppTheme.primaryGreen : AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isOnline
                          ? 'Available to receive job requests'
                          : 'Not accepting new jobs',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isOnline,
                onChanged: (_) => store.toggleOnlineStatus(),
                activeColor: AppTheme.primaryGreen,
              ),
            ],
          ),
        );
      },
    );
  }
}
