import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/core/services/fcm_service.dart';
import 'package:recliq_agent/core/services/location_manager.dart';
import 'package:recliq_agent/core/services/websocket_manager.dart';
import 'package:recliq_agent/core/services/agent_location_service.dart';
import 'package:recliq_agent/core/router/app_router.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.surfaceColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  await configureDependencies();

  // Register Location Services (singletons - shared across app)
  final locationManager = LocationManager();
  final webSocketManager = WebSocketManager();
  final agentLocationService = AgentLocationService(
    locationManager: locationManager,
    webSocketManager: webSocketManager,
    dioClient: getIt<DioClient>(),
    secureStorage: getIt<FlutterSecureStorage>(),
  );
  getIt.registerSingleton<LocationManager>(locationManager);
  getIt.registerSingleton<WebSocketManager>(webSocketManager);
  getIt.registerSingleton<AgentLocationService>(agentLocationService);

  // Initialize FCM service
  final fcmService = getIt<FcmService>();
  await fcmService.initialize();
  fcmService.listenForTokenRefresh();

  // Set up FCM navigation callbacks
  fcmService.onNavigateToPickup = (pickupId) {
    appRouter.push('/pickup/$pickupId');
  };
  fcmService.onNavigateToPendingPickups = () {
    appRouter.push('/pickups');
  };
  fcmService.onNavigateToWallet = () {
    appRouter.push('/shell/wallet');
  };
  fcmService.onNavigateToDashboard = () {
    appRouter.push('/shell/dashboard');
  };
  fcmService.onNavigateToKyc = () {
    appRouter.push('/shell/kyc');
  };

  runApp(const RAgentApp());
}

class RAgentApp extends StatelessWidget {
  const RAgentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Recliq-Agent',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: appRouter,
        );
      },
    );
  }
}
