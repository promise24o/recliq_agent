import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/utils/validators.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/custom_text_field.dart';
import 'package:recliq_agent/shared/widgets/gradient_button.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralController = TextEditingController();
  final _authStore = getIt<AuthStore>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    _authStore.clearMessages();
    await _authStore.register(
      name: _nameController.text.trim(),
      identifier: _identifierController.text.trim(),
      password: _passwordController.text,
      referralCode: _referralController.text.trim().isNotEmpty
          ? _referralController.text.trim()
          : null,
    );

    if (!mounted) return;

    if (_authStore.hasError) {
      Fluttertoast.showToast(
        msg: _authStore.errorMessage!,
        backgroundColor: AppTheme.errorColor,
      );
    } else if (_authStore.requiresOtp) {
      context.push('/otp-verification', extra: {
        'identifier': _identifierController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => LoadingOverlay(
        isVisible: _authStore.isLoading,
        message: 'Creating account...',
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
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Container(
                              padding:
                                  const EdgeInsets.all(AppTheme.spacing8),
                              decoration: BoxDecoration(
                                color: AppTheme.cardBackground,
                                borderRadius: BorderRadius.circular(
                                    AppTheme.radius12),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing24),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      const Text(
                        'Register as a Recliq collection agent',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing32),
                      CustomTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        validator: Validators.validateName,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: AppTheme.textTertiary,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      CustomTextField(
                        controller: _identifierController,
                        label: 'Email or Phone',
                        hint: 'Enter your email or phone number',
                        validator: Validators.validateIdentifier,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppTheme.textTertiary,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Min 8 characters',
                        validator: Validators.validatePassword,
                        obscureText: _obscurePassword,
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: AppTheme.textTertiary,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppTheme.textTertiary,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Re-enter your password',
                        obscureText: _obscureConfirm,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return Validators.validatePassword(value);
                        },
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: AppTheme.textTertiary,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppTheme.textTertiary,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirm = !_obscureConfirm;
                            });
                          },
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      CustomTextField(
                        controller: _referralController,
                        label: 'Referral Code (Optional)',
                        hint: 'Enter referral code',
                        prefixIcon: const Icon(
                          Icons.card_giftcard_outlined,
                          color: AppTheme.textTertiary,
                        ),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: _handleRegister,
                      ),
                      const SizedBox(height: AppTheme.spacing32),
                      GradientButton(
                        text: 'Create Account',
                        onPressed: _handleRegister,
                        isLoading: _authStore.isLoading,
                      ),
                      const SizedBox(height: AppTheme.spacing24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: AppTheme.primaryGreen,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing24),
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
