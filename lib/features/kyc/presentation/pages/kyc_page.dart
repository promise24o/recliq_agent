import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/features/kyc/domain/entities/kyc_status.dart';
import 'package:recliq_agent/features/kyc/presentation/mobx/kyc_store.dart';
import 'package:recliq_agent/features/kyc/presentation/widgets/kyc_type_selection_sheet.dart';
import 'package:recliq_agent/features/kyc/presentation/widgets/bvn_verification_sheet.dart';
import 'package:recliq_agent/features/kyc/presentation/widgets/document_upload_sheet.dart';
import 'package:recliq_agent/features/kyc/presentation/widgets/selfie_upload_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  State<KycPage> createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> with WidgetsBindingObserver {
  final _kycStore = getIt<KycStore>();
  final _authStore = getIt<AuthStore>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadProfileAndKycStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadProfileAndKycStatus();
    }
  }

  Future<void> _loadProfileAndKycStatus() async {
    // Load current user first
    await _authStore.getCurrentUser();
    _loadKycStatus();
  }

  Future<void> _loadKycStatus() async {
    final currentUser = _authStore.currentUser;
    final userId = currentUser?.id;
    
    if (currentUser != null && userId?.isNotEmpty == true) {
      await _kycStore.loadKycStatus(userId!);
      await _kycStore.loadBanks();
    }
  }

  Future<void> _handleRefresh() async {
    await _loadProfileAndKycStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: RecliqAppBar(
        title: 'KYC Verification',
        showNotifications: true,
        showBackButton: true,
      ),
      body: Observer(
        builder: (context) {
          return LoadingOverlay(
            isVisible: _kycStore.isLoading && _kycStore.kycStatus == null,
            message: 'Loading KYC status...',
            child: SizedBox.expand(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: AppTheme.primaryGreen,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  child: _buildBody(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_kycStore.kycStatus != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(),
          const SizedBox(height: 24),
          _buildContentBasedOnStatus(),
            const SizedBox(height: 100),
        ],
      );
    } else {
      return const SizedBox(); 
    } 
  }

  Widget _buildStatusCard() {
    final status = _kycStore.kycStatus!;
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: _getStatusColor(status.status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Icon(
                  _getStatusIcon(status.status),
                  color: _getStatusColor(status.status),
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Agent Verification',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _getStatusText(status.status),
                      style: TextStyle(
                        color: _getStatusColor(status.status),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              _buildStatusBadge(status.status),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          const Divider(color: AppTheme.dividerColor),
          const SizedBox(height: AppTheme.spacing16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatusIndicator(
                  'Current Tier',
                  _getTierIcon(status.currentTier),
                  status.currentTier.name,
                  AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: _buildStatusIndicator(
                  'User Type',
                  _getUserTypeIcon(status.userType),
                  status.userType.name,
                  AppTheme.infoColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          
          _buildLimitsInfo(status),
        ],
      ),
    );
  }

  Widget _buildContentBasedOnStatus() {
    if (_kycStore.kycStatus != null) {
      final status = _kycStore.kycStatus!;
      switch (status.status) {
        case KycStatusEnum.verified:
          return _buildVerifiedContent();
        case KycStatusEnum.rejected:
          return _buildRejectedContent();
        case KycStatusEnum.pendingAdminApproval:
          return _buildPendingApprovalContent();
        case KycStatusEnum.inProgress:
          return _buildInProgressContent();
        case KycStatusEnum.pending:
          return _buildPendingContent();
      }
    } else {
      return _buildStartKycCard();
    }
  }

  Widget _buildVerifiedContent() {
    final status = _kycStore.kycStatus!;
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        border: Border.all(color: AppTheme.successColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.verified, color: AppTheme.successColor, size: 24),
              ),
              const SizedBox(width: AppTheme.spacing16),
              const Expanded(
                child: Text(
                  'Agent Verification Complete',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            'Congratulations! Your agent account has been fully verified and upgraded to ${status.currentTier.name} tier. You now have access to all features and higher transaction limits.',
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),
          
          // Verification Status Section
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              border: Border.all(color: AppTheme.borderSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verification Status',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildVerificationItem('Email Verification', status.emailVerified),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: _buildVerificationItem('BVN Verification', status.bvnVerified),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                Row(
                  children: [
                    Expanded(
                      child: _buildVerificationItem('ID Document', status.documentsUploaded),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: _buildVerificationItem('Selfie', status.selfieUploaded),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing16),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: AppTheme.successColor, size: 16),
                      const SizedBox(width: AppTheme.spacing8),
                      const Expanded(
                        child: Text(
                          'All verification steps completed successfully!',
                          style: TextStyle(
                            color: AppTheme.successColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),
          
          // Benefits Section
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: AppTheme.primaryGreen, size: 20),
                    const SizedBox(width: AppTheme.spacing8),
                    const Text(
                      'Benefits Unlocked',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                _buildBenefitItem('Higher transaction limits'),
                _buildBenefitItem('Full access to all agent features'),
                _buildBenefitItem('Priority support'),
                _buildBenefitItem('Enhanced security features'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectedContent() {
    final status = _kycStore.kycStatus!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 24),
              const SizedBox(width: 12),
              const Text(
                'KYC Verification Rejected',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (status.rejectionReason != null) ...[
            Text(
              'Reason: ${status.rejectionReason}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
          ],
          const Text(
            'Please review the requirements and resubmit your verification.',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          _buildStartButton(),
        ],
      ),
    );
  }

  Widget _buildPendingApprovalContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hourglass_empty, color: Colors.orange, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Awaiting Admin Approval',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Your documents have been submitted and are currently under review by our verification team. This process typically takes 1-3 business days.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingContent() {
    return Column(
      children: [
        _buildVerificationSteps(),
        const SizedBox(height: 24),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildInProgressContent() {
    final status = _kycStore.kycStatus!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.hourglass_top,
                color: Colors.blue,
                size: 32,
              ),
              const SizedBox(width: 12),
              const Text(
                'KYC Verification In Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Your agent verification is currently being reviewed by our team. We\'ve received your documents and are processing them.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900]?.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[800]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verification Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildVerificationItem('BVN Verification', status.bvnVerified),
                _buildVerificationItem('ID Document', status.documentsUploaded),
                _buildVerificationItem('Selfie', status.selfieUploaded),
                const SizedBox(height: 12),
                const Text(
                  'Your documents are under review. This typically takes 1-2 business days.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationItem(String title, bool isCompleted) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing8),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppTheme.successColor.withValues(alpha: 0.1)
            : AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: isCompleted
              ? AppTheme.successColor.withValues(alpha: 0.3)
              : AppTheme.borderSoft,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? AppTheme.successColor : AppTheme.textSecondary,
            size: 20,
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            title,
            style: TextStyle(
              color: isCompleted ? AppTheme.successColor : AppTheme.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationSteps() {
    final status = _kycStore.kycStatus!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verification Steps',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (status.userType == KycUserType.agent) ...[
            _buildStep(1, 'BVN Verification', 'Verify your Bank Verification Number', status.bvnVerified),
            _buildStep(2, 'Document Upload', 'Upload your ID document', status.documentsUploaded),
            _buildStep(3, 'Selfie Upload', 'Upload a clear selfie', status.selfieUploaded),
          ] else ...[
            _buildStep(1, 'BVN Verification', 'Verify your Bank Verification Number', status.bvnVerified),
            _buildStep(2, 'Document Upload', 'Upload your ID document', status.documentsUploaded),
            _buildStep(3, 'Selfie Upload', 'Upload a clear selfie', status.selfieUploaded),
          ],
        ],
      ),
    );
  }

  Widget _buildStep(int number, String title, String subtitle, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted ? AppTheme.primaryGreen : Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  color: isCompleted ? Colors.black : Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartKycCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: AppTheme.primaryGreen,
                  size: 32,
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete Agent Verification',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing4),
                    Text(
                      'Unlock higher limits and premium features',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing20),
          
          // Required Documents Section
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Required Documents',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing12),
                _buildDocumentRequirement('BVN Verification', 'Bank Verification Number', Icons.account_balance_outlined),
                _buildDocumentRequirement('ID Document', 'Government-issued ID card or passport', Icons.badge_outlined),
                _buildDocumentRequirement('Selfie Photo', 'Clear photo of yourself', Icons.photo_camera_outlined),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),
          
          // Important Notes
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              border: Border.all(color: AppTheme.warningColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: AppTheme.warningColor, size: 20),
                    const SizedBox(width: AppTheme.spacing8),
                    const Text(
                      'Important Notes',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                _buildNoteItem('All documents must be clear and valid'),
                _buildNoteItem('BVN must match your registered account details'),
                _buildNoteItem('Verification typically takes 1-2 business days'),
                _buildNoteItem('You\'ll receive notifications on status updates'),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing24),
          
          // Start Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _showKycTypeSelection,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Start KYC Verification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRequirement(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800]?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[700]?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.grey[300],
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final status = _kycStore.kycStatus!;
    
    return Column(
      children: [
        // Step 1: Initialize KYC with Agent type (if not initialized - check if userType is individual)
        if (status.userType == KycUserType.individual)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showKycTypeSelection(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Initialize KYC as Agent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        
        // Step 2: BVN Verification (only show after KYC is initialized as AGENT and BVN not verified)
        if (status.userType == KycUserType.agent && !status.bvnVerified)
          Column(
            children: [
              if (status.userType == KycUserType.agent) const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showBvnVerificationSheet(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Verify BVN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        
        // Step 3: Document Upload (only show after BVN is verified and document not uploaded)
        if (status.bvnVerified && !status.documentsUploaded)
          Column(
            children: [
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showDocumentUploadSheet(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Upload Document',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        
        // Step 4: Selfie Upload (only show after document is uploaded and selfie not uploaded)
        if (status.documentsUploaded && !status.selfieUploaded)
          Column(
            children: [
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showSelfieUploadSheet(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Upload Selfie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showKycTypeSelection(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Start KYC Verification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(KycStatusEnum status) {
    switch (status) {
      case KycStatusEnum.verified:
        return Colors.green;
      case KycStatusEnum.pendingAdminApproval:
        return Colors.orange;
      case KycStatusEnum.rejected:
        return Colors.red;
      case KycStatusEnum.inProgress:
        return Colors.blue;
      case KycStatusEnum.pending:
        return Colors.orange;
    }
  }

  String _getStatusText(KycStatusEnum status) {
    switch (status) {
      case KycStatusEnum.verified:
        return 'Verified';
      case KycStatusEnum.rejected:
        return 'Rejected';
      case KycStatusEnum.pendingAdminApproval:
        return 'Pending Admin Approval';
      case KycStatusEnum.inProgress:
        return 'In Progress';
      case KycStatusEnum.pending:
        return 'Pending';
    }
  }

  IconData _getStatusIcon(KycStatusEnum status) {
    switch (status) {
      case KycStatusEnum.verified:
        return Icons.verified;
      case KycStatusEnum.pendingAdminApproval:
        return Icons.pending_actions;
      case KycStatusEnum.rejected:
        return Icons.cancel;
      case KycStatusEnum.inProgress:
        return Icons.hourglass_top;
      case KycStatusEnum.pending:
        return Icons.pending_outlined;
    }
  }

  String? _getCurrentUserId() {
    final currentUser = _authStore.currentUser;
    final userId = currentUser?.id;
    return userId?.isNotEmpty == true ? userId : null;
  }

  Future<void> _showKycTypeSelection() async {
    final currentUser = _authStore.currentUser;
    
    if (currentUser == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please log in to continue with KYC verification'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    
    final userId = currentUser.id;
    
    if (userId?.isEmpty != false) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User information is incomplete. Please try logging out and back in.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => KycTypeSelectionSheet(
        onTypeSelected: (userType) async {
          try {
            await _kycStore.initializeKyc(userId!, userType);
            // Refresh KYC status after initialization
            await _loadKycStatus();
          } finally {
            // Close the bottom sheet
            if (sheetContext.mounted) {
              Navigator.of(sheetContext).pop();
            }
          }
        },
      ),
    );
  }

  void _showBvnVerificationSheet() {
    final userId = _getCurrentUserId();
    if (userId == null) return;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BvnVerificationSheet(
        kycStore: _kycStore,
        userId: userId,
        banks: _kycStore.banks,
      ),
    );
  }

  void _showDocumentUploadSheet() {
    final userId = _getCurrentUserId();
    if (userId == null) return;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DocumentUploadSheet(
        kycStore: _kycStore,
        userId: userId,
      ),
    );
  }

  void _showSelfieUploadSheet() {
    final userId = _getCurrentUserId();
    if (userId == null) return;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SelfieUploadSheet(
        kycStore: _kycStore,
        userId: userId,
      ),
    );
  }

  Widget _buildStatusBadge(KycStatusEnum status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing12, vertical: AppTheme.spacing6),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(AppTheme.radius20),
      ),
      child: Text(
        _getStatusText(status),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            value.split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '').join(' '),
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getTierIcon(KycTier tier) {
    switch (tier) {
      case KycTier.sprout:
        return Icons.eco_outlined;
      case KycTier.bloom:
        return Icons.local_florist_outlined;
      case KycTier.blossom:
        return Icons.spa_outlined;
      case KycTier.thrive:
        return Icons.emoji_events_outlined;
    }
  }

  IconData _getUserTypeIcon(KycUserType userType) {
    switch (userType) {
      case KycUserType.individual:
        return Icons.person_outlined;
      case KycUserType.enterprise:
        return Icons.business_outlined;
      case KycUserType.agent:
        return Icons.support_agent_outlined;
    }
  }

  Widget _buildLimitsInfo(KycStatusEntity status) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Limit',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing2),
                Text(
                  '₦${status.limits.dailyWithdrawal.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: AppTheme.dividerColor,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Max Balance',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing2),
                Text(
                  '₦${status.limits.maxWalletBalance.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        children: [
          Icon(Icons.check, color: AppTheme.primaryGreen, size: 16),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              benefit,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        children: [
          Icon(Icons.circle, color: AppTheme.warningColor, size: 6),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
