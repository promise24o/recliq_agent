import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ForgotPinBottomSheet extends StatefulWidget {
  const ForgotPinBottomSheet({super.key});

  @override
  State<ForgotPinBottomSheet> createState() => _ForgotPinBottomSheetState();
}

class _ForgotPinBottomSheetState extends State<ForgotPinBottomSheet> {
  final otpController = TextEditingController();
  final newPinController = TextEditingController();
  final confirmPinController = TextEditingController();
  bool isLoading = false;
  bool showOtpField = false;
  bool obscureNewPin = true;
  bool obscureConfirmPin = true;
  final AuthStore _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _authStore.getCurrentUser();
  }

  @override
  void dispose() {
    otpController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    super.dispose();
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
                    Icons.pin_outlined,
                    color: AppTheme.primaryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forgot PIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        showOtpField ? 'Enter OTP and new PIN' : 'Enter your email to receive OTP',
                        style: const TextStyle(
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

            if (!showOtpField) ...[
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
            ] else ...[
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
                controller: newPinController,
                obscureText: obscureNewPin,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: 'New PIN',
                  hintText: 'Enter your new 4-digit PIN',
                  prefixIcon: const Icon(Icons.pin_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureNewPin ? Icons.visibility_off : Icons.visibility,
                      color: AppTheme.textTertiary,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureNewPin = !obscureNewPin;
                      });
                    },
                  ),
                  counterText: '',
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),

              TextField(
                controller: confirmPinController,
                obscureText: obscureConfirmPin,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: 'Confirm New PIN',
                  hintText: 'Confirm your new 4-digit PIN',
                  prefixIcon: const Icon(Icons.pin_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPin ? Icons.visibility_off : Icons.visibility,
                      color: AppTheme.textTertiary,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPin = !obscureConfirmPin;
                      });
                    },
                  ),
                  counterText: '',
                ),
              ),
            ],
            const SizedBox(height: AppTheme.spacing24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : (showOtpField ? _handleResetPin : _handleSendOtp),
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
                    : Text(
                        showOtpField ? 'Reset PIN' : 'Send OTP',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height:30)
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
      await _authStore.sendPinResetOtp(email: userEmail);
      
      if (mounted) {
        ToastHelper.showToast(context,  'OTP sent to your email');
        setState(() => showOtpField = true);
      }
    } catch (e) {
      ToastHelper.showToast(context,  'Failed to send OTP');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _handleResetPin() async {
    if (otpController.text.isEmpty ||
        newPinController.text.isEmpty ||
        confirmPinController.text.isEmpty) {
      ToastHelper.showToast(context,  'Please fill all fields');
      return;
    }

    if (otpController.text.length != 6) {
      ToastHelper.showToast(context,  'OTP must be 6 digits');
      return;
    }

    if (newPinController.text.length != 4 ||
        confirmPinController.text.length != 4) {
      ToastHelper.showToast(context,  'PIN must be exactly 4 digits');
      return;
    }

    if (newPinController.text != confirmPinController.text) {
      ToastHelper.showToast(context,  'PINs do not match');
      return;
    }

    setState(() => isLoading = true);

    final currentUser = _authStore.currentUser;
    final userEmail = currentUser?.email ?? '';
    
    try {
      await _authStore.forgotPin(
        email: userEmail,
        otp: otpController.text,
        newPin: newPinController.text,
      );
      
      if (mounted) {
        ToastHelper.showToast(context,  'PIN reset successfully');
        Navigator.pop(context);
        context.push('/pin-auth');
      }
    } catch (e) {
      ToastHelper.showToast(context,  'Failed to reset PIN');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
