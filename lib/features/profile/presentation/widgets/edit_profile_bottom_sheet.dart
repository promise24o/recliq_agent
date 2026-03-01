import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final AuthStore _authStore = getIt<AuthStore>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();
  
  String? _phoneError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authStore.getCurrentUser();
    _initializeControllers();
  }

  void _initializeControllers() {
    final user = _authStore.currentUser;
    if (user != null) {
      _nameController.text = user.name ?? '';
      String phone = user.phone ?? '';
      // Remove +234 prefix if present
      if (phone.startsWith('+234')) {
        phone = phone.substring(4);
      }
      _phoneController.text = '0$phone';
      _referralController.text = user.referralCode ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return 'Phone number must be 11 digits';
    }
    return null;
  }

  Future<void> _handleUpdateProfile() async {
    final phoneError = _validatePhone(_phoneController.text);
    if (phoneError != null) {
      setState(() => _phoneError = phoneError);
      return;
    }

    setState(() {
      _isLoading = true;
      _phoneError = null;
    });

    try {
      await _authStore.updateProfile(
        phone: _phoneController.text,
      );

      if (mounted) {
        ToastHelper.showToast(context, 'Profile updated successfully');
        Navigator.pop(context);
      }
    } catch (e) {
      ToastHelper.showToast(context, 'Failed to update profile');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final user = _authStore.currentUser;
        
        if (user != null && _nameController.text.isEmpty) {
          _initializeControllers();
        }

        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: AppTheme.spacing16,
              right: AppTheme.spacing16,
              top: AppTheme.spacing16,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing16),
                
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacing8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppTheme.radius8),
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: AppTheme.primaryGreen,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            'Update your personal information',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing24),

TextField(
                  controller: _nameController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Your full name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing16),

                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    errorText: _phoneError,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && !RegExp(r'^[0-9]*$').hasMatch(value)) {
                      _phoneController.text = value.replaceAll(RegExp(r'[^0-9]'), '');
                      _phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _phoneController.text.length),
                      );
                    }
                    setState(() => _phoneError = null);
                  },
                ),
                const SizedBox(height: AppTheme.spacing16),

                TextField(
                  controller: _referralController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Referral Code',
                    hintText: 'Your referral code',
                    prefixIcon: Icon(Icons.card_giftcard),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing8),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryGreen,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Share your referral code with friends to earn rewards!',
                          style: TextStyle(
                            color: AppTheme.primaryGreen,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacing24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleUpdateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Update Profile',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing24),
              ],
            ),
          ),
        );
      },
    );
  }
}
