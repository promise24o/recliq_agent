import 'package:flutter/material.dart';
import 'package:recliq_agent/core/utils/currency_formatter.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights & Analytics'),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWeeklyEarnings(),
              const SizedBox(height: AppTheme.spacing20),
              _buildMaterialBreakdown(),
              const SizedBox(height: AppTheme.spacing20),
              _buildBestZones(),
              const SizedBox(height: AppTheme.spacing20),
              _buildPeakHours(),
              const SizedBox(height: AppTheme.spacing20),
              _buildCommissionImpact(),
              const SizedBox(height: AppTheme.spacing24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyEarnings() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final earnings = [12500.0, 18000.0, 15000.0, 22000.0, 19500.0, 25000.0, 8000.0];
    final maxEarning = earnings.reduce((a, b) => a > b ? a : b);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weekly Earnings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                CurrencyFormatter.formatCompact(
                    earnings.reduce((a, b) => a + b)),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing20),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final ratio = earnings[index] / maxEarning;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          CurrencyFormatter.formatCompact(earnings[index]),
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 100 * ratio,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryGreen.withValues(alpha: 0.3),
                                AppTheme.primaryGreen,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          days[index],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialBreakdown() {
    final materials = [
      {'name': 'PET Bottles', 'amount': 45000.0, 'kg': 300.0, 'rate': 150.0},
      {'name': 'Aluminum', 'amount': 60000.0, 'kg': 200.0, 'rate': 300.0},
      {'name': 'Cardboard', 'amount': 15000.0, 'kg': 300.0, 'rate': 50.0},
      {'name': 'E-Waste', 'amount': 80000.0, 'kg': 100.0, 'rate': 800.0},
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Material Profitability',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...materials.map((m) => _buildMaterialRow(
                m['name'] as String,
                m['amount'] as double,
                m['kg'] as double,
                m['rate'] as double,
              )),
        ],
      ),
    );
  }

  Widget _buildMaterialRow(
      String name, double amount, double kg, double rate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '${kg.toStringAsFixed(0)} kg | ${CurrencyFormatter.format(rate)}/kg',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.format(amount),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestZones() {
    final zones = [
      {'zone': 'Lekki Phase 1', 'earnings': 85000.0, 'jobs': 24},
      {'zone': 'Victoria Island', 'earnings': 72000.0, 'jobs': 18},
      {'zone': 'Ikeja GRA', 'earnings': 55000.0, 'jobs': 15},
      {'zone': 'Surulere', 'earnings': 42000.0, 'jobs': 12},
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Best Zones',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...zones.asMap().entries.map((entry) {
            final zone = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: Center(
                      child: Text(
                        '#${entry.key + 1}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          zone['zone'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          '${zone['jobs']} jobs completed',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    CurrencyFormatter.format(zone['earnings'] as double),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
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

  Widget _buildPeakHours() {
    final hours = [
      {'time': '8AM - 10AM', 'level': 0.9, 'label': 'Peak'},
      {'time': '10AM - 12PM', 'level': 0.7, 'label': 'High'},
      {'time': '12PM - 2PM', 'level': 0.4, 'label': 'Medium'},
      {'time': '2PM - 4PM', 'level': 0.6, 'label': 'Medium'},
      {'time': '4PM - 6PM', 'level': 0.85, 'label': 'Peak'},
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Peak Earning Hours',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...hours.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        h['time'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: h['level'] as double,
                          minHeight: 8,
                          backgroundColor: AppTheme.dividerColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            (h['level'] as double) > 0.7
                                ? AppTheme.primaryGreen
                                : AppTheme.warningColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Text(
                      h['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: (h['level'] as double) > 0.7
                            ? AppTheme.primaryGreen
                            : AppTheme.warningColor,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCommissionImpact() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Commission Impact Report',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          _buildImpactRow('Gross Earnings', CurrencyFormatter.format(450000)),
          _buildImpactRow('Commission (15%)', '-${CurrencyFormatter.format(67500)}',
              color: AppTheme.errorColor),
          const Divider(color: AppTheme.dividerColor),
          _buildImpactRow('Net Earnings', CurrencyFormatter.format(382500),
              color: AppTheme.successColor, isBold: true),
          const SizedBox(height: AppTheme.spacing12),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: AppTheme.infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppTheme.infoColor, size: 16),
                SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: Text(
                    'Upgrade to Gold tier to reduce commission to 10%',
                    style: TextStyle(fontSize: 12, color: AppTheme.infoColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactRow(String label, String value,
      {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
              )),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              color: color ?? AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
