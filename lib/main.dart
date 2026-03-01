import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/core/router/app_router.dart';
import 'package:recliq_agent/core/services/agent_location_service.dart';
import 'package:recliq_agent/core/services/fcm_remote_data_source.dart';
import 'package:recliq_agent/core/services/fcm_service.dart';
import 'package:recliq_agent/core/services/location_manager.dart';
import 'package:recliq_agent/core/services/websocket_manager.dart';
import 'package:recliq_agent/features/activity/data/datasources/activity_remote_datasource_impl.dart';
import 'package:recliq_agent/features/activity/data/repositories/activity_repository_impl.dart';
import 'package:recliq_agent/features/activity/presentation/mobx/activity_store_simple.dart';
import 'package:recliq_agent/features/kyc/data/repositories/kyc_repository_impl.dart';
import 'package:recliq_agent/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:recliq_agent/features/kyc/presentation/mobx/kyc_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

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

  // Register FCM Services
  final fcmRemoteDataSource = FcmRemoteDataSource(
    getIt<DioClient>(),
    getIt<FlutterSecureStorage>(),
  );
  final fcmService = FcmService(
    getIt<FirebaseMessaging>(),
    fcmRemoteDataSource,
    getIt<SharedPreferences>(),
  );
  getIt.registerSingleton<FcmRemoteDataSource>(fcmRemoteDataSource);
  getIt.registerSingleton<FcmService>(fcmService);

  // Initialize FCM service
  await fcmService.initialize();
  fcmService.listenForTokenRefresh();

  // Manual registration for Activity feature
  final activityRemoteDataSource = ActivityRemoteDataSourceImpl();
  final activityRepository = ActivityRepositoryImpl(activityRemoteDataSource);
  getIt.registerFactory<ActivityStore>(() => ActivityStore(activityRepository));

  // Manual registration for KYC feature
  final kycRepository = KycRepositoryImpl(getIt());
  getIt.registerFactory<KycRepository>(() => kycRepository);
  getIt.registerFactory<KycStore>(() => KycStore());

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
