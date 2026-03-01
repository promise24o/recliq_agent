import 'package:flutter/material.dart';
import 'package:recliq_agent/features/profile/presentation/widgets/reset_password_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ResetPasswordBottomSheet(email: email),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
