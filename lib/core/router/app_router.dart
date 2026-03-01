import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/features/auth/presentation/pages/animated_splash_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/auth_gate_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/initial_screen.dart';
import 'package:recliq_agent/features/auth/presentation/pages/login_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/pin_auth_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/register_page.dart';
import 'package:recliq_agent/features/auth/presentation/pages/welcome_page.dart';
import 'package:recliq_agent/features/activity/presentation/pages/activity_page.dart';
import 'package:recliq_agent/features/availability/presentation/pages/availability_schedule_page.dart';
import 'package:recliq_agent/features/bonuses/presentation/pages/bonuses_page.dart';
import 'package:recliq_agent/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:recliq_agent/features/disputes/presentation/pages/disputes_page.dart';
import 'package:recliq_agent/features/insights/presentation/pages/insights_page.dart';
import 'package:recliq_agent/features/jobs/presentation/pages/jobs_page.dart';
import 'package:recliq_agent/features/performance/presentation/pages/performance_page.dart';
import 'package:recliq_agent/features/profile/presentation/pages/profile_page.dart';
import 'package:recliq_agent/features/vehicle_details/presentation/pages/vehicle_details_page.dart';
import 'package:recliq_agent/features/wallet/presentation/pages/wallet_page.dart';
import 'package:recliq_agent/features/wallet/presentation/pages/bank_accounts_page.dart';
import 'package:recliq_agent/features/zones/presentation/pages/service_radius_page.dart';
import 'package:recliq_agent/shared/widgets/app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InitialScreen(),
    ),
    GoRoute(
      path: '/animated-splash',
      builder: (context, state) => const AnimatedSplashPage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/auth-gate',
      builder: (context, state) => const AuthGatePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return OtpVerificationPage(
          identifier: extra?['identifier'] as String? ?? '',
        );
      },
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/pin-auth',
      builder: (context, state) => const PinAuthPage(),
    ),
    GoRoute(
      path: '/dashboard',
      redirect: (context, state) => '/shell/dashboard',
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/jobs',
              builder: (context, state) => const JobsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/wallet',
              builder: (context, state) => const WalletPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/performance',
              builder: (context, state) => const PerformancePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/insights',
              builder: (context, state) => const InsightsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/bonuses',
              builder: (context, state) => const BonusesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/disputes',
              builder: (context, state) => const DisputesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shell/profile',
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: '/availability',
                  builder: (context, state) => const AvailabilitySchedulePage(),
                ),
                GoRoute(
                  path: '/service-radius',
                  builder: (context, state) => const ServiceRadiusPage(),
                ),
                GoRoute(
                  path: '/bank-accounts',
                  builder: (context, state) => const BankAccountsPage(),
                ),
                GoRoute(
                  path: '/vehicle-details',
                  builder: (context, state) => const VehicleDetailsPage(),
                ),
                GoRoute(
                  path: '/activity',
                  builder: (context, state) => const ActivityPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
