import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/utils/currency_formatter.dart';
import 'package:recliq_agent/core/utils/date_formatter.dart';
import 'package:recliq_agent/features/wallet/presentation/mobx/wallet_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';
import 'package:recliq_agent/shared/widgets/shimmer_loading.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with SingleTickerProviderStateMixin {
  final _walletStore = getIt<WalletStore>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _walletStore.loadAll();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: Observer(
          builder: (_) {
            if (_walletStore.isLoading && _walletStore.walletData == null) {
              return const _WalletShimmer();
            }
            return RefreshIndicator(
              onRefresh: _walletStore.loadAll,
              color: AppTheme.primaryGreen,
              backgroundColor: AppTheme.cardBackground,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppTheme.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBalanceOverview(),
                    const SizedBox(height: AppTheme.spacing20),
                    _buildFloatIndicator(),
                    const SizedBox(height: AppTheme.spacing20),
                    _buildCommissionCard(),
                    const SizedBox(height: AppTheme.spacing20),
                    _buildWithdrawButtons(),
                    const SizedBox(height: AppTheme.spacing20),
                    _buildTransactionHistory(),
                    const SizedBox(height: AppTheme.spacing24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBalanceOverview() {
    return Observer(
      builder: (_) {
        final data = _walletStore.walletData;
        return GlassCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Balance',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: AppTheme.spacing4),
              Text(
                CurrencyFormatter.format(data?.availableBalance ?? 0),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              Row(
                children: [
                  Expanded(
                    child: _buildMiniBalance(
                      'Pending',
                      CurrencyFormatter.format(data?.pendingBalance ?? 0),
                      AppTheme.warningColor,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildMiniBalance(
                      'Commission',
                      CurrencyFormatter.format(data?.commissionBalance ?? 0),
                      AppTheme.primaryGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMiniBalance(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: color)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatIndicator() {
    return Observer(
      builder: (_) {
        final data = _walletStore.walletData;
        final isSufficient = data?.isFloatSufficient ?? true;
        return GlassCard(
          backgroundColor: isSufficient
              ? AppTheme.successColor.withValues(alpha: 0.1)
              : AppTheme.errorColor.withValues(alpha: 0.1),
          child: Row(
            children: [
              Icon(
                isSufficient ? Icons.check_circle : Icons.warning,
                color: isSufficient ? AppTheme.successColor : AppTheme.errorColor,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSufficient ? 'Float Sufficient' : 'Low Float Warning',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSufficient ? AppTheme.successColor : AppTheme.errorColor,
                      ),
                    ),
                    Text(
                      'Min required: ${CurrencyFormatter.format(data?.minimumFloat ?? 0)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommissionCard() {
    return Observer(
      builder: (_) {
        final commission = _walletStore.commissionBreakdown;
        if (commission == null) return const SizedBox.shrink();
        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Commission Breakdown',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              _buildCommissionRow('Total Earned',
                  CurrencyFormatter.format(commission.totalEarned)),
              _buildCommissionRow('Total Deducted',
                  '-${CurrencyFormatter.format(commission.totalDeducted)}',
                  color: AppTheme.errorColor),
              _buildCommissionRow('Net Commission',
                  CurrencyFormatter.format(commission.netCommission),
                  color: AppTheme.successColor),
              const Divider(color: AppTheme.dividerColor),
              _buildCommissionRow('Commission Rate',
                  '${commission.commissionRate}%'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommissionRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color ?? AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showWithdrawSheet('bank'),
            icon: const Icon(Icons.account_balance, size: 18),
            label: const Text('To Bank'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius12),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showWithdrawSheet('mobile'),
            icon: const Icon(Icons.phone_android, size: 18),
            label: const Text('To Mobile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryGreen,
              side: const BorderSide(color: AppTheme.primaryGreen),
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionHistory() {
    return Observer(
      builder: (_) {
        final txns = _walletStore.transactions;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            if (txns.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spacing32),
                  child: Text(
                    'No transactions yet',
                    style: TextStyle(color: AppTheme.textTertiary),
                  ),
                ),
              )
            else
              ...txns.map((txn) => _buildTransactionItem(txn)),
          ],
        );
      },
    );
  }

  Widget _buildTransactionItem(dynamic txn) {
    final isCredit = txn.type == 'credit';
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing8),
            decoration: BoxDecoration(
              color: (isCredit ? AppTheme.successColor : AppTheme.errorColor)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? AppTheme.successColor : AppTheme.errorColor,
              size: 18,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormatter.formatRelative(DateTime.parse(txn.createdAt)),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : '-'}${CurrencyFormatter.format(txn.amount)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isCredit ? AppTheme.successColor : AppTheme.errorColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showWithdrawSheet(String method) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radius24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: AppTheme.spacing24,
          right: AppTheme.spacing24,
          top: AppTheme.spacing24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textTertiary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            Text(
              method == 'bank' ? 'Withdraw to Bank' : 'Withdraw to Mobile Money',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Available: ${CurrencyFormatter.format(_walletStore.walletData?.availableBalance ?? 0)}',
              style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: AppTheme.spacing24),
            const Center(
              child: Text(
                'Withdrawal feature coming soon',
                style: TextStyle(color: AppTheme.textTertiary, fontSize: 14),
              ),
            ),
            const SizedBox(height: AppTheme.spacing48),
          ],
        ),
      ),
    );
  }
}

class _WalletShimmer extends StatelessWidget {
  const _WalletShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        children: const [
          ShimmerCard(height: 160),
          SizedBox(height: AppTheme.spacing16),
          ShimmerCard(height: 60),
          SizedBox(height: AppTheme.spacing16),
          ShimmerCard(height: 140),
          SizedBox(height: AppTheme.spacing16),
          ShimmerCard(height: 60),
          SizedBox(height: AppTheme.spacing16),
          ShimmerList(itemCount: 4, itemHeight: 70),
        ],
      ),
    );
  }
}
