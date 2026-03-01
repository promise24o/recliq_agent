// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/activity/data/datasources/activity_remote_datasource.dart'
    as _i747;
import '../../features/activity/data/datasources/activity_remote_datasource_impl.dart'
    as _i570;
import '../../features/activity/data/di/activity_di.dart' as _i68;
import '../../features/activity/data/repositories/activity_repository_impl.dart'
    as _i8;
import '../../features/activity/domain/repositories/activity_repository.dart'
    as _i387;
import '../../features/activity/presentation/mobx/activity_store.dart'
    as _i1038;
import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_onboarding_status.dart'
    as _i375;
import '../../features/auth/domain/usecases/get_profile_usecase.dart' as _i568;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/domain/usecases/verify_otp_usecase.dart' as _i503;
import '../../features/auth/presentation/mobx/auth_store.dart' as _i76;
import '../../features/availability/data/repositories/availability_repository_impl.dart'
    as _i116;
import '../../features/availability/domain/repositories/availability_repository.dart'
    as _i430;
import '../../features/availability/presentation/mobx/availability_store.dart'
    as _i1049;
import '../../features/dashboard/data/datasources/dashboard_remote_datasource.dart'
    as _i817;
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i509;
import '../../features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i665;
import '../../features/dashboard/presentation/mobx/dashboard_store.dart'
    as _i526;
import '../../features/jobs/data/datasources/jobs_remote_datasource.dart'
    as _i937;
import '../../features/jobs/data/repositories/jobs_repository_impl.dart'
    as _i150;
import '../../features/jobs/domain/repositories/jobs_repository.dart' as _i973;
import '../../features/jobs/presentation/mobx/jobs_store.dart' as _i11;
import '../../features/performance/data/datasources/performance_remote_datasource.dart'
    as _i540;
import '../../features/performance/data/repositories/performance_repository_impl.dart'
    as _i239;
import '../../features/performance/domain/repositories/performance_repository.dart'
    as _i323;
import '../../features/performance/presentation/mobx/performance_store.dart'
    as _i249;
import '../../features/vehicle_details/data/repositories/vehicle_details_repository_impl.dart'
    as _i745;
import '../../features/vehicle_details/di/vehicle_details_module.dart' as _i63;
import '../../features/vehicle_details/domain/repositories/vehicle_details_repository.dart'
    as _i873;
import '../../features/vehicle_details/presentation/mobx/vehicle_details_store.dart'
    as _i194;
import '../../features/wallet/data/datasources/wallet_remote_datasource.dart'
    as _i684;
import '../../features/wallet/data/repositories/wallet_repository_impl.dart'
    as _i690;
import '../../features/wallet/domain/repositories/wallet_repository.dart'
    as _i571;
import '../../features/wallet/presentation/mobx/wallet_store.dart' as _i664;
import '../../features/zones/data/datasources/zones_remote_data_source.dart'
    as _i515;
import '../../features/zones/data/repositories/zones_repository_impl.dart'
    as _i131;
import '../../features/zones/domain/repositories/zones_repository.dart'
    as _i116;
import '../../features/zones/presentation/mobx/service_radius_store.dart'
    as _i539;
import '../network/dio_client.dart' as _i667;
import '../network/token_interceptor.dart' as _i34;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final activityModule = _$ActivityModule(this);
    final vehicleDetailsModule = _$VehicleDetailsModule(this);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
    );
    gh.factory<_i747.ActivityRemoteDataSource>(
      () => activityModule.activityRemoteDataSource,
    );
    gh.lazySingleton<_i34.TokenInterceptor>(
      () => _i34.TokenInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i375.GetOnboardingStatus>(
      () => _i375.GetOnboardingStatus(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i375.SetOnboardingComplete>(
      () => _i375.SetOnboardingComplete(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i387.ActivityRepository>(
      () => activityModule.activityRepository,
    );
    gh.lazySingleton<_i667.DioClient>(
      () => _i667.DioClient(gh<_i34.TokenInterceptor>()),
    );
    gh.lazySingleton<_i873.VehicleDetailsRepository>(
      () => vehicleDetailsModule.vehicleDetailsRepository,
    );
    gh.lazySingleton<_i540.PerformanceRemoteDataSource>(
      () => _i540.PerformanceRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i817.DashboardRemoteDataSource>(
      () => _i817.DashboardRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i430.AvailabilityRepository>(
      () => _i116.AvailabilityRepositoryImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i665.DashboardRepository>(
      () =>
          _i509.DashboardRepositoryImpl(gh<_i817.DashboardRemoteDataSource>()),
    );
    gh.lazySingleton<_i937.JobsRemoteDataSource>(
      () => _i937.JobsRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.factory<_i194.VehicleDetailsStore>(
      () => _i194.VehicleDetailsStore(gh<_i873.VehicleDetailsRepository>()),
    );
    gh.factory<_i526.DashboardStore>(
      () => _i526.DashboardStore(gh<_i665.DashboardRepository>()),
    );
    gh.lazySingleton<_i515.ZonesRemoteDataSource>(
      () => _i515.ZonesRemoteDataSourceImpl(dioClient: gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i1038.ActivityStore>(
      () => activityModule.getActivityStore(gh<_i387.ActivityRepository>()),
    );
    gh.lazySingleton<_i684.WalletRemoteDataSource>(
      () => _i684.WalletRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
      () => _i161.AuthRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i571.WalletRepository>(
      () => _i690.WalletRepositoryImpl(gh<_i684.WalletRemoteDataSource>()),
    );
    gh.factory<_i1049.AvailabilityStore>(
      () => _i1049.AvailabilityStore(gh<_i430.AvailabilityRepository>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i161.AuthRemoteDataSource>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i323.PerformanceRepository>(
      () => _i239.PerformanceRepositoryImpl(
        gh<_i540.PerformanceRemoteDataSource>(),
      ),
    );
    gh.factory<_i664.WalletStore>(
      () => _i664.WalletStore(gh<_i571.WalletRepository>()),
    );
    gh.lazySingleton<_i116.ZonesRepository>(
      () => _i131.ZonesRepositoryImpl(
        remoteDataSource: gh<_i515.ZonesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i973.JobsRepository>(
      () => _i150.JobsRepositoryImpl(gh<_i937.JobsRemoteDataSource>()),
    );
    gh.factory<_i249.PerformanceStore>(
      () => _i249.PerformanceStore(gh<_i323.PerformanceRepository>()),
    );
    gh.factory<_i941.RegisterUseCase>(
      () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i568.GetProfileUseCase>(
      () => _i568.GetProfileUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i503.VerifyOtpUseCase>(
      () => _i503.VerifyOtpUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i76.AuthStore>(
      () => _i76.AuthStore(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i539.ServiceRadiusStore>(
      () => _i539.ServiceRadiusStore(gh<_i116.ZonesRepository>()),
    );
    gh.factory<_i11.JobsStore>(
      () => _i11.JobsStore(gh<_i973.JobsRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$ActivityModule extends _i68.ActivityModule {
  _$ActivityModule(this._getIt);

  final _i174.GetIt _getIt;

  @override
  _i570.ActivityRemoteDataSourceImpl get activityRemoteDataSource =>
      _i570.ActivityRemoteDataSourceImpl();

  @override
  _i8.ActivityRepositoryImpl get activityRepository =>
      _i8.ActivityRepositoryImpl(_getIt<_i747.ActivityRemoteDataSource>());
}

class _$VehicleDetailsModule extends _i63.VehicleDetailsModule {
  _$VehicleDetailsModule(this._getIt);

  final _i174.GetIt _getIt;

  @override
  _i745.VehicleDetailsRepositoryImpl get vehicleDetailsRepository =>
      _i745.VehicleDetailsRepositoryImpl(_getIt<_i667.DioClient>());
}
