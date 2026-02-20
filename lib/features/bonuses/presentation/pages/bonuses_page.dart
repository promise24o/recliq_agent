import 'package:flutter/material.dart';
import 'package:recliq_agent/core/utils/currency_formatter.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';

class BonusesPage extends StatelessWidget {
  const BonusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incentives & Bonuses'),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStreakBonus(),
              const SizedBox(height: AppTheme.spacing20),
              _buildWeeklyTargets(),
              const SizedBox(height: AppTheme.spacing20),
              _buildMilestones(),
              const SizedBox(height: AppTheme.spacing20),
              _buildLeaderboard(),
              const SizedBox(height: AppTheme.spacing24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakBonus() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: AppTheme.warningColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: const Icon(Icons.local_fire_department,
                    color: AppTheme.warningColor, size: 24),
              ),
              const SizedBox(width: AppTheme.spacing12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7-Day Streak!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    'Complete 5+ jobs daily to maintain',
                    style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final isCompleted = index < 7;
              return Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppTheme.primaryGreen
                          : AppTheme.cardBackgroundLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : Icons.circle_outlined,
                      color: isCompleted ? Colors.white : AppTheme.textTertiary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                    style: TextStyle(
                      fontSize: 11,
                      color: isCompleted
                          ? AppTheme.primaryGreen
                          : AppTheme.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: AppTheme.spacing12),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
            ),
            child: Row(
              children: [
                const Icon(Icons.card_giftcard,
                    color: AppTheme.successColor, size: 18),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  'Streak Bonus: ${CurrencyFormatter.format(5000)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTargets() {
    final targets = [
      {'name': 'Complete 30 pickups', 'current': 24, 'target': 30, 'reward': 10000.0},
      {'name': 'Earn \u20A6100,000', 'current': 85, 'target': 100, 'reward': 5000.0},
      {'name': 'Zero disputes', 'current': 7, 'target': 7, 'reward': 3000.0},
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Targets',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...targets.map((t) {
            final progress = (t['current'] as int) / (t['target'] as int);
            final isComplete = progress >= 1.0;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        isComplete
                            ? 'Completed!'
                            : '${t['current']}/${t['target']}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isComplete
                              ? AppTheme.successColor
                              : AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      minHeight: 6,
                      backgroundColor: AppTheme.dividerColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isComplete ? AppTheme.successColor : AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Reward: ${CurrencyFormatter.format(t['reward'] as double)}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.primaryGreen,
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

  Widget _buildMilestones() {
    final milestones = [
      {'name': 'First 100 Pickups', 'achieved': true, 'reward': '5,000'},
      {'name': '500 Pickups', 'achieved': false, 'reward': '25,000'},
      {'name': 'Gold Tier', 'achieved': false, 'reward': '50,000'},
      {'name': '1000 Pickups', 'achieved': false, 'reward': '100,000'},
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Milestone Achievements',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...milestones.map((m) {
            final achieved = m['achieved'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: achieved
                    ? AppTheme.successColor.withValues(alpha: 0.1)
                    : AppTheme.cardBackgroundLight,
                borderRadius: BorderRadius.circular(AppTheme.radius12),
              ),
              child: Row(
                children: [
                  Icon(
                    achieved ? Icons.emoji_events : Icons.lock_outline,
                    color: achieved ? AppTheme.goldColor : AppTheme.textTertiary,
                    size: 24,
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m['name'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: achieved
                                ? AppTheme.textPrimary
                                : AppTheme.textTertiary,
                          ),
                        ),
                        Text(
                          'Reward: \u20A6${m['reward']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: achieved
                                ? AppTheme.primaryGreen
                                : AppTheme.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (achieved)
                    const Icon(Icons.check_circle,
                        color: AppTheme.successColor, size: 20),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    final leaders = [
      {'name': 'Agent Mike', 'score': 98.5, 'rank': 1},
      {'name': 'Agent Sarah', 'score': 96.2, 'rank': 2},
      {'name': 'Agent John', 'score': 94.8, 'rank': 3},
      {'name': 'You', 'score': 87.5, 'rank': 23},
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Leaderboard',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...leaders.map((l) {
            final isYou = l['name'] == 'You';
            return Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: isYou
                    ? AppTheme.primaryGreen.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                border: isYou
                    ? Border.all(
                        color: AppTheme.primaryGreen.withValues(alpha: 0.3))
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _getLeaderColor(l['rank'] as int)
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: Center(
                      child: Text(
                        '#${l['rank']}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _getLeaderColor(l['rank'] as int),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      l['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isYou ? FontWeight.w700 : FontWeight.w600,
                        color: isYou
                            ? AppTheme.primaryGreen
                            : AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${l['score']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
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

  Color _getLeaderColor(int rank) {
    switch (rank) {
      case 1:
        return AppTheme.goldColor;
      case 2:
        return AppTheme.silverColor;
      case 3:
        return AppTheme.bronzeColor;
      default:
        return AppTheme.primaryGreen;
    }
  }
}
