import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';
import 'package:recliq_agent/features/wallet/presentation/mobx/wallet_store.dart';
import 'package:recliq_agent/features/wallet/presentation/widgets/bank_account_tile.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/empty_state.dart';

class BankAccountsList extends StatelessWidget {
  final WalletStore walletStore;
  final VoidCallback onAddAccount;
  final Function(BankAccount) onSetDefault;
  final Function(BankAccount) onRemove;

  const BankAccountsList({
    super.key,
    required this.walletStore,
    required this.onAddAccount,
    required this.onSetDefault,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // if (walletStore.errorMessage != null) {
        //   return _buildErrorState();
        // }

        if (walletStore.bankAccounts.isEmpty) {
          return _buildEmptyState();
        }

        return _buildAccountsList();
      },
    );
  }

  Widget _buildAccountsList() {
    return RefreshIndicator(
      onRefresh: () async {
        await walletStore.loadBankAccounts();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // Enable pull-to-refresh
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8, top: 16),
            child: Text(
              'Linked Accounts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryGreen,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Important Information',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '• Your bank account is the only source for receiving funds from Recliq\n'
                    '• You cannot remove the default account. Add another account and set it as default first\n'
                    '• Keep your account details secure and never share with others',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Observer(
                    builder: (_) => Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: walletStore.isLoading ? null : onAddAccount,
                        icon: walletStore.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Add Bank Account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: walletStore.bankAccounts.length,
            itemBuilder: (context, index) {
              final account = walletStore.bankAccounts[index];
              return BankAccountListItem(
                account: account,
                onSetDefault: () => onSetDefault(account),
                onRemove: () => onRemove(account),
              );
            },
          ),
          const SizedBox(height: 100),
        ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ErrorEmptyState(
          error: 'Something went wrong',
          onRetry: () {
            walletStore.clearMessages();
            walletStore.loadBankData();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: NoDataEmptyState(
          title: 'No accounts yet',
          description: 'Link your bank account to start receiving payments',
          actionText: 'Add Bank Account',
          onAction: onAddAccount,
        ),
      ),
    );
  }
}

class BankAccountListItem extends StatelessWidget {
  final BankAccount account;
  final VoidCallback onSetDefault;
  final VoidCallback onRemove;

  const BankAccountListItem({
    super.key,
    required this.account,
    required this.onSetDefault,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BankAccountTile(
        account: account,
        onSetDefault: onSetDefault,
        onRemove: onRemove,
      ),
    );
  }
}
