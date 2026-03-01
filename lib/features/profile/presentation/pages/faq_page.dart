import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: RecliqAppBar(
        title: 'FAQ',
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
                      Icons.help_outline,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Everything you need to know about being a Recliq Agent',
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
            
            // FAQ Items
            _buildFAQItem(
              '1. What is Recliq?',
              'Recliq is a digital recycling platform that connects recyclers (users) with verified agents who collect recyclable waste and pay them instantly through a wallet-based system.\n\nAs an agent, you earn by:\n• Collecting recyclables\n• Paying users from your wallet\n• Earning commission margins\n• Completing enterprise pickups',
            ),
            _buildFAQItem(
              '2. How do I make money as an agent?',
              'You earn when you:\n• Complete pickup jobs\n• Accept drop-offs\n• Handle enterprise collections\n• Maintain high performance (better jobs unlock)\n\nYour earnings come from:\n• Recycling margin\n• Commission structure\n• Enterprise collection payouts\n\nYour performance score affects your earning potential.',
            ),
            _buildFAQItem(
              '3. How does the wallet work?',
              'Your agent wallet is your operating float.\n\nYou must have enough balance before accepting pickups.\n\nWhen you complete a pickup:\n• You pay the user from your wallet\n• Recliq automatically deducts commission\n• No negative wallet balances are allowed\n• All transactions are recorded in an append-only ledger',
            ),
            _buildFAQItem(
              '4. How do I fund my wallet?',
              'You can fund your wallet by:\n• Bank transfer\n• Admin top-up (if enabled)\n• Enterprise settlement credits\n\nYour wallet must have sufficient balance before accepting jobs.',
            ),
            _buildFAQItem(
              '5. How are commissions calculated?',
              'Commission is automatically deducted after each confirmed transaction.\n\nIt may vary based on:\n• Job type (standard vs enterprise)\n• Agent tier\n• Performance score\n\nYou can view your commission breakdown in:\nWallet → Transaction History',
            ),
            _buildFAQItem(
              '6. What happens if my wallet balance is low?',
              'You will:\n• Be unable to accept new jobs\n• Receive a low-float notification\n• See restricted job access\n\nTo continue accepting jobs, top up your wallet.',
            ),
            _buildFAQItem(
              '7. How do pickup requests work?',
              'When a user requests pickup:\n• Nearby eligible agents are notified\n• You can accept within the response window\n• Navigate to the pickup location\n• Weigh materials\n• User scans your QR code to confirm\n• Payment is processed automatically\n• The transaction is final once confirmed',
            ),
            _buildFAQItem(
              '8. What is the QR confirmation system?',
              'QR confirmation ensures:\n• Transparent weight validation\n• Payment accuracy\n• Fraud prevention\n• Secure transaction logging\n\nBoth you and the user must confirm before payment is processed.',
            ),
            _buildFAQItem(
              '9. What is my performance score?',
              'Your performance score is based on:\n• Response time\n• Completion rate\n• Dispute rate\n• Reliability\n• Availability consistency\n\nHigher scores unlock:\n• Enterprise jobs\n• Priority listings\n• Higher earning potential',
            ),
            _buildFAQItem(
              '10. What are agent tiers?',
              'Agents are ranked based on performance.\n\nExample tiers:\n• Starter\n• Verified\n• Elite\n• Enterprise-Qualified\n\nHigher tiers gain:\n• Access to larger jobs\n• Enterprise eligibility\n• Better visibility in the marketplace',
            ),
            _buildFAQItem(
              '11. How does enterprise pickup work?',
              'Enterprise jobs are bulk waste collections from businesses.\n\nTo qualify, you must:\n• Have verified vehicle details\n• Maintain high performance score\n• Meet SLA compliance requirements\n\nEnterprise payments are:\n• Held in escrow\n• Released after weight confirmation',
            ),
            _buildFAQItem(
              '12. What is escrow?',
              'Escrow means:\n• Enterprise funds are secured before pickup\n• Funds are released only after verified completion\n• Protects both agent and enterprise client',
            ),
            _buildFAQItem(
              '13. What if a dispute occurs?',
              'If a user raises a dispute:\n• The transaction may be temporarily flagged\n• Admin reviews:\n  - Weight logs\n  - QR confirmations\n  - Timestamp data\n• Resolution will follow platform policies\n• Frequent disputes lower your performance score',
            ),
            _buildFAQItem(
              '14. Can I go offline?',
              'Yes.\n\nYou control your availability:\n• Set online/offline\n• Configure weekly schedule\n• Set service radius\n\nIf you are offline:\n• You will not receive new jobs\n• Your availability consistency score may be affected if irregular',
            ),
            _buildFAQItem(
              '15. What happens if I cancel a job?',
              'Excessive cancellations may:\n• Reduce your reliability score\n• Lower your tier ranking\n• Restrict access to premium jobs\n\nOnly accept jobs you can complete.',
            ),
            _buildFAQItem(
              '16. How do withdrawals work?',
              'You can withdraw:\n• To bank account\n• Based on minimum threshold\n• Withdrawal fees may apply\n• Processing times depend on payment provider',
            ),
            _buildFAQItem(
              '17. Can users withdraw through me?',
              'Yes.\n\nUsers may:\n• Transfer wallet balance to you\n• Receive physical cash from you\n\nYou must:\n• Confirm wallet transfer before giving cash\n• Follow platform cash-handling policies',
            ),
            _buildFAQItem(
              '18. How do I increase my earnings?',
              'Improve:\n• Response speed\n• Completion rate\n• Reliability\n• Availability hours\n• Vehicle verification\n\nHigher performance unlocks:\n• More jobs\n• Enterprise collections\n• Better margins',
            ),
            _buildFAQItem(
              '19. What documents are required?',
              'You may need:\n• Valid ID\n• Vehicle documents\n• Insurance (if applicable)\n• Compliance verification\n\nEnterprise eligibility requires full verification.',
            ),
            _buildFAQItem(
              '20. Is Recliq a logistics app?',
              'No.\n\nRecliq is a wallet-powered recycling network.\n\nAs an agent, you are part of:\n• A circular economy system\n• A decentralized waste-fintech network\n• A performance-driven logistics ecosystem',
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(20),
        childrenPadding: const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.help_outline,
            color: AppTheme.primaryGreen,
            size: 20,
          ),
        ),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: AppTheme.primaryGreen,
        collapsedIconColor: AppTheme.primaryGreen,
        children: [
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
