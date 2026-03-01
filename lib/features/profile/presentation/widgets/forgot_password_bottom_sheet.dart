import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  State<ForgotPasswordBottomSheet> createState() => _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  bool isLoading = false;
  final AuthStore _authStore = getIt<AuthStore>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _authStore.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final currentUser = _authStore.currentUser;
        final userEmail = currentUser?.email ?? '';
        
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
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Enter your email to receive OTP',
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
              controller: TextEditingController(text: userEmail),
              keyboardType: TextInputType.emailAddress,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Email from your profile',
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.1),
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleSendOtp,
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
                        'Send OTP',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height:30),
          ],
        ),
      ),
        );
      },
    );
  }

  Future<void> _handleSendOtp() async {
    final currentUser = _authStore.currentUser;
    final userEmail = currentUser?.email ?? '';
    
    if (userEmail.isEmpty) {
      ToastHelper.showToast(context,  'Email not available');
      return;
    }

    setState(() => isLoading = true);

    try {
      await _authStore.sendPasswordResetOtp(email: userEmail);
      
      if (mounted) {
        ToastHelper.showToast(context,  'OTP sent to your email');
        Navigator.pop(context);
        context.push('/reset-password?email=$userEmail');
      }
    } catch (e) {
      ToastHelper.showToast(context,  'Failed to send OTP');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
