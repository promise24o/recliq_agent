import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/features/profile/presentation/widgets/change_password_bottom_sheet.dart';
import 'package:recliq_agent/features/profile/presentation/widgets/change_pin_bottom_sheet.dart';
import 'package:recliq_agent/features/profile/presentation/widgets/edit_profile_bottom_sheet.dart';
import 'package:recliq_agent/features/profile/presentation/widgets/forgot_password_bottom_sheet.dart';
import 'package:recliq_agent/features/profile/presentation/widgets/forgot_pin_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/features/profile/presentation/pages/faq_page.dart';
import 'package:recliq_agent/features/profile/presentation/pages/terms_conditions_page.dart';
import 'package:recliq_agent/features/profile/presentation/pages/privacy_policy_page.dart';
import 'package:recliq_agent/features/kyc/presentation/pages/kyc_page.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/glass_card.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authStore = GetIt.instance<AuthStore>();
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _authStore.getProfile();
  }

  Future<void> _handleRefresh() async {
    await _authStore.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecliqAppBar(
        title: 'Profile & Settings',
        showNotifications: true,
        showBackButton: false,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: Observer(
          builder: (_) {
            final user = _authStore.currentUser;
            return RefreshIndicator(
              onRefresh: _handleRefresh,
              color: AppTheme.primaryGreen,
              backgroundColor: AppTheme.cardBackground,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppTheme.spacing16),
                child: Column(
                  children: [
                    _buildProfileHeader(user),
                    const SizedBox(height: AppTheme.spacing24),
                    _buildAccountSection(),
                    const SizedBox(height: AppTheme.spacing16),
                    _buildSecuritySection(),
                    const SizedBox(height: AppTheme.spacing16),
                    _buildPreferencesSection(),
                    const SizedBox(height: AppTheme.spacing16),
                    _buildSupportSection(),
                    const SizedBox(height: AppTheme.spacing24),
                    _buildLogoutButton(),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(dynamic user) {
    return Observer(
      builder: (_) {
        final currentUser = _authStore.currentUser;
        return GlassCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          // Avatar Section
          GestureDetector(
            onTap: _pickProfilePhoto,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor:
                      AppTheme.primaryGreen.withValues(alpha: 0.2),
                  backgroundImage: currentUser?.profilePhoto != null
                      ? NetworkImage(currentUser!.profilePhoto!)
                      : const AssetImage('assets/images/avatar.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          
          // Text Content Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser?.name ?? 'Agent',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentUser?.email ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                if (currentUser?.phone != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    currentUser!.phone!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppTheme.spacing12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing12,
                        vertical: AppTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppTheme.radius16),
                      ),
                      child: Text(
                        currentUser?.role ?? 'AGENT',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                    if (currentUser?.referralCode != null) ...[
                      const SizedBox(width: AppTheme.spacing8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing12,
                          vertical: AppTheme.spacing4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.cardBackground,
                          borderRadius: BorderRadius.circular(AppTheme.radius16),
                        ),
                        child: Text(
                          'Ref: ${currentUser!.referralCode}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ),
                    ],
                  ],
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

  Widget _buildAccountSection() {
    return _buildSection(
      'Account',
      [
        _buildSettingItem(
          Icons.person_outline,
          'Edit Profile',
          'Update your personal information',
          onTap: () => _showEditProfileBottomSheet(),
        ),
        _buildSettingItem(
          Icons.location_on_outlined,
          'Service Radius',
          'Set your working area',
          onTap: () {
            context.go('/shell/profile/service-radius');
          },
        ),
        _buildSettingItem(
          Icons.schedule,
          'Availability Schedule',
          'Set your working hours',
          onTap: () {
            context.go('/shell/profile/availability');
          },
        ),
        _buildSettingItem(
          Icons.directions_car_outlined,
          'Vehicle Details',
          'Manage your vehicle info',
          onTap: () => context.go('/shell/profile/vehicle-details'),
        ),
        _buildSettingItem(
          Icons.account_balance_outlined,
          'Bank Accounts',
          'Manage payment methods',
          onTap: () => context.go('/shell/profile/bank-accounts'),
        ),
        _buildSettingItem(
          Icons.history_outlined,
          'Activity',
          'View your activity',
          onTap: () => context.go('/shell/profile/activity'),
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Observer(
      builder: (_) {
        final user = _authStore.currentUser;
        return _buildSection(
          'Security',
          [
            _buildSettingItem(
              Icons.lock_outline,
              'Change Password',
              'Update your password',
              onTap: () => _showChangePasswordBottomSheet(),
            ),
            _buildSettingItem(
              Icons.pin_outlined,
              'Change PIN',
              'Update your transaction PIN',
              onTap: () => _showChangePinBottomSheet(),
            ),
            _buildSettingItem(
              Icons.lock_reset,
              'Forgot Password',
              'Reset your password via email',
              onTap: () => _showForgotPasswordBottomSheet(),
            ),
            _buildSettingItem(
              Icons.pin_outlined,
              'Forgot PIN',
              'Reset your PIN via email',
              onTap: () => _showForgotPinBottomSheet(),
            ),
            _buildSettingItem(
              Icons.fingerprint,
              'Biometric Login',
              user?.biometricEnabled == true ? 'Enabled' : 'Disabled',
              trailing: Switch(
                value: user?.biometricEnabled ?? false,
                onChanged: (value) {
                  _authStore.toggleBiometric(enabled: value);
                },
                activeThumbColor: AppTheme.primaryGreen,
              ),
            ),
            _buildSettingItem(
              Icons.verified_user_outlined,
              'KYC Verification',
              'Complete your verification',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KycPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPreferencesSection() {
    return Observer(
      builder: (_) {
        final user = _authStore.currentUser;
        return _buildSection(
          'Preferences',
          [
            _buildSettingItem(
              Icons.notifications_outlined,
              'Price Updates',
              'Get notified about price changes',
              trailing: Switch(
                value: user?.notifications?.priceUpdates ?? true,
                onChanged: (value) {
                  _authStore.updateProfile(priceUpdates: value);
                },
                activeThumbColor: AppTheme.primaryGreen,
              ),
            ),
            _buildSettingItem(
              Icons.email_outlined,
              'Login Emails',
              'Receive login notification emails',
              trailing: Switch(
                value: user?.notifications?.loginEmails ?? true,
                onChanged: (value) {
                  _authStore.updateProfile(loginEmails: value);
                },
                activeThumbColor: AppTheme.primaryGreen,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSupportSection() {
    return _buildSection(
      'Support',
      [
        _buildSettingItem(
          Icons.headset_mic_outlined,
          'Support Chat',
          'Get help from our team',
          onTap: () {},
        ),
        _buildSettingItem(
          Icons.help_outline,
          'FAQ',
          'Frequently asked questions',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FAQPage(),
              ),
            );
          },
        ),
        _buildSettingItem(
          Icons.description_outlined,
          'Terms & Conditions',
          'Read our terms',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsConditionsPage(),
              ),
            );
          },
        ),
        _buildSettingItem(
          Icons.privacy_tip_outlined,
          'Privacy Policy',
          'Read our privacy policy',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicyPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(AppTheme.radius16),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radius12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing12,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textTertiary,
                  size: 20,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _handleLogout,
        icon: const Icon(Icons.logout, size: 18),
        label: const Text('Logout'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.errorColor,
          side: const BorderSide(color: AppTheme.errorColor),
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius12),
          ),
        ),
      ),
    );
  }

  Future<void> _pickProfilePhoto() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (image != null) {
      await _authStore.uploadPhoto(filePath: image.path);
      if (_authStore.successMessage != null) {
        ToastHelper.showToast(
          context,
          'Photo updated successfully',
          backgroundColor: AppTheme.successColor,
        );
      }
    }
  }

  Future<void> _handleLogout() async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius20),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppTheme.spacing20),
            
            // Icon
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout,
                color: AppTheme.errorColor,
                size: 32,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Title
            const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            
            // Content
            const Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.dividerColor),
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppTheme.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
          ],
        ),
      ),
    );

    if (confirmed == true && mounted) {
      await _authStore.logout();
      if (mounted) {
        context.go('/login');
      }
    }
  }

  void _showChangePasswordBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChangePasswordBottomSheet(),
    );
  }

  void _showChangePinBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChangePinBottomSheet(),
    );
  }

  void _showForgotPasswordBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ForgotPasswordBottomSheet(),
    );
  }

  void _showForgotPinBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ForgotPinBottomSheet(),
    );
  }

  void _showEditProfileBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EditProfileBottomSheet(),
    );
  }
}
