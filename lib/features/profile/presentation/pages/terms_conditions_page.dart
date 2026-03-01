import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: RecliqAppBar(
        title: 'Terms & Conditions',
        showNotifications: false,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen.withOpacity(0.15),
                    AppTheme.primaryGreen.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
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
                      Icons.description_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Effective Date: February 22, 2026\n'
                    'Recliq Technologies Ltd. • Port Harcourt, Rivers State, Nigeria',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.85),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Terms Content
            _buildSection(
              title: '1. Acceptance of Terms',
              content: 'By registering as an Agent on Recliq, you agree to be bound by these Terms & Conditions.\n\n'
                  'If you do not agree, do not use the platform.\n\n'
                  'These Terms govern your participation in the Recliq ecosystem, including:\n'
                  '• Pickup services\n'
                  '• Wallet transactions\n'
                  '• Enterprise collections\n'
                  '• Performance ranking\n'
                  '• Commission structure',
            ),

            _buildSection(
              title: '2. Role of Recliq',
              content: 'Recliq operates as:\n'
                  '• A digital recycling coordination platform\n'
                  '• A wallet-based transaction infrastructure\n'
                  '• A logistics marketplace\n'
                  '• An escrow and settlement intermediary\n\n'
                  'Recliq does not employ agents. Agents operate as independent service providers.',
            ),

            _buildSection(
              title: '3. Agent Eligibility',
              content: 'To register as an Agent, you must:\n'
                  '• Be at least 18 years old\n'
                  '• Provide valid identification\n'
                  '• Provide accurate vehicle information (if applicable)\n'
                  '• Complete verification requirements\n'
                  '• Maintain accurate account information\n\n'
                  'Enterprise eligibility requires additional verification.',
            ),

            _buildSection(
              title: '4. Agent Responsibilities',
              content: 'As an Agent, you agree to:\n'
                  '• Maintain sufficient wallet balance (float)\n'
                  '• Honor accepted pickup requests\n'
                  '• Accurately weigh recyclable materials\n'
                  '• Follow QR confirmation procedures\n'
                  '• Treat users professionally\n'
                  '• Comply with local environmental regulations\n'
                  '• Avoid fraudulent or misleading practices\n\n'
                  'Failure to comply may result in suspension or termination.',
            ),

            _buildSection(
              title: '5. Wallet & Financial Rules',
              content: '5.1 Wallet Structure\n\n'
                  'All payments occur digitally through the Recliq wallet system.\n'
                  '• Wallet balances cannot be negative\n'
                  '• All transactions are recorded in an append-only ledger\n\n'
                  '5.2 Float Requirement\n\n'
                  'You must maintain sufficient wallet balance before accepting jobs.\n'
                  'If balance is insufficient:\n'
                  '• You may be restricted from accepting new jobs\n\n'
                  '5.3 Commission\n\n'
                  'Recliq deducts commission automatically from each completed transaction.\n'
                  'Commission rates may vary based on:\n'
                  '• Job type\n'
                  '• Agent tier\n'
                  '• Enterprise category\n\n'
                  'Commission changes may be updated with notice.',
            ),

            _buildSection(
              title: '6. Enterprise Jobs & Escrow',
              content: 'For enterprise collections:\n'
                  '• Enterprise funds are held in escrow\n'
                  '• Payment is released after verified completion\n'
                  '• SLA (Service Level Agreement) compliance is mandatory\n\n'
                  'Failure to meet SLA may result in:\n'
                  '• Reduced performance score\n'
                  '• Restricted enterprise eligibility',
            ),

            _buildSection(
              title: '7. Performance Ranking',
              content: 'Agents are ranked based on:\n'
                  '• Response time\n'
                  '• Completion rate\n'
                  '• Dispute rate\n'
                  '• Availability consistency\n'
                  '• Reliability score\n\n'
                  'Recliq reserves the right to:\n'
                  '• Adjust ranking algorithms\n'
                  '• Restrict job access based on performance\n'
                  '• Modify tier structures',
            ),

            _buildSection(
              title: '8. Cancellations & Non-Completion',
              content: 'Excessive cancellations may result in:\n'
                  '• Performance penalties\n'
                  '• Tier downgrade\n'
                  '• Temporary suspension\n'
                  '• Permanent removal from the platform',
            ),

            _buildSection(
              title: '9. Disputes & Investigations',
              content: 'Recliq may review:\n'
                  '• QR confirmation logs\n'
                  '• Weight data\n'
                  '• GPS timestamps\n'
                  '• Communication records\n\n'
                  'During investigation:\n'
                  '• Funds may be temporarily held\n'
                  '• Account may be restricted\n\n'
                  'Recliq\'s decision after review is final.',
            ),

            _buildSection(
              title: '10. Prohibited Conduct',
              content: 'Agents must not:\n'
                  '• Manipulate weight measurements\n'
                  '• Falsify transaction confirmations\n'
                  '• Collude with users for fraud\n'
                  '• Share account credentials\n'
                  '• Attempt to bypass wallet system\n'
                  '• Conduct off-platform transactions\n\n'
                  'Violations may result in permanent ban and legal action.',
            ),

            _buildSection(
              title: '11. Withdrawals',
              content: 'Agents may withdraw available balance subject to:\n'
                  '• Minimum withdrawal threshold\n'
                  '• Applicable fees\n'
                  '• Compliance checks\n\n'
                  'Processing times depend on financial providers.\n\n'
                  'Recliq reserves the right to delay withdrawals for fraud review.',
            ),

            _buildSection(
              title: '12. Suspension & Termination',
              content: 'Recliq may suspend or terminate your account for:\n'
                  '• Fraudulent behavior\n'
                  '• Repeated disputes\n'
                  '• Low reliability score\n'
                  '• Policy violations\n'
                  '• Regulatory non-compliance\n\n'
                  'You may also voluntarily deactivate your account.',
            ),

            _buildSection(
              title: '13. Independent Contractor Status',
              content: 'Agents are independent contractors.\n\n'
                  'Recliq does not:\n'
                  '• Provide employment benefits\n'
                  '• Guarantee earnings\n'
                  '• Control agent schedules\n\n'
                  'You are responsible for:\n'
                  '• Taxes\n'
                  '• Insurance\n'
                  '• Regulatory compliance',
            ),

            _buildSection(
              title: '14. Limitation of Liability',
              content: 'Recliq is not liable for:\n'
                  '• Indirect losses\n'
                  '• Missed earnings\n'
                  '• Vehicle damages\n'
                  '• Personal injuries during pickups\n\n'
                  'Use of the platform is at your own risk.',
            ),

            _buildSection(
              title: '15. Modifications to Terms',
              content: 'Recliq may update these Terms periodically.\n\n'
                  'You will be notified of material changes.\n\n'
                  'Continued use of the platform constitutes acceptance of updated terms.',
            ),

            _buildSection(
              title: '16. Governing Law',
              content: 'These Terms are governed by the laws of:\n'
                  '• Federal Republic of Nigeria\n\n'
                  'Disputes shall be resolved in accordance with Nigerian law.',
            ),

            _buildSection(
              title: '17. Contact Information',
              content: 'For support or legal inquiries:\n'
                  '• Email: support@recliq.com\n'
                  '• Website: www.recliq.com\n'
                  '• Support: In-App Help Center',
              isLast: true,
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 24),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
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
    );
  }
}
