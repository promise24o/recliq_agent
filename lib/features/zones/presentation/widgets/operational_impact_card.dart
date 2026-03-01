import 'package:flutter/material.dart';
import 'package:recliq_agent/features/zones/domain/entities/service_radius.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class OperationalImpactCard extends StatelessWidget {
  final ServiceRadius serviceRadius;

  const OperationalImpactCard({
    super.key,
    required this.serviceRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Operational Impact',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'How your radius affects your operations',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          _buildImpactItem(
            icon: Icons.request_page_outlined,
            title: 'Estimated Daily Requests',
            value: serviceRadius.estimatedDailyRequests?.toString() ?? 'N/A',
            color: AppTheme.primaryGreen,
          ),
          const SizedBox(height: 16),
          _buildImpactItem(
            icon: Icons.attach_money,
            title: 'Average Payout Per Job',
            value: serviceRadius.averagePayoutPerJob != null
                ? '₦${serviceRadius.averagePayoutPerJob!.toStringAsFixed(0)}'
                : 'N/A',
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildImpactItem(
            icon: Icons.local_gas_station_outlined,
            title: 'Estimated Fuel Cost',
            value: serviceRadius.estimatedFuelCost != null
                ? '₦${serviceRadius.estimatedFuelCost!.toStringAsFixed(0)}'
                : 'N/A',
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildImpactItem(
            icon: Icons.timer_outlined,
            title: 'Average Response Time',
            value: serviceRadius.averageResponseTime != null
                ? '${serviceRadius.averageResponseTime} min'
                : 'N/A',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildImpactItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
