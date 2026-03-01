import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/shared/utils/toast_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/utils/validators.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/custom_text_field.dart';
import 'package:recliq_agent/shared/widgets/gradient_button.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authStore = getIt<AuthStore>();

  String? _emailError;
  String? _otpError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  bool _otpSent = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  String get _otpCode => _otpControllers.map((c) => c.text).join();

  @override
  void dispose() {
    _emailController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSendOtp() async {
    // Clear previous errors
    setState(() {
      _emailError = null;
    });

    bool hasError = false;

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = "Email is required";
      });
      hasError = true;
    }

    if (!_emailController.text.contains('@')) {
      setState(() {
        _emailError = "Please enter a valid email";
      });
      hasError = true;
    }

    if (hasError) return;

    await _authStore.forgotPassword(email: _emailController.text);

    if (mounted) {
      if (_authStore.hasError) {
        ToastHelper.showToast(
          context,
          _authStore.errorMessage!,
          backgroundColor: AppTheme.errorColor,
        );
      } else {
        ToastHelper.showToast(
          context,
          'Reset OTP sent to your email',
          backgroundColor: AppTheme.successColor,
        );
        setState(() {
          _otpSent = true;
        });
      }
    }
  }

  void _handleResetPassword() async {
    // Clear previous errors
    setState(() {
      _otpError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;
    });

    bool hasError = false;

    if (_otpCode.isEmpty) {
      setState(() {
        _otpError = "OTP is required";
      });
      hasError = true;
    }

    if (_otpCode.length != 6) {
      setState(() {
        _otpError = "OTP must be 6 digits";
      });
      hasError = true;
    }

    if (_newPasswordController.text.isEmpty) {
      setState(() {
        _newPasswordError = "New password is required";
      });
      hasError = true;
    }

    if (_newPasswordController.text.length < 8) {
      setState(() {
        _newPasswordError = "Password must be at least 8 characters";
      });
      hasError = true;
    }

    // Check password complexity
    if (!_newPasswordController.text.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        _newPasswordError = "Password must contain at least one uppercase letter";
      });
      hasError = true;
    }

    if (!_newPasswordController.text.contains(RegExp(r'[a-z]'))) {
      setState(() {
        _newPasswordError = "Password must contain at least one lowercase letter";
      });
      hasError = true;
    }

    if (!_newPasswordController.text.contains(RegExp(r'[0-9]'))) {
      setState(() {
        _newPasswordError = "Password must contain at least one number";
      });
      hasError = true;
    }

    if (!_newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        _newPasswordError = "Password must contain at least one special character";
      });
      hasError = true;
    }

    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = "Please confirm your password";
      });
      hasError = true;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = "Passwords do not match";
      });
      hasError = true;
    }

    if (hasError) return;

    await _authStore.resetPassword(
      email: _emailController.text,
      otp: _otpCode,
      newPassword: _newPasswordController.text,
    );

    if (mounted) {
      if (_authStore.hasError) {
        ToastHelper.showToast(
          context,
          _authStore.errorMessage!,
          backgroundColor: AppTheme.errorColor,
        );
      } else {
        ToastHelper.showToast(
          context,
          'Password reset successfully',
          backgroundColor: AppTheme.successColor,
        );
        // Navigate to login after successful reset
        context.pushReplacement('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => LoadingOverlay(
        isVisible: _authStore.isLoading,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
            child: Column(
              children: [
                const SafeArea(child: SizedBox()),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppTheme.spacing24),
                    child: Form(
                      key: _formKey,
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
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      Text(
                        _otpSent
                            ? 'Enter the OTP sent to your email and create a new password'
                            : 'Enter your email to receive a password reset OTP',
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing48),

                      // Email Field (only shown before OTP is sent)
                      if (!_otpSent) ...[
                        CustomTextField(
                          controller: _emailController,
                          label: 'Email Address',
                          hint: 'Enter your email',
                          validator: Validators.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppTheme.textTertiary,
                          ),
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _handleSendOtp,
                        ),
                        const SizedBox(height: AppTheme.spacing32),
                        GradientButton(
                          text: 'Send Reset OTP',
                          onPressed: _handleSendOtp,
                          isLoading: _authStore.isLoading,
                        ),
                      ],

                      // OTP and Password Fields (shown after OTP is sent)
                      if (_otpSent) ...[
                        // OTP PIN View
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) {
                            return SizedBox(
                              width: 48,
                              height: 56,
                              child: TextFormField(
                                controller: _otpControllers[index],
                                focusNode: _otpFocusNodes[index],
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
                                  if (_otpError != null) {
                                    setState(() {
                                      _otpError = null;
                                    });
                                  }
                                  if (value.isNotEmpty && index < 5) {
                                    _otpFocusNodes[index + 1].requestFocus();
                                  } else if (value.isEmpty && index > 0) {
                                    _otpFocusNodes[index - 1].requestFocus();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        if (_otpError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 12),
                            child: Text(
                              _otpError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        const SizedBox(height: AppTheme.spacing32),

                        // New Password Field
                        CustomTextField(
                          controller: _newPasswordController,
                          label: 'New Password',
                          hint: 'Enter new password',
                          obscureText: _obscureNewPassword,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: AppTheme.textTertiary,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                            icon: Icon(
                              _obscureNewPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppTheme.textTertiary,
                            ),
                          ),
                          onChanged: (value) {
                            if (_newPasswordError != null) {
                              setState(() {
                                _newPasswordError = null;
                              });
                            }
                          },
                        ),
                        if (_newPasswordError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 12),
                            child: Text(
                              _newPasswordError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        const SizedBox(height: AppTheme.spacing24),

                        // Confirm Password Field
                        CustomTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          hint: 'Confirm new password',
                          obscureText: _obscureConfirmPassword,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: AppTheme.textTertiary,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppTheme.textTertiary,
                            ),
                          ),
                          onChanged: (value) {
                            if (_confirmPasswordError != null) {
                              setState(() {
                                _confirmPasswordError = null;
                              });
                            }
                          },
                        ),
                        if (_confirmPasswordError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 12),
                            child: Text(
                              _confirmPasswordError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        const SizedBox(height: AppTheme.spacing32),

                        // Reset Password Button
                        GradientButton(
                          text: 'Reset Password',
                          onPressed: _handleResetPassword,
                          isLoading: _authStore.isLoading,
                        ),
                        const SizedBox(height: AppTheme.spacing16),

                        // Resend OTP
                        Center(
                          child: TextButton(
                            onPressed: _authStore.isLoading ? null : _handleSendOtp,
                            child: Text(
                              'Didn\'t receive OTP? Resend',
                              style: TextStyle(
                                color: AppTheme.primaryGreen,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                      ),
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
