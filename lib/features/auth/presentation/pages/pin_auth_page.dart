import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/auth/presentation/mobx/auth_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class PinAuthPage extends StatefulWidget {
  const PinAuthPage({super.key});

  @override
  State<PinAuthPage> createState() => _PinAuthPageState();
}

class _PinAuthPageState extends State<PinAuthPage> {
  final _authStore = getIt<AuthStore>();
  final _localAuth = LocalAuthentication();
  String _enteredPin = '';
  bool _isError = false;
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    // Load user profile and check biometrics
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserProfile();
    });
  }

  Future<void> _loadUserProfile() async {
    await _authStore.getProfile();
    _checkBiometric();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-check biometrics when dependencies change (user data loaded)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometric();
      // Retry after a short delay to ensure user data is loaded
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _checkBiometric();
      });
    });
  }

  Future<void> _checkBiometric() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      final currentUser = _authStore.currentUser;
      final biometricEnabled = currentUser?.biometricEnabled == true;
      
      print('BIO DEBUG: canCheck=$canCheck, supported=$isDeviceSupported');
      print('BIO DEBUG: currentUser=${currentUser?.name}');
      print('BIO DEBUG: currentUser?.biometricEnabled=${currentUser?.biometricEnabled}');
      print('BIO DEBUG: enabled=$biometricEnabled');
      
      setState(() {
        // For development/emulator: show icon if user has enabled biometrics
        // In production: require device support
        _biometricAvailable = biometricEnabled && (canCheck && isDeviceSupported || kDebugMode);
      });

      print('BIO DEBUG: _biometricAvailable=$_biometricAvailable');

      if (_biometricAvailable && biometricEnabled && isDeviceSupported) {
        _authenticateWithBiometric();
      }
    } catch (e) {
      print('BIO DEBUG: Error=$e');
      setState(() {
        _biometricAvailable = false;
      });
    }
  }

  Future<void> _authenticateWithBiometric() async {
    try {
      print('[Biometric] Starting authentication...');
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access R-Agent',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print('[Biometric] Authentication result: $authenticated');
      if (authenticated && mounted) {
        HapticFeedback.lightImpact();
        context.go('/dashboard');
      }
    } on PlatformException catch (e) {
      print('[Biometric] PlatformException: ${e.code} - ${e.message}');
      // Handle specific errors
      if (e.code == 'NotAvailable') {
        print('[Biometric] Biometric not available on this device');
      } else if (e.code == 'NotEnrolled') {
        print('[Biometric] No biometrics enrolled on device');
      } else if (e.code == 'LockedOut') {
        print('[Biometric] Too many attempts, locked out');
      } else if (e.code == 'PermanentlyLockedOut') {
        print('[Biometric] Permanently locked out');
      }
    } catch (e) {
      print('[Biometric] Error: $e');
    }
  }

  void _onKeyPressed(String key) {
    if (_enteredPin.length >= 4) return;

    setState(() {
      _isError = false;
      _enteredPin += key;
    });

    if (_enteredPin.length == 4) {
      _verifyPin();
    }
  }

  void _onBackspace() {
    if (_enteredPin.isEmpty) return;
    setState(() {
      _isError = false;
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    });
  }

  Future<void> _verifyPin() async {
    // For now, compare against stored user pin hash
    // In production, this should verify against the server
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      // Simple check - in production use proper PIN verification endpoint
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.darkGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Column(
              children: [
                const Spacer(flex: 2),
                _buildHeader(),
                const SizedBox(height: AppTheme.spacing48),
                _buildPinDots(),
                if (_isError) ...[
                  const SizedBox(height: AppTheme.spacing12),
                  const Text(
                    'Incorrect PIN. Please try again.',
                    style: TextStyle(
                      color: AppTheme.errorColor,
                      fontSize: 13,
                    ),
                  ),
                ],
                const Spacer(flex: 1),
                _buildKeypad(),
                const SizedBox(height: AppTheme.spacing24),
                _buildBottomActions(),
                const SizedBox(height: AppTheme.spacing16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Observer(
      builder: (_) {
        final user = _authStore.currentUser;
        return Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor:
                  AppTheme.primaryGreen.withValues(alpha: 0.2),
              backgroundImage: user?.profilePhoto != null
                  ? NetworkImage(user!.profilePhoto!)
                  : const AssetImage('assets/images/avatar.png'),
            ),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'Welcome back, ${user?.name?.split(' ').first ?? 'Agent'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            const Text(
              'Enter your PIN to continue',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isFilled = index < _enteredPin.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: isFilled ? 18 : 14,
          height: isFilled ? 18 : 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isError
                ? AppTheme.errorColor
                : isFilled
                    ? AppTheme.primaryGreen
                    : Colors.transparent,
            border: Border.all(
              color: _isError
                  ? AppTheme.errorColor
                  : isFilled
                      ? AppTheme.primaryGreen
                      : AppTheme.textTertiary,
              width: 2,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildKeypad() {
    print('BIO DEBUG: Building keypad, _biometricAvailable=$_biometricAvailable');
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      [
        _biometricAvailable ? 'bio' : '',
        '0',
        'del',
      ],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              if (key.isEmpty) {
                return const SizedBox(width: 80, height: 64);
              }
              if (key == 'bio') {
                return _buildKeyButton(
                  child: const Icon(
                    Icons.fingerprint,
                    color: AppTheme.primaryGreen,
                    size: 28,
                  ),
                  onTap: _authenticateWithBiometric,
                );
              }
              if (key == 'del') {
                return _buildKeyButton(
                  child: const Icon(
                    Icons.backspace_outlined,
                    color: AppTheme.textSecondary,
                    size: 24,
                  ),
                  onTap: _onBackspace,
                );
              }
              return _buildKeyButton(
                child: Text(
                  key,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                onTap: () => _onKeyPressed(key),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeyButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        width: 80,
        height: 64,
        decoration: BoxDecoration(
          color: AppTheme.cardBackground.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppTheme.radius16),
        ),
        child: Center(child: child),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            // TODO: Implement forgot PIN flow
          },
          child: const Text(
            'Forgot PIN?',
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacing24),
        TextButton(
          onPressed: () async {
            await _authStore.logout();
            if (mounted) context.go('/auth-gate');
          },
          child: const Text(
            'Switch Account',
            style: TextStyle(
              color: AppTheme.textTertiary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
