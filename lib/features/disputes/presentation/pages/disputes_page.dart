import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/empty_state.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';
import 'package:recliq_agent/shared/widgets/status_badge.dart';

class DisputesPage extends StatelessWidget {
  const DisputesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk & Compliance'),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAccountStatus(),
              const SizedBox(height: AppTheme.spacing20),
              _buildKycProgress(),
              const SizedBox(height: AppTheme.spacing20),
              _buildDisputesList(),
              const SizedBox(height: AppTheme.spacing20),
              _buildFraudWarnings(),
              const SizedBox(height: AppTheme.spacing20),
              _buildAuditLog(),
              const SizedBox(height: AppTheme.spacing24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountStatus() {
    return GlassCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
            child: const Icon(
              Icons.verified_user,
              color: AppTheme.successColor,
              size: 28,
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Status',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Active & Verified',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.successColor,
                  ),
                ),
              ],
            ),
          ),
          StatusBadge.completed(),
        ],
      ),
    );
  }

  Widget _buildKycProgress() {
    final kycItems = [
      {'name': 'Identity Verification', 'status': 'completed'},
      {'name': 'Address Verification', 'status': 'completed'},
      {'name': 'Business Registration', 'status': 'pending'},
      {'name': 'Bank Account Verification', 'status': 'completed'},
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'KYC Progress',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          const Text(
            '3 of 4 completed',
            style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.75,
              minHeight: 8,
              backgroundColor: AppTheme.dividerColor,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...kycItems.map((item) {
            final isCompleted = item['status'] == 'completed';
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
              child: Row(
                children: [
                  Icon(
                    isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isCompleted ? AppTheme.successColor : AppTheme.textTertiary,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      item['name']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: isCompleted
                            ? AppTheme.textPrimary
                            : AppTheme.textTertiary,
                      ),
                    ),
                  ),
                  Text(
                    isCompleted ? 'Done' : 'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isCompleted
                          ? AppTheme.successColor
                          : AppTheme.warningColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDisputesList() {
    final disputes = [
      {
        'id': 'DSP-001',
        'title': 'Weight discrepancy',
        'status': 'resolved',
        'date': 'Feb 15, 2025',
        'description': 'Customer claimed 30kg but actual was 25kg',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Disputes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        if (disputes.isEmpty)
          const NoDataEmptyState(
            title: 'No Disputes',
            description: 'You have no active disputes',
          )
        else
          ...disputes.map((d) => GlassCard(
                margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          d['id']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textTertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        StatusBadge(
                          label: d['status']!.replaceFirst(
                              d['status']![0], d['status']![0].toUpperCase()),
                          color: d['status'] == 'resolved'
                              ? AppTheme.successColor
                              : AppTheme.warningColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Text(
                      d['title']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      d['description']!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Text(
                      d['date']!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              )),
      ],
    );
  }

  Widget _buildFraudWarnings() {
    return GlassCard(
      backgroundColor: AppTheme.successColor.withValues(alpha: 0.05),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing8),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
            ),
            child: const Icon(
              Icons.shield,
              color: AppTheme.successColor,
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No Fraud Warnings',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.successColor,
                  ),
                ),
                Text(
                  'Your account is in good standing',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLog() {
    final logs = [
      {'action': 'Login', 'time': '10:30 AM', 'ip': '192.168.1.1'},
      {'action': 'Job Completed', 'time': '09:45 AM', 'ip': '192.168.1.1'},
      {'action': 'Withdrawal Request', 'time': '08:00 AM', 'ip': '192.168.1.1'},
      {'action': 'Profile Updated', 'time': 'Yesterday', 'ip': '192.168.1.1'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Audit Log',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        ...logs.map((log) => Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.history,
                      size: 16, color: AppTheme.textTertiary),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      log['action']!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    log['time']!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
