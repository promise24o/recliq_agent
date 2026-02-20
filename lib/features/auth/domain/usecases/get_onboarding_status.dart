import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOnboardingStatus {
  final FlutterSecureStorage _secureStorage;

  static const String _onboardingKey = 'onboarding_completed';

  GetOnboardingStatus(this._secureStorage);

  Future<bool> call() async {
    final value = await _secureStorage.read(key: _onboardingKey);
    return value == 'true';
  }
}

@injectable
class SetOnboardingComplete {
  final FlutterSecureStorage _secureStorage;

  static const String _onboardingKey = 'onboarding_completed';

  SetOnboardingComplete(this._secureStorage);

  Future<void> call() async {
    await _secureStorage.write(key: _onboardingKey, value: 'true');
  }
}
