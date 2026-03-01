import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/gradient_button.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class OtpVerificationPage extends StatefulWidget {
  final String identifier;

  const OtpVerificationPage({super.key, required this.identifier});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _authStore = getIt<AuthStore>();
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _resendTimer;
  int _resendCountdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendCountdown = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  Future<void> _handleVerify() async {
    final otp = _otpCode;
    if (otp.length != 6) {
      ToastHelper.showToast(
        context,
        'Please enter the complete 6-digit OTP',
        backgroundColor: AppTheme.warningColor,
      );
      return;
    }

    _authStore.clearMessages();
    final success = await _authStore.verifyOtp(
      identifier: widget.identifier,
      otp: otp,
    );

    if (!mounted) return;

    if (_authStore.hasError) {
      ToastHelper.showToast(
        context,
        _authStore.errorMessage!,
        backgroundColor: AppTheme.errorColor,
      );
    } else if (success) {
      context.go('/dashboard');
    }
  }

  Future<void> _handleResend() async {
    if (!_canResend) return;

    _authStore.clearMessages();
    
    // Clear all input fields
    for (var controller in _controllers) {
      controller.clear();
    }
    
    // Reset focus to first field
    _focusNodes[0].requestFocus();
    
    await _authStore.resendOtp(identifier: widget.identifier);

    if (!mounted) return;

    if (_authStore.hasError) {
      ToastHelper.showToast(
        context,
        _authStore.errorMessage!,
        backgroundColor: AppTheme.errorColor,
      );
    } else {
      ToastHelper.showToast(
        context,
        'OTP resent successfully',
        backgroundColor: AppTheme.successColor,
      );
      _startResendTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => LoadingOverlay(
        isVisible: _authStore.isLoading,
        message: 'Verifying...',
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
            child: Column(
              children: [
                const SafeArea(child: SizedBox()),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppTheme.spacing24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const SizedBox(height: AppTheme.spacing24),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacing8),
                        decoration: BoxDecoration(
                          color: AppTheme.cardBackground,
                          borderRadius:
                              BorderRadius.circular(AppTheme.radius12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing32),
                    const Text(
                      'Verify OTP',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Text(
                      'Enter the 6-digit code sent to\n${widget.identifier}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 48,
                          height: 56,
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: AppTheme.cardBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppTheme.radius12),
                                borderSide: const BorderSide(
                                    color: AppTheme.dividerColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppTheme.radius12),
                                borderSide: const BorderSide(
                                  color: AppTheme.primaryGreen,
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                _focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                              if (_otpCode.length == 6) {
                                _handleVerify();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: AppTheme.spacing48),
                    GradientButton(
                      text: 'Verify',
                      onPressed: _handleVerify,
                      isLoading: _authStore.isLoading,
                    ),
                    const SizedBox(height: AppTheme.spacing24),
                    Center(
                      child: _canResend
                          ? GestureDetector(
                              onTap: _handleResend,
                              child: const Text(
                                'Resend OTP',
                                style: TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Text(
                              'Resend OTP in ${_resendCountdown}s',
                              style: const TextStyle(
                                color: AppTheme.textTertiary,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
