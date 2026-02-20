import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/utils/currency_formatter.dart';
import 'package:recliq_agent/features/performance/presentation/mobx/performance_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';
import 'package:recliq_agent/shared/widgets/shimmer_loading.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  final _store = getIt<PerformanceStore>();

  @override
  void initState() {
    super.initState();
    _store.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance'),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: Observer(
          builder: (_) {
            if (_store.isLoading && _store.performanceData == null) {
              return const ShimmerList(itemCount: 5, itemHeight: 100);
            }
            return RefreshIndicator(
              onRefresh: _store.loadAll,
              color: AppTheme.primaryGreen,
              backgroundColor: AppTheme.cardBackground,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppTheme.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildScoreCard(),
                    const SizedBox(height: AppTheme.spacing20),
                    _buildMetricsGrid(),
                    const SizedBox(height: AppTheme.spacing20),
                    _buildRankSection(),
                    const SizedBox(height: AppTheme.spacing20),
                    _buildRankTiers(),
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

  Widget _buildScoreCard() {
    return Observer(
      builder: (_) {
        final data = _store.performanceData;
        return GlassCard(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: CircularProgressIndicator(
                        value: (data?.performanceScore ?? 0) / 100,
                        strokeWidth: 10,
                        backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getScoreColor(data?.performanceScore ?? 0),
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(data?.performanceScore ?? 0).toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const Text(
                          'Score',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              Text(
                'Rank: ${data?.rankTier ?? 'Bronze'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _getRankColor(data?.rankTier ?? 'Bronze'),
                ),
              ),
              if (data != null)
                Text(
                  '#${data.rankPosition} of ${data.totalAgents} agents',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricsGrid() {
    return Observer(
      builder: (_) {
        final data = _store.performanceData;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Metrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppTheme.spacing12,
              mainAxisSpacing: AppTheme.spacing12,
              childAspectRatio: 1.6,
              children: [
                _buildMetricTile('Pickups', '${data?.pickupsCompleted ?? 0}',
                    Icons.local_shipping, AppTheme.primaryGreen),
                _buildMetricTile('Avg Response', '${data?.avgResponseTime ?? 0} min',
                    Icons.speed, AppTheme.infoColor),
                _buildMetricTile('Completion', '${data?.completionRate ?? 0}%',
                    Icons.check_circle, AppTheme.successColor),
                _buildMetricTile('Disputes', '${data?.disputeRate ?? 0}%',
                    Icons.warning, AppTheme.warningColor),
                _buildMetricTile('SLA', '${data?.slaAdherence ?? 0}%',
                    Icons.timer, AppTheme.infoColor),
                _buildMetricTile('Avg Earning',
                    CurrencyFormatter.formatCompact(data?.earningsPerJob ?? 0),
                    Icons.attach_money, AppTheme.successColor),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricTile(String label, String value, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildRankSection() {
    return Observer(
      builder: (_) {
        final data = _store.performanceData;
        if (data == null) return const SizedBox.shrink();
        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rank Progress',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                child: LinearProgressIndicator(
                  value: data.performanceScore / 100,
                  minHeight: 12,
                  backgroundColor: AppTheme.dividerColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getScoreColor(data.performanceScore),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.rankTier,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getRankColor(data.rankTier),
                    ),
                  ),
                  Text(
                    _getNextRank(data.rankTier),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getRankColor(_getNextRank(data.rankTier)),
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

  Widget _buildRankTiers() {
    return Observer(
      builder: (_) {
        final tiers = _store.rankTiers;
        if (tiers.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rank Tiers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            ...tiers.map((tier) => _buildTierCard(tier)),
          ],
        );
      },
    );
  }

  Widget _buildTierCard(dynamic tier) {
    final isCurrentTier = _store.performanceData?.rankTier == tier.name;
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: isCurrentTier
            ? _getRankColor(tier.name).withValues(alpha: 0.15)
            : AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: isCurrentTier
            ? Border.all(color: _getRankColor(tier.name).withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getRankColor(tier.name).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
            ),
            child: Icon(
              Icons.military_tech,
              color: _getRankColor(tier.name),
              size: 22,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      tier.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _getRankColor(tier.name),
                      ),
                    ),
                    if (isCurrentTier) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  'Commission: ${tier.commissionRate}% | Min Score: ${tier.minScore}',
                  style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
                if (tier.bonusDescription != null)
                  Text(
                    tier.bonusDescription!,
                    style: const TextStyle(fontSize: 11, color: AppTheme.primaryGreen),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return AppTheme.successColor;
    if (score >= 70) return AppTheme.primaryGreen;
    if (score >= 50) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }

  Color _getRankColor(String rank) {
    switch (rank.toLowerCase()) {
      case 'bronze':
        return AppTheme.bronzeColor;
      case 'silver':
        return AppTheme.silverColor;
      case 'gold':
        return AppTheme.goldColor;
      case 'platinum':
        return AppTheme.platinumColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getNextRank(String current) {
    switch (current.toLowerCase()) {
      case 'bronze':
        return 'Silver';
      case 'silver':
        return 'Gold';
      case 'gold':
        return 'Platinum';
      default:
        return 'Platinum';
    }
  }
}
