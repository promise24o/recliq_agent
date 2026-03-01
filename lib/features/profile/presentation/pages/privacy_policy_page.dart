import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: RecliqAppBar(
        title: 'Privacy Policy',
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
                      Icons.lock_outline_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Privacy Policy',
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

            // Main Content
            _buildSection(
              title: '1. Introduction',
              content:
                  'Recliq is a wallet-based digital recycling and logistics coordination platform operating in Port Harcourt and expanding to other locations.\n\n'
                  'Unlike typical marketplace apps, Recliq operates:\n'
                  '• A controlled wallet ledger system\n'
                  '• An agent performance ranking engine\n'
                  '• An escrow-backed enterprise payment structure\n'
                  '• A recycling impact and carbon tracking system\n\n'
                  'This Privacy Policy explains how data flows through these systems and how it is protected.\n\n'
                  'By creating an account or using Recliq services, you agree to this Privacy Policy.',
            ),

            const SizedBox(height: 24),

            _buildSection(
              title: '2. Data We Collect — By Role',
              content:
                  'Recliq collects different categories of data depending on whether you are a User (Recycler), Agent (Collector), Enterprise Client, or Admin Staff.',
            ),

            _buildSubSection(
              title: '2.1 User (Recycler) Data',
              content:
                  '• Identity Data\n  - Full name\n  - Phone number (primary account identifier)\n  - Email (optional but recommended)\n  - Residential or pickup address\n  - Profile photo (optional)\n\n'
                  '• Wallet Data\n  - Wallet balance\n  - Ledger entries (credits, debits)\n  - Withdrawal records\n  - Agent transfer logs\n  - Referral rewards\n  - Airtime/data purchase records\n\n'
                  '• Recycling Activity Data\n  - Weight submitted per transaction\n  - Material type categories\n  - Pickup frequency\n  - Carbon impact metrics\n  - Reward points & streak data\n\n'
                  '• Location Data\n  - Pickup request location\n  - GPS confirmation at transaction time',
            ),

            _buildSubSection(
              title: '2.2 Agent Data',
              content:
                  'Agents handle financial float and logistics, so additional data is collected:\n\n'
                  '• Identity & Verification\n  - Government-issued ID\n  - Selfie verification\n  - Bank account details\n  - Vehicle details (type, plate number, capacity)\n  - Compliance documents (where required)\n\n'
                  '• Operational Data\n  - Online/offline timestamps\n  - Service radius configuration\n  - Weekly availability schedule\n  - Job acceptance & response times\n  - Job completion timestamps\n  - Cancellation logs\n  - Dispute records\n\n'
                  '• Financial Float Data\n  - Wallet balance\n  - Commission deductions\n  - Escrow releases\n  - Withdrawal history\n  - Cash-out transfers (user → agent wallet)\n\n'
                  '• Performance Data\n  - Response time average\n  - Completion rate\n  - Dispute rate\n  - Reliability score\n  - Tier ranking status\n\n'
                  'This data directly feeds the Agent Ranking Engine.',
            ),

            _buildSubSection(
              title: '2.3 Enterprise Client Data',
              content:
                  '• Company name\n'
                  '• Registered business address\n'
                  '• Authorized contact persons\n'
                  '• Tax identification (where required)\n'
                  '• Scheduled pickup volume\n'
                  '• Escrow payment records\n'
                  '• SLA compliance reports\n\n'
                  'Enterprise payments are linked to escrow transaction IDs in the wallet ledger.',
            ),

            _buildSubSection(
              title: '2.4 Admin & Backoffice Data',
              content:
                  '• Role-based admin access logs\n'
                  '• Audit logs of financial actions\n'
                  '• Manual adjustments (if any)\n'
                  '• System override records\n'
                  '• Risk flags & fraud investigation notes\n\n'
                  'All admin actions are logged and fully traceable.',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '3. How Recliq Uses Your Data',
              content: 'We use your data to operate five core systems:',
            ),

            _buildSubSection(
              title: '3.1 Wallet & Ledger Engine',
              content:
                  '• Credit and debit wallets\n'
                  '• Automatically deduct commissions\n'
                  '• Prevent negative balances\n'
                  '• Reconcile enterprise escrow\n'
                  '• Generate settlement reports\n\n'
                  'All wallet entries are append-only and cannot be edited retroactively.',
            ),

            _buildSubSection(
              title: '3.2 Job Matching & Logistics Engine',
              content:
                  '• Match nearby agents to users\n'
                  '• Prioritize high-performance agents\n'
                  '• Prevent fraudulent location spoofing\n'
                  '• Confirm on-site presence during pickup\n\n'
                  'Real-time tracking only occurs while an agent is marked "Online."',
            ),

            _buildSubSection(
              title: '3.3 Agent Performance Engine',
              content:
                  '• Rank agents\n'
                  '• Assign tiers\n'
                  '• Unlock enterprise eligibility\n'
                  '• Identify unreliable behavior\n'
                  '• Restrict access to high-value jobs if necessary\n\n'
                  'This system is algorithm-driven and periodically recalibrated.',
            ),

            _buildSubSection(
              title: '3.4 Escrow & Settlement Engine',
              content:
                  '• Held in escrow\n'
                  '• Linked to job IDs\n'
                  '• Released after verified weight confirmation\n'
                  '• Held if dispute or SLA breach is detected\n\n'
                  'Escrow funds are segregated from operational revenue.',
            ),

            _buildSubSection(
              title: '3.5 Rewards & Carbon Engine',
              content:
                  '• Calculate carbon impact\n'
                  '• Generate environmental reports\n'
                  '• Award badges and streaks\n'
                  '• Allocate referral bonuses\n'
                  '• Power leaderboard systems\n\n'
                  'Impact metrics are calculated algorithmically and may be updated as methodologies evolve.',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '4. Fraud Detection & Risk Monitoring',
              content:
                  'We analyze data patterns to detect:\n'
                  '• Weight manipulation\n'
                  '• Repeated cancellation abuse\n'
                  '• Collusion between user and agent\n'
                  '• Rapid suspicious withdrawals\n'
                  '• GPS spoofing\n\n'
                  'This may involve automated flagging and manual review.\n\n'
                  'During investigations:\n'
                  '• Wallet withdrawals may be temporarily restricted\n'
                  '• Escrow funds may be held',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '5. Data Sharing — Specific Scenarios',
              content: 'We share limited data only when necessary:',
            ),

            _buildSubSection(
              title: '5.1 Payment Infrastructure Providers',
              content:
                  'For:\n'
                  '• Bank withdrawals\n'
                  '• Wallet funding\n'
                  '• Enterprise escrow holding\n\n'
                  'We do not store complete card credentials.',
            ),

            _buildSubSection(
              title: '5.2 Regulatory & Law Enforcement',
              content: 'When legally required under Nigerian law.',
            ),

            _buildSubSection(
              title: '5.3 Enterprise Clients',
              content:
                  'Only:\n'
                  '• Pickup confirmation\n'
                  '• Agent performance compliance\n'
                  '• Weight verification logs\n\n'
                  'We do NOT share:\n'
                  '• Personal phone numbers\n'
                  '• Private wallet balances\n'
                  '• Home addresses (beyond pickup location needed for service)',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '6. Data Storage & Infrastructure',
              content:
                  'Recliq uses secure cloud infrastructure with:\n'
                  '• Encrypted storage\n'
                  '• Encrypted API communication\n'
                  '• Role-based database access\n'
                  '• Segregated production and admin systems\n'
                  '• Daily system logs\n'
                  '• Fraud audit logging\n\n'
                  'Financial records are stored separately from general profile data.',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '7. Data Retention Policy',
              content:
                  '• Financial Ledger Data: Minimum 7 years (for regulatory compliance and audit purposes).\n'
                  '• Performance Metrics: Retained for as long as account remains active.\n'
                  '• Deleted Accounts: Profile data may be anonymized. Ledger data remains retained for compliance.',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '8. Your Rights (Nigeria Data Protection Act Compliance)',
              content:
                  'You may request:\n'
                  '• Access to stored personal data\n'
                  '• Correction of inaccurate data\n'
                  '• Deletion (excluding mandatory financial records)\n'
                  '• Export of wallet history\n'
                  '• Clarification of how performance score is calculated (summary explanation)\n\n'
                  'All requests must be verified before processing.',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '9. Account Deletion & Wallet Closure',
              content:
                  'Before deletion:\n'
                  '• Wallet balance must be zero\n'
                  '• All disputes must be resolved\n'
                  '• No active enterprise escrow jobs\n'
                  '• Ledger entries remain archived for compliance',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '10. Children\'s Data',
              content:
                  'Recliq strictly prohibits account registration for individuals under 18.\n\n'
                  'Verification checks may be performed for agents and enterprise contacts.',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '11. Cross-Border Storage',
              content:
                  'If infrastructure is hosted outside Nigeria:\n'
                  '• Data is encrypted\n'
                  '• Cloud providers meet international security standards\n'
                  '• Nigerian data protection standards are maintained',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '12. Policy Updates',
              content:
                  'When major structural changes occur (e.g., new financial product, new escrow structure):\n'
                  '• Users will receive in-app notification\n'
                  '• Continued usage constitutes acceptance',
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: '13. Contact',
              content:
                  'Data Protection Officer\n'
                  'Recliq Technologies Ltd.\n'
                  'Port Harcourt, Rivers State\n'
                  'Email: privacy@recliq.com',
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

  Widget _buildSubSection({
    required String title,
    required String content,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}