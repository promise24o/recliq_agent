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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authStore = getIt<AuthStore>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    _authStore.clearMessages();
    await _authStore.forgotPassword(email: _emailController.text.trim());

    if (!mounted) return;

    if (_authStore.hasError) {
      Fluttertoast.showToast(
        msg: _authStore.errorMessage!,
        backgroundColor: AppTheme.errorColor,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Reset OTP sent to your email',
        backgroundColor: AppTheme.successColor,
      );
      context.push('/reset-password', extra: {
        'email': _emailController.text.trim(),
      });
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
                      const Text(
                        'Enter your email to receive a password reset OTP',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing48),
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
                        onEditingComplete: _handleSubmit,
                      ),
                      const SizedBox(height: AppTheme.spacing32),
                      GradientButton(
                        text: 'Send Reset OTP',
                        onPressed: _handleSubmit,
                        isLoading: _authStore.isLoading,
                      ),
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
