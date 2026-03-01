import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ResetPasswordBottomSheet extends StatefulWidget {
  final String email;
  const ResetPasswordBottomSheet({super.key, required this.email});

  @override
  State<ResetPasswordBottomSheet> createState() => _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  final AuthStore _authStore = getIt<AuthStore>();

  @override
  void dispose() {
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Icons.lock_reset,
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
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Enter OTP and new password',
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
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: 'OTP Code',
                hintText: 'Enter 6-digit OTP',
                prefixIcon: Icon(Icons.sms_outlined),
                counterText: '',
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),

            TextField(
              controller: newPasswordController,
              obscureText: obscureNewPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter your new password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.textTertiary,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureNewPassword = !obscureNewPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),

            TextField(
              controller: confirmPasswordController,
              obscureText: obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                hintText: 'Confirm your new password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.textTertiary,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleResetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Reset Password',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ],
        ),
      );
  }

  Future<void> _handleResetPassword() async {
    if (otpController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ToastHelper.showToast(context,  'Please fill all fields');
      return;
    }

    if (otpController.text.length != 6) {
      ToastHelper.showToast(context,  'OTP must be 6 digits');
      return;
    }

    if (newPasswordController.text.length < 6) {
      ToastHelper.showToast(context,  'Password must be at least 6 characters');
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      ToastHelper.showToast(context,  'Passwords do not match');
      return;
    }

    setState(() => isLoading = true);

    try {
      await _authStore.resetPasswordWithOtp(
        email: widget.email,
        otp: otpController.text,
        newPassword: newPasswordController.text,
      );
      
      if (mounted) {
        ToastHelper.showToast(context,  'Password reset successfully');
        Navigator.pop(context);
        context.go('/login');
      }
    } catch (e) {
      ToastHelper.showToast(context,  'Failed to reset password');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
