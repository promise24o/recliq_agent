import 'package:get_it/get_it.dart';
import '../../domain/repositories/kyc_repository.dart';
import '../../data/repositories/kyc_repository_impl.dart';
import '../../presentation/mobx/kyc_store.dart';

final GetIt getIt = GetIt.instance;

void setupKycDI() {
  // Repository
  getIt.registerLazySingleton<KycRepository>(
    () => KycRepositoryImpl(getIt()),
  );

  // Store
  getIt.registerFactory<KycStore>(
    () => KycStore(),
  );
}
