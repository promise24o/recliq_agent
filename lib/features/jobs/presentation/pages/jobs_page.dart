import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/utils/currency_formatter.dart';
import 'package:recliq_agent/features/jobs/domain/entities/job.dart';
import 'package:recliq_agent/features/jobs/presentation/mobx/jobs_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/empty_state.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';
import 'package:recliq_agent/shared/widgets/shimmer_loading.dart';
import 'package:recliq_agent/shared/widgets/status_badge.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> with SingleTickerProviderStateMixin {
  final _jobsStore = getIt<JobsStore>();
  late TabController _tabController;

  final _tabs = const ['Nearby', 'Assigned', 'Scheduled', 'Enterprise'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      _jobsStore.setSelectedTab(_tabController.index);
    });
    _jobsStore.loadAllJobs();
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
        title: const Text('Job Center'),
        backgroundColor: AppTheme.darkBackground,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryGreen,
          labelColor: AppTheme.primaryGreen,
          unselectedLabelColor: AppTheme.textTertiary,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildJobList(() => _jobsStore.nearbyJobs, 'nearby'),
            _buildJobList(() => _jobsStore.assignedJobs, 'assigned'),
            _buildJobList(() => _jobsStore.scheduledJobs, 'scheduled'),
            _buildJobList(() => _jobsStore.enterpriseJobs, 'enterprise'),
          ],
        ),
      ),
    );
  }

  Widget _buildJobList(List<Job> Function() getJobs, String type) {
    return Observer(
      builder: (_) {
        if (_jobsStore.isLoading && getJobs().isEmpty) {
          return const ShimmerList(itemCount: 4, itemHeight: 160);
        }

        final jobs = getJobs();
        if (jobs.isEmpty) {
          return NoDataEmptyState(
            title: 'No ${type.replaceFirst(type[0], type[0].toUpperCase())} Jobs',
            description: 'Check back later for new opportunities',
          );
        }

        return RefreshIndicator(
          onRefresh: _jobsStore.loadAllJobs,
          color: AppTheme.primaryGreen,
          backgroundColor: AppTheme.cardBackground,
          child: ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            itemCount: jobs.length,
            itemBuilder: (context, index) => _buildJobCard(jobs[index]),
          ),
        );
      },
    );
  }

  Widget _buildJobCard(Job job) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      onTap: () => _showJobDetails(job),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacing8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppTheme.radius8),
                      ),
                      child: const Icon(
                        Icons.recycling,
                        color: AppTheme.primaryGreen,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.wasteType,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          if (job.customerName != null)
                            Text(
                              job.customerName!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildJobStatusBadge(job.status),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          if (job.address != null)
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 14, color: AppTheme.textTertiary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.address!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          const SizedBox(height: AppTheme.spacing12),
          Row(
            children: [
              _buildJobInfo(
                Icons.scale,
                '${job.estimatedWeight} kg',
              ),
              const SizedBox(width: AppTheme.spacing16),
              _buildJobInfo(
                Icons.attach_money,
                CurrencyFormatter.format(job.estimatedPayout),
              ),
              const SizedBox(width: AppTheme.spacing16),
              _buildJobInfo(
                Icons.near_me,
                '${job.distance} km',
              ),
              if (job.slaTime != null) ...[
                const SizedBox(width: AppTheme.spacing16),
                _buildJobInfo(
                  Icons.timer_outlined,
                  job.slaTime!,
                ),
              ],
            ],
          ),
          if (job.isEscrowSecured == true) ...[
            const SizedBox(height: AppTheme.spacing8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing8,
                vertical: AppTheme.spacing4,
              ),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radius4),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, size: 12, color: AppTheme.successColor),
                  SizedBox(width: 4),
                  Text(
                    'Escrow Secured',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (job.status == JobStatus.pending && job.type == JobType.nearby) ...[
            const SizedBox(height: AppTheme.spacing12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _acceptJob(job),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                ),
                child: const Text('Accept Job'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildJobInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppTheme.textTertiary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildJobStatusBadge(JobStatus status) {
    switch (status) {
      case JobStatus.pending:
        return StatusBadge.pending();
      case JobStatus.accepted:
        return const StatusBadge(
          label: 'Accepted',
          color: AppTheme.infoColor,
          icon: Icons.check,
        );
      case JobStatus.inProgress:
        return const StatusBadge(
          label: 'In Progress',
          color: AppTheme.warningColor,
          icon: Icons.directions_run,
        );
      case JobStatus.arrived:
        return const StatusBadge(
          label: 'Arrived',
          color: AppTheme.primaryGreen,
          icon: Icons.place,
        );
      case JobStatus.completed:
        return StatusBadge.completed();
      case JobStatus.cancelled:
        return StatusBadge.failed();
    }
  }

  Future<void> _acceptJob(Job job) async {
    await _jobsStore.acceptJob(job.id);
    if (_jobsStore.successMessage != null) {
      ToastHelper.showToast(
        context,
        _jobsStore.successMessage!,
        backgroundColor: AppTheme.successColor,
      );
    } else if (_jobsStore.errorMessage != null) {
      ToastHelper.showToast(
        context,
        _jobsStore.errorMessage!,
        backgroundColor: AppTheme.errorColor,
      );
    }
  }

  void _showJobDetails(Job job) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius24),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      job.wasteType,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    _buildJobStatusBadge(job.status),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing16),
                if (job.customerName != null)
                  _buildDetailRow('Customer', job.customerName!),
                if (job.customerPhone != null)
                  _buildDetailRow('Phone', job.customerPhone!),
                if (job.address != null)
                  _buildDetailRow('Address', job.address!),
                _buildDetailRow('Est. Weight', '${job.estimatedWeight} kg'),
                _buildDetailRow('Est. Payout',
                    CurrencyFormatter.format(job.estimatedPayout)),
                _buildDetailRow('Distance', '${job.distance} km'),
                if (job.slaTime != null)
                  _buildDetailRow('SLA Time', job.slaTime!),
                if (job.pricePerKg != null)
                  _buildDetailRow('Price/kg',
                      CurrencyFormatter.format(job.pricePerKg!)),
                if (job.complianceNotes != null) ...[
                  const SizedBox(height: AppTheme.spacing12),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing12),
                    decoration: BoxDecoration(
                      color: AppTheme.warningColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                      border: Border.all(
                        color: AppTheme.warningColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber,
                            color: AppTheme.warningColor, size: 18),
                        const SizedBox(width: AppTheme.spacing8),
                        Expanded(
                          child: Text(
                            job.complianceNotes!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppTheme.spacing24),
                _buildJobActions(job),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobActions(Job job) {
    switch (job.status) {
      case JobStatus.pending:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _acceptJob(job);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
            ),
            child: const Text('Accept Job', style: TextStyle(fontSize: 16)),
          ),
        );
      case JobStatus.accepted:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _jobsStore.startPickup(job.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.infoColor,
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
            ),
            child: const Text('Start Pickup', style: TextStyle(fontSize: 16)),
          ),
        );
      case JobStatus.inProgress:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _jobsStore.markArrived(job.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.warningColor,
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
            ),
            child: const Text('Mark Arrived', style: TextStyle(fontSize: 16)),
          ),
        );
      case JobStatus.arrived:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _jobsStore.completeJob(
                jobId: job.id,
                actualWeight: job.estimatedWeight,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successColor,
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
            ),
            child: const Text('Complete Job', style: TextStyle(fontSize: 16)),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
