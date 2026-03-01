import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';

class VehicleRequirementsPage extends StatelessWidget {
  const VehicleRequirementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: RecliqAppBar(
        title: 'Vehicle Requirements',
        showBackButton: true,
        showNotifications: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Why Vehicle Requirements Matter',
              icon: Icons.info_outline_rounded,
              content:
                  'At Recliq, your vehicle determines the types of jobs you receive, the volume you can carry, and your overall earning potential.\n\n'
                  'Accurate vehicle details help us:\n'
                  '• Match you with suitable pickups\n'
                  '• Ensure safe and compliant waste handling\n'
                  '• Qualify you for higher-paying enterprise jobs\n'
                  '• Optimize routing and reduce fuel costs\n\n'
                  'The more complete and verified your profile, the more opportunities become available.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Accepted Vehicle Types',
              icon: Icons.local_shipping_rounded,
              content:
                  'Recliq supports various vehicle categories based on operational capacity:\n\n'
                  '• Motorcycle — Small pickups & quick urban drop-offs\n'
                  '• Tricycle — Medium urban collections\n'
                  '• Car — Light recyclable transport\n'
                  '• Mini Truck — Bulk residential pickups\n'
                  '• Truck — Enterprise & industrial collections\n'
                  '• Specialized Recycling Vehicle — Large-scale contracts\n\n'
                  'Your vehicle type directly affects:\n'
                  '• Maximum load eligibility\n'
                  '• Enterprise job access\n'
                  '• Job priority ranking',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Load Capacity Requirements',
              icon: Icons.balance_rounded,
              content:
                  'You must specify your vehicle’s maximum load capacity (in kilograms).\n\n'
                  'This ensures:\n'
                  '• You are only assigned jobs you can safely handle\n'
                  '• Enterprise contracts are fulfilled efficiently\n'
                  '• Overloading risks are avoided\n\n'
                  'Providing incorrect load information may result in:\n'
                  '• Job reassignment\n'
                  '• Performance penalties\n'
                  '• Suspension from certain job categories',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Material Compatibility',
              icon: Icons.recycling_rounded,
              content:
                  'Not all vehicles are suitable for every type of waste.\n\n'
                  'You must indicate which materials your vehicle can safely transport:\n'
                  '• PET plastics\n'
                  '• Metals\n'
                  '• Mixed recyclables\n'
                  '• E-waste\n'
                  '• Bulk disposal waste\n\n'
                  'Enterprise jobs often require specific material handling capabilities.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Required Documentation',
              icon: Icons.description_rounded,
              content:
                  'To operate on Recliq, your vehicle must meet basic compliance standards.\n\n'
                  'You may be required to upload:\n'
                  '• Vehicle registration\n'
                  '• Insurance certificate\n'
                  '• Roadworthiness certificate (if applicable)\n\n'
                  'Verified vehicles receive:\n'
                  '• Enterprise eligibility\n'
                  '• Higher job priority\n'
                  '• Increased trust score\n\n'
                  'Unverified vehicles may be limited to basic pickup requests.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Fuel Type & Sustainability',
              icon: Icons.eco_rounded,
              content:
                  'Recliq promotes sustainable operations.\n\n'
                  'You may specify your vehicle’s fuel type:\n'
                  '• Petrol\n'
                  '• Diesel\n'
                  '• Electric\n'
                  '• Hybrid\n\n'
                  'In future updates, fuel efficiency and sustainability performance may influence:\n'
                  '• Eco bonuses\n'
                  '• Carbon impact rankings\n'
                  '• Commission benefits',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Enterprise Eligibility',
              icon: Icons.business_rounded,
              content:
                  'Enterprise collections require:\n'
                  '• Verified documentation\n'
                  '• Adequate load capacity\n'
                  '• High performance score\n'
                  '• Reliable availability\n\n'
                  'Vehicles meeting these criteria unlock access to larger, higher-paying jobs.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Updating Vehicle Details',
              icon: Icons.update_rounded,
              content:
                  'You can update your vehicle information anytime, but note:\n'
                  '• Changes may temporarily affect job eligibility\n'
                  '• Active jobs cannot be modified mid-task\n'
                  '• Document updates may require re-verification\n\n'
                  'Keeping information accurate is essential for maintaining your performance rating.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Safety & Compliance',
              icon: Icons.shield_rounded,
              content:
                  'Recliq prioritizes safe waste handling.\n\n'
                  'Agents are expected to:\n'
                  '• Avoid overloading\n'
                  '• Follow local transport regulations\n'
                  '• Maintain safe vehicle conditions\n\n'
                  'Repeated safety violations may lead to:\n'
                  '• Temporary suspension\n'
                  '• Enterprise access removal\n'
                  '• Account review',
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Grow With the Right Vehicle',
              icon: Icons.trending_up_rounded,
              content:
                  'Your earning potential increases significantly with:\n'
                  '• Higher load capacity\n'
                  '• Verified compliance\n'
                  '• Strong performance metrics\n'
                  '• Enterprise eligibility\n\n'
                  'Upgrading your vehicle can unlock:\n'
                  '• Larger contracts\n'
                  '• Priority assignments\n'
                  '• Reduced commission tiers',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.directions_car_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Vehicle Requirements Guide',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Set up your vehicle correctly to unlock maximum earning potential and job opportunities',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required String content,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.borderSoft),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: AppTheme.primaryGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (isLast) const SizedBox(height: 100),
      ],
    );
  }
}