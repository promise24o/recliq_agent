import 'package:flutter/material.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class RemoveBankBottomSheet extends StatelessWidget {
  final BankAccount account;
  final VoidCallback onConfirm;

  const RemoveBankBottomSheet({
    super.key,
    required this.account,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppTheme.spacing24,
          right: AppTheme.spacing24,
          top: AppTheme.spacing24,
          bottom: AppTheme.spacing24 + 80, // Extra space for floating nav
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: AppTheme.spacing20),
            
            // Icon
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: AppTheme.errorColor,
                size: 32,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Title
            const Text(
              'Remove Bank Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            
            // Description
            Text(
              'Are you sure you want to remove ${account.bankName}?\nThis action cannot be undone.',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            // Account details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(AppTheme.radius12),
                border: Border.all(color: AppTheme.borderSoft),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.accountName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${account.bankName} • ${_maskAccountNumber(account.accountNumber)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            // Warning message
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                border: Border.all(
                  color: AppTheme.errorColor.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppTheme.errorColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Removing this account will unlink it from your wallet. Any pending transactions will be affected.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.errorColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.dividerColor),
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppTheme.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Text(
                      'Remove',
                      style: TextStyle(fontWeight: FontWeight.w600),
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

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    final masked = '*' * (accountNumber.length - 4);
    return masked + accountNumber.substring(accountNumber.length - 4);
  }

  static Future<bool?> show({
    required BuildContext context,
    required BankAccount account,
    required VoidCallback onConfirm,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius20),
        ),
      ),
      builder: (context) => RemoveBankBottomSheet(
        account: account,
        onConfirm: onConfirm,
      ),
    );
  }
}
