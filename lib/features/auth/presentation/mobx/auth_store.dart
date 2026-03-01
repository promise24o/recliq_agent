import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/auth/domain/entities/user.dart';
import 'package:recliq_agent/features/auth/domain/repositories/auth_repository.dart';

part 'auth_store.g.dart';

@injectable
class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthRepository _repository;

  _AuthStore(this._repository);

  @observable
  User? currentUser;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  bool isAuthenticated = false;

  @observable
  bool requiresOtp = false;

  @observable
  String? pendingIdentifier;

  @computed
  bool get hasError => errorMessage != null;

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  @action
  Future<void> register({
    required String name,
    required String identifier,
    required String password,
    String? referralCode,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.register(
      name: name,
      identifier: identifier,
      password: password,
      referralCode: referralCode,
    );

    result.fold(
      (failure) => errorMessage = failure.message,
      (response) {
        requiresOtp = response.requiresOtp;
        pendingIdentifier = identifier;
        successMessage = response.message;
      },
    );

    isLoading = false;
  }

  @action
  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.login(
      identifier: identifier,
      password: password,
    );

    result.fold(
      (failure) => errorMessage = failure.message,
      (response) {
        requiresOtp = response.requiresOtp;
        pendingIdentifier = identifier;
        successMessage = response.message;
      },
    );

    isLoading = false;
  }

  @action
  Future<bool> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.verifyOtp(
      identifier: identifier,
      otp: otp,
    );

    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (response) {
        currentUser = response.user;
        isAuthenticated = true;
        requiresOtp = false;
        successMessage = response.message;
        success = true;
      },
    );

    isLoading = false;
    return success;
  }

  @action
  Future<void> resendOtp({required String identifier}) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.resendOtp(identifier: identifier);

    result.fold(
      (failure) => errorMessage = failure.message,
      (response) => successMessage = response.message,
    );

    isLoading = false;
  }

  @action
  Future<void> forgotPassword({required String email}) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.forgotPassword(email: email);

    result.fold(
      (failure) => errorMessage = failure.message,
      (response) {
        successMessage = response.message;
        pendingIdentifier = email;
      },
    );

    isLoading = false;
  }

  @action
  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );

    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (response) {
        currentUser = response.user;
        isAuthenticated = true;
        successMessage = response.message;
        success = true;
      },
    );

    isLoading = false;
    return success;
  }

  @action
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => errorMessage = failure.message,
      (message) => successMessage = message,
    );

    isLoading = false;
  }

  @action
  Future<void> setupPin({required String pin}) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.setupPin(pin: pin);

    result.fold(
      (failure) => errorMessage = failure.message,
      (message) => successMessage = message,
    );

    isLoading = false;
  }

  @action
  Future<void> updatePin({
    required String oldPin,
    required String newPin,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.updatePin(
      oldPin: oldPin,
      newPin: newPin,
    );

    result.fold(
      (failure) => errorMessage = failure.message,
      (message) => successMessage = message,
    );

    isLoading = false;
  }

  @action
  Future<void> sendPasswordResetOtp({required String email}) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.forgotPassword(email: email);

    result.fold(
      (failure) => errorMessage = failure.message,
      (response) => successMessage = response.message,
    );

    isLoading = false;
  }

  @action
  Future<void> resetPasswordWithOtp({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => errorMessage = failure.message,
      (authResponse) {
        successMessage = 'Password reset successfully';
        currentUser = authResponse.user;
      },
    );

    isLoading = false;
  }

  @action
  Future<void> sendPinResetOtp({required String email}) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.sendPinResetOtp(email: email);

    result.fold(
      (failure) => errorMessage = failure.message,
      (response) => successMessage = response.message,
    );

    isLoading = false;
  }

  @action
  Future<void> forgotPin({
    required String email,
    required String otp,
    required String newPin,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.forgotPin(
      email: email,
      otp: otp,
      newPin: newPin,
    );

    result.fold(
      (failure) => errorMessage = failure.message,
      (message) => successMessage = message,
    );

    isLoading = false;
  }

  @action
  Future<void> getProfile() async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.getProfile();

    result.fold(
      (failure) => errorMessage = failure.message,
      (user) {
        runInAction(() {
          currentUser = user;
        });
      },
    );

    isLoading = false;
  }

  @action
  Future<void> updateProfile({
    String? phone,
    bool? priceUpdates,
    bool? loginEmails,
    List<double>? coordinates,
    String? address,
    String? city,
    String? state,
    String? country,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.updateProfile(
      phone: phone,
      priceUpdates: priceUpdates,
      loginEmails: loginEmails,
      coordinates: coordinates,
      address: address,
      city: city,
      state: state,
      country: country,
    );

    result.fold(
      (failure) => errorMessage = failure.message,
      (message) {
        successMessage = message;
        getProfile();
      },
    );

    isLoading = false;
  }

  @action
  Future<void> uploadPhoto({required String filePath}) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.uploadPhoto(filePath: filePath);

    result.fold(
      (failure) => errorMessage = failure.message,
      (response) {
        successMessage = response.message;
        getProfile();
      },
    );

    isLoading = false;
  }

  @action
  Future<void> toggleBiometric({required bool enabled}) async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.toggleBiometric(enabled: enabled);

    result.fold(
      (failure) => errorMessage = failure.message,
      (message) {
        successMessage = message;
        // Update local state immediately
        if (currentUser != null) {
          currentUser = currentUser!.copyWith(biometricEnabled: enabled);
        }
      },
    );

    isLoading = false;
  }

  @action
  Future<bool> checkAuthStatus() async {
    final result = await _repository.isLoggedIn();
    return result.fold(
      (_) => false,
      (loggedIn) {
        isAuthenticated = loggedIn;
        return loggedIn;
      },
    );
  }

  @action
  Future<void> getCurrentUser() async {
    isLoading = true;
    errorMessage = null;

    final result = await _repository.getProfile();

    result.fold(
      (failure) => errorMessage = failure.message,
      (user) {
        runInAction(() {
          currentUser = user;
        });
      },
    );

    isLoading = false;
  }

  @action
  Future<void> logout() async {
    await _repository.logout();
    currentUser = null;
    isAuthenticated = false;
    requiresOtp = false;
    pendingIdentifier = null;
    clearMessages();
  }
}
