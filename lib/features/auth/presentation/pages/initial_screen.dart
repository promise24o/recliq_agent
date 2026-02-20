import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:recliq_agent/features/auth/domain/usecases/get_onboarding_status.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late final GetOnboardingStatus _getOnboardingStatus;
  late final AuthStore _authStore;

  @override
  void initState() {
    super.initState();
    _getOnboardingStatus = GetIt.instance<GetOnboardingStatus>();
    _authStore = GetIt.instance<AuthStore>();
    _checkOnboardingAndNavigate();
  }

  Future<void> _checkOnboardingAndNavigate() async {
    // Add a small delay to prevent flash
    await Future.delayed(const Duration(milliseconds: 3000));

    final isCompleted = await _getOnboardingStatus();

    if (mounted) {
      if (isCompleted) {
        // Onboarding completed, check if user is logged in
        final isLoggedIn = await _authStore.checkAuthStatus();

        if (isLoggedIn) {
          // User is logged in, get profile and redirect to PIN authentication
          await _authStore.getProfile();
          context.go('/pin-auth');
        } else {
          // User is not logged in, show auth gate
          context.go('/auth-gate');
        }
      } else {
        // First time user, show welcome screen
        context.go('/welcome');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/logo-animation.json',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            print('Lottie error: $error');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app-launcher-agent.png',
                  width: 120,
                  height: 120,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.recycling_rounded,
                      size: 80,
                      color: Color(0xFF00D09C),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Recliq-Agent',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00D09C),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
