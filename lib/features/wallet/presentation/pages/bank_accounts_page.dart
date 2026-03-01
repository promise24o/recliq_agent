import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';
import 'package:recliq_agent/features/wallet/presentation/mobx/wallet_store.dart';
import 'package:recliq_agent/features/wallet/presentation/widgets/add_bank_bottom_sheet.dart';
import 'package:recliq_agent/features/wallet/presentation/widgets/bank_accounts_app_bar.dart';
import 'package:recliq_agent/features/wallet/presentation/widgets/bank_accounts_list.dart';
import 'package:recliq_agent/features/wallet/presentation/widgets/remove_bank_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class BankAccountsPage extends StatefulWidget {
  const BankAccountsPage({super.key});

  @override
  State<BankAccountsPage> createState() => _BankAccountsPageState();
}

class _BankAccountsPageState extends State<BankAccountsPage> {
  final _walletStore = getIt<WalletStore>();

  @override
  void initState() {
    super.initState();
    _walletStore.loadBankData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => LoadingOverlay(
        isVisible: _walletStore.isLoading,
        child: Scaffold(
          backgroundColor: AppTheme.darkBackground,
          appBar: BankAccountsAppBar(
            walletStore: _walletStore,
            onAddAccount: _showAddBankBottomSheet,
          ),
          body: BankAccountsList(
            walletStore: _walletStore,
            onAddAccount: _showAddBankBottomSheet,
            onSetDefault: (account) async {
              await _walletStore.setDefaultBankAccount(bankAccountId: account.id);
              if (_walletStore.successMessage != null && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_walletStore.successMessage!),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              }
            },
            onRemove: _showRemoveConfirmation,
          ),
        ),
      ),
    );
  }

  void _showRemoveConfirmation(BankAccount account) async {
    await RemoveBankBottomSheet.show(
      context: context,
      account: account,
      onConfirm: () async {
        final success = await _walletStore.removeBankAccount(bankAccountId: account.id);
        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bank account removed successfully'),
              backgroundColor: AppTheme.successColor,
            ),
          );
        } else if (!success && mounted) {
          // Show the specific error message from the API
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_walletStore.errorMessage ?? 'Failed to remove bank account'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      },
    );
  }

  void _showAddBankBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddBankBottomSheet(
        key: const Key('add_bank_bottom_sheet'),
        walletStore: _walletStore,
        onAccountAdded: () {
          _walletStore.loadBankData();
        },
      ),
    );
  }
}

class BankAccountTile extends StatefulWidget {
  final BankAccount account;
  final VoidCallback onSetDefault;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  const BankAccountTile({
    super.key,
    required this.account,
    required this.onSetDefault,
    required this.onRemove,
    this.onTap,
  });

  @override
  State<BankAccountTile> createState() => _BankAccountTileState();
}

class _BankAccountTileState extends State<BankAccountTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expand;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _expand = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      _expanded ? _controller.forward() : _controller.reverse();
    });
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final isDefault = widget.account.isDefault == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDefault ? AppTheme.primaryGreen : AppTheme.borderSoft,
          width: isDefault ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _toggle,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.account_balance_rounded,
                      size: 20,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.account.bankName,
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.account.accountName} • ${_maskAccountNumber(widget.account.accountNumber)}',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 260),
                    child: Icon(
                      Icons.expand_more,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _expand,
              builder: (_, child) {
                return ClipRect(
                  child: Align(
                    heightFactor: _expand.value,
                    alignment: Alignment.topCenter,
                    child: child,
                  ),
                );
              },
              child: _DetailsSection(
                account: widget.account,
                isDefault: isDefault,
                onSetDefault: widget.onSetDefault,
                onRemove: widget.onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return '*' * (accountNumber.length - 4) + accountNumber.substring(accountNumber.length - 4);
  }
}

class _DetailsSection extends StatelessWidget {
  final BankAccount account;
  final bool isDefault;
  final VoidCallback onSetDefault;
  final VoidCallback onRemove;

  const _DetailsSection({
    required this.account,
    required this.isDefault,
    required this.onSetDefault,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.borderSoft),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          _row('Account Number', account.accountNumber),
          _row('Bank Code', account.bankCode),
          _row('Type', account.type),
          _row('Added', _format(account.createdAt)),
          const SizedBox(height: 16),
          Row(
            children: [
              if (!isDefault)
                Expanded(
                  child: _ActionButton(
                    label: 'Set Default',
                    icon: Icons.star_outline,
                    color: AppTheme.primaryGreen,
                    onTap: onSetDefault,
                  ),
                ),
              if (!isDefault) const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  label: 'Remove',
                  icon: Icons.delete_outline,
                  color: AppTheme.errorColor,
                  onTap: onRemove,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _format(DateTime d) {
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final p = d.hour >= 12 ? 'PM' : 'AM';
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
        '${h.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')} $p';
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: color),
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color.withOpacity(0.6)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}