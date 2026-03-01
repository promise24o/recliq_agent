import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ChangePinBottomSheet extends StatefulWidget {
  const ChangePinBottomSheet({super.key});

  @override
  State<ChangePinBottomSheet> createState() => _ChangePinBottomSheetState();
}

class _ChangePinBottomSheetState extends State<ChangePinBottomSheet> {
  final currentPinController = TextEditingController();
  final newPinController = TextEditingController();
  final confirmPinController = TextEditingController();
  bool isLoading = false;
  bool obscureCurrentPin = true;
  bool obscureNewPin = true;
  bool obscureConfirmPin = true;
  final AuthStore _authStore = getIt<AuthStore>();

  @override
  void dispose() {
    currentPinController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100, // Extra space for floating navbar
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
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
            
            // Header
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
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change PIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Update your 4-digit transaction PIN',
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

            // Current PIN
            TextField(
              controller: currentPinController,
              obscureText: obscureCurrentPin,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'Current PIN',
                hintText: 'Enter your current 4-digit PIN',
                prefixIcon: const Icon(Icons.pin_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureCurrentPin ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.textTertiary,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureCurrentPin = !obscureCurrentPin;
                    });
                  },
                ),
                counterText: '',
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),

            // New PIN
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

            // Confirm PIN
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
            const SizedBox(height: AppTheme.spacing24),

            // Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleUpdatePin,
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
                        'Update PIN',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height:30)
          ],
        ),
      ),
    );
  }

  Future<void> _handleUpdatePin() async {
    if (currentPinController.text.isEmpty ||
        newPinController.text.isEmpty ||
        confirmPinController.text.isEmpty) {
      ToastHelper.showToast(context,  'Please fill all fields');
      return;
    }

    if (currentPinController.text.length != 4 ||
        newPinController.text.length != 4 ||
        confirmPinController.text.length != 4) {
      ToastHelper.showToast(context,  'PIN must be exactly 4 digits');
      return;
    }

    if (newPinController.text != confirmPinController.text) {
      ToastHelper.showToast(context,  'PINs do not match');
      return;
    }

    setState(() => isLoading = true);

    try {
      await _authStore.updatePin(
        oldPin: currentPinController.text,
        newPin: newPinController.text,
      );
      
      if (mounted) {
        ToastHelper.showToast(context,  'PIN updated successfully');
        Navigator.pop(context);
      }
    } catch (e) {
      ToastHelper.showToast(context,  'Failed to update PIN');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
