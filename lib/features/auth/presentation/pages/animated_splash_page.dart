import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recliq_agent/features/auth/domain/usecases/get_onboarding_status.dart';
import 'package:recliq_agent/features/auth/presentation/pages/welcome_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/login_page.dart';

class AnimatedSplashPage extends StatefulWidget {
  const AnimatedSplashPage({super.key});

  @override
  State<AnimatedSplashPage> createState() => _AnimatedSplashPageState();
}

class _AnimatedSplashPageState extends State<AnimatedSplashPage> {
  late final GetOnboardingStatus _getOnboardingStatus;
  Widget? _nextScreen;

  @override
  void initState() {
    super.initState();
    _getOnboardingStatus = GetIt.instance<GetOnboardingStatus>();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final isCompleted = await _getOnboardingStatus();
    setState(() {
      _nextScreen = isCompleted ? const LoginPage() : const WelcomePage();
    });

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _nextScreen != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => _nextScreen!),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset('assets/images/app-icon-v2-color.png'),
      ),
    );
  }
}
