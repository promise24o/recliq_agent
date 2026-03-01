import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/utils/currency_formatter.dart';
import 'package:recliq_agent/core/utils/fcm_permission_helper.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/features/dashboard/presentation/mobx/dashboard_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';
import 'package:recliq_agent/shared/widgets/metric_card.dart';
import 'package:recliq_agent/shared/widgets/shimmer_loading.dart';
import 'package:recliq_agent/shared/widgets/status_badge.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _dashboardStore = getIt<DashboardStore>();
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _dashboardStore.refresh();
    _authStore.getProfile();
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    // Wait 2 seconds before showing permission request
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      await FcmPermissionHelper.requestNotificationPermission(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: SafeArea(
          child: Observer(
            builder: (_) {
              if (_dashboardStore.isLoading && !_dashboardStore.hasData) {
                return const _DashboardShimmer();
              }

              return Column(
                children: [
                  // Fixed Header
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    child: _buildHeader(),
                  ),
                  // Scrollable Content
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _dashboardStore.refresh,
                      color: AppTheme.primaryGreen,
                      backgroundColor: AppTheme.cardBackground,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppTheme.spacing20),
                            _buildBalanceCard(),
                            const SizedBox(height: AppTheme.spacing20),
                            _buildOperationalSnapshot(),
                            const SizedBox(height: AppTheme.spacing20),
                            _buildQuickActions(),
                            const SizedBox(height: AppTheme.spacing20),
                            _buildPerformanceSection(),
                            const SizedBox(height: 110),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Observer(
      builder: (_) {
        final user = _authStore.currentUser;
        return Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(AppTheme.radius16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Profile Avatar with enhanced styling
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  backgroundImage: user?.profilePhoto != null
                      ? NetworkImage(user!.profilePhoto!)
                      : const AssetImage('assets/images/avatar.png'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              
              // User Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting with improved typography
                    Text(
                      'Hello, ${user?.name ?? 'Agent'}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    
                    // Status and Controls Row
                    Row(
                      children: [
                        // Status Badge
                        Observer(
                          builder: (_) => _dashboardStore.isOnline
                              ? StatusBadge.online()
                              : StatusBadge.offline(),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        
                        // Online Toggle Switch with better styling
                        Observer(
                          builder: (_) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _dashboardStore.isOnline
                                  ? AppTheme.primaryGreen.withValues(alpha: 0.1)
                                  : AppTheme.textTertiary.withValues(alpha: 0.1),
                            ),
                            child: Switch(
                              value: _dashboardStore.isOnline,
                              onChanged: (_) => _dashboardStore.toggleOnline(),
                              activeColor: AppTheme.primaryGreen,
                              activeTrackColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
                              inactiveThumbColor: AppTheme.textTertiary,
                              inactiveTrackColor: AppTheme.textTertiary.withValues(alpha: 0.2),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        
                        // Rank Tier Badge
                        if (_dashboardStore.dashboardData != null) ...[
                          const SizedBox(width: AppTheme.spacing12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacing8,
                              vertical: AppTheme.spacing4,
                            ),
                            decoration: BoxDecoration(
                              color: _getRankColor(_dashboardStore.dashboardData!.rankTier)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radius8),
                              border: Border.all(
                                color: _getRankColor(_dashboardStore.dashboardData!.rankTier)
                                    .withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              _dashboardStore.dashboardData!.rankTier,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getRankColor(_dashboardStore.dashboardData!.rankTier),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              
              // Notification Button with enhanced styling
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                  border: Border.all(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacing8),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: AppTheme.primaryGreen,
                          size: 24,
                        ),
                      ),
                    ),
                    // Notification indicator dot
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.cardBackground,
                            width: 2,
                          ),
                        ),
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

  Widget _buildBalanceCard() {
    return Observer(
      builder: (_) {
        final data = _dashboardStore.dashboardData;
        return GlassCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),
                      Text(
                        CurrencyFormatter.format(
                            data?.availableBalance ?? 0),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/shell/wallet'),
                    icon: const Icon(Icons.account_balance_wallet, size: 18),
                    label: const Text('Withdraw'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing16,
                        vertical: AppTheme.spacing12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radius12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              const Divider(color: AppTheme.dividerColor),
              const SizedBox(height: AppTheme.spacing12),
              Row(
                children: [
                  Expanded(
                    child: _buildBalanceItem(
                      'Pending',
                      CurrencyFormatter.format(
                          data?.pendingBalance ?? 0),
                      Icons.lock_clock,
                      AppTheme.warningColor,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: AppTheme.dividerColor,
                  ),
                  Expanded(
                    child: _buildBalanceItem(
                      'Commission Today',
                      CurrencyFormatter.format(
                          data?.commissionToday ?? 0),
                      Icons.trending_up,
                      AppTheme.primaryGreen,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: AppTheme.dividerColor,
                  ),
                  Expanded(
                    child: _buildBalanceItem(
                      'Earnings Today',
                      CurrencyFormatter.format(
                          data?.earningsToday ?? 0),
                      Icons.attach_money,
                      AppTheme.successColor,
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

  Widget _buildBalanceItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOperationalSnapshot() {
    return Observer(
      builder: (_) {
        final data = _dashboardStore.dashboardData;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Operations',
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
              childAspectRatio: 1.4,
              children: [
                MetricCard(
                  title: 'Active Jobs',
                  value: '${data?.activeJobs ?? 0}',
                  icon: Icons.work_outline,
                  iconColor: AppTheme.infoColor,
                  onTap: () => context.go('/shell/jobs'),
                ),
                MetricCard(
                  title: 'Nearby Requests',
                  value: '${data?.nearbyRequests ?? 0}',
                  icon: Icons.location_on_outlined,
                  iconColor: AppTheme.warningColor,
                  onTap: () => context.go('/shell/jobs'),
                ),
                MetricCard(
                  title: 'Completed Today',
                  value: '${data?.completedToday ?? 0}',
                  icon: Icons.check_circle_outline,
                  iconColor: AppTheme.successColor,
                ),
                MetricCard(
                  title: 'Next Pickup',
                  value: data?.nextScheduledPickup ?? 'None',
                  icon: Icons.schedule,
                  iconColor: AppTheme.primaryGreen,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Scan QR',
                  Icons.qr_code_scanner,
                  () {},
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: _buildActionButton(
                  'Pickup',
                  Icons.add_circle_outline,
                  () => context.go('/shell/jobs'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: _buildActionButton(
                  'Reports',
                  Icons.bar_chart,
                  () => context.go('/shell/insights'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: _buildActionButton(
                  'Insight',
                  Icons.trending_up,
                  () => context.go('/shell/performance'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Bonuses',
                  Icons.card_giftcard,
                  () => context.go('/shell/bonuses'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: _buildActionButton(
                  'Disputes',
                  Icons.gavel,
                  () => context.go('/shell/disputes'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: _buildActionButton(
                  'Wallet',
                  Icons.account_balance_wallet,
                  () => context.go('/shell/wallet'),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: _buildActionButton(
                  'Support',
                  Icons.headset_mic_outlined,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacing16,
          horizontal: AppTheme.spacing8,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 22),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Observer(
      builder: (_) {
        final data = _dashboardStore.dashboardData;
        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Performance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/shell/performance'),
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              Row(
                children: [
                  Expanded(
                    child: _buildPerformanceItem(
                      'Score',
                      '${(data?.performanceScore ?? 0).toStringAsFixed(1)}%',
                      data?.performanceScore ?? 0,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing16),
                  Expanded(
                    child: Column(
                      children: [
                        _buildStatRow(
                          'Completion',
                          '${_dashboardStore.agentStats?.completionRate ?? 0}%',
                        ),
                        const SizedBox(height: AppTheme.spacing8),
                        _buildStatRow(
                          'SLA Adherence',
                          '${_dashboardStore.agentStats?.slaAdherence ?? 0}%',
                        ),
                        const SizedBox(height: AppTheme.spacing8),
                        _buildStatRow(
                          'Dispute Rate',
                          '${_dashboardStore.agentStats?.disputeRate ?? 0}%',
                        ),
                      ],
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

  Widget _buildPerformanceItem(
      String label, String value, double percentage) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: percentage / 100,
                  strokeWidth: 8,
                  backgroundColor:
                      AppTheme.primaryGreen.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryGreen),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
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
}

class _DashboardShimmer extends StatelessWidget {
  const _DashboardShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        children: [
          const ShimmerLoading(height: 50),
          const SizedBox(height: AppTheme.spacing20),
          const ShimmerCard(height: 180),
          const SizedBox(height: AppTheme.spacing20),
          Row(
            children: const [
              Expanded(child: ShimmerCard(height: 120)),
              SizedBox(width: AppTheme.spacing12),
              Expanded(child: ShimmerCard(height: 120)),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          Row(
            children: const [
              Expanded(child: ShimmerCard(height: 120)),
              SizedBox(width: AppTheme.spacing12),
              Expanded(child: ShimmerCard(height: 120)),
            ],
          ),
        ],
      ),
    );
  }
}
