// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_AuthStore.hasError',
  )).value;

  late final _$currentUserAtom = Atom(
    name: '_AuthStore.currentUser',
    context: context,
  );

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AuthStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_AuthStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$successMessageAtom = Atom(
    name: '_AuthStore.successMessage',
    context: context,
  );

  @override
  String? get successMessage {
    _$successMessageAtom.reportRead();
    return super.successMessage;
  }

  @override
  set successMessage(String? value) {
    _$successMessageAtom.reportWrite(value, super.successMessage, () {
      super.successMessage = value;
    });
  }

  late final _$isAuthenticatedAtom = Atom(
    name: '_AuthStore.isAuthenticated',
    context: context,
  );

  @override
  bool get isAuthenticated {
    _$isAuthenticatedAtom.reportRead();
    return super.isAuthenticated;
  }

  @override
  set isAuthenticated(bool value) {
    _$isAuthenticatedAtom.reportWrite(value, super.isAuthenticated, () {
      super.isAuthenticated = value;
    });
  }

  late final _$requiresOtpAtom = Atom(
    name: '_AuthStore.requiresOtp',
    context: context,
  );

  @override
  bool get requiresOtp {
    _$requiresOtpAtom.reportRead();
    return super.requiresOtp;
  }

  @override
  set requiresOtp(bool value) {
    _$requiresOtpAtom.reportWrite(value, super.requiresOtp, () {
      super.requiresOtp = value;
    });
  }

  late final _$pendingIdentifierAtom = Atom(
    name: '_AuthStore.pendingIdentifier',
    context: context,
  );

  @override
  String? get pendingIdentifier {
    _$pendingIdentifierAtom.reportRead();
    return super.pendingIdentifier;
  }

  @override
  set pendingIdentifier(String? value) {
    _$pendingIdentifierAtom.reportWrite(value, super.pendingIdentifier, () {
      super.pendingIdentifier = value;
    });
  }

  late final _$registerAsyncAction = AsyncAction(
    '_AuthStore.register',
    context: context,
  );

  @override
  Future<void> register({
    required String name,
    required String identifier,
    required String password,
    String? referralCode,
  }) {
    return _$registerAsyncAction.run(
      () => super.register(
        name: name,
        identifier: identifier,
        password: password,
        referralCode: referralCode,
      ),
    );
  }

  late final _$loginAsyncAction = AsyncAction(
    '_AuthStore.login',
    context: context,
  );

  @override
  Future<void> login({required String identifier, required String password}) {
    return _$loginAsyncAction.run(
      () => super.login(identifier: identifier, password: password),
    );
  }

  late final _$verifyOtpAsyncAction = AsyncAction(
    '_AuthStore.verifyOtp',
    context: context,
  );

  @override
  Future<bool> verifyOtp({required String identifier, required String otp}) {
    return _$verifyOtpAsyncAction.run(
      () => super.verifyOtp(identifier: identifier, otp: otp),
    );
  }

  late final _$resendOtpAsyncAction = AsyncAction(
    '_AuthStore.resendOtp',
    context: context,
  );

  @override
  Future<void> resendOtp({required String identifier}) {
    return _$resendOtpAsyncAction.run(
      () => super.resendOtp(identifier: identifier),
    );
  }

  late final _$forgotPasswordAsyncAction = AsyncAction(
    '_AuthStore.forgotPassword',
    context: context,
  );

  @override
  Future<void> forgotPassword({required String email}) {
    return _$forgotPasswordAsyncAction.run(
      () => super.forgotPassword(email: email),
    );
  }

  late final _$resetPasswordAsyncAction = AsyncAction(
    '_AuthStore.resetPassword',
    context: context,
  );

  @override
  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return _$resetPasswordAsyncAction.run(
      () =>
          super.resetPassword(email: email, otp: otp, newPassword: newPassword),
    );
  }

  late final _$changePasswordAsyncAction = AsyncAction(
    '_AuthStore.changePassword',
    context: context,
  );

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _$changePasswordAsyncAction.run(
      () => super.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );
  }

  late final _$setupPinAsyncAction = AsyncAction(
    '_AuthStore.setupPin',
    context: context,
  );

  @override
  Future<void> setupPin({required String pin}) {
    return _$setupPinAsyncAction.run(() => super.setupPin(pin: pin));
  }

  late final _$updatePinAsyncAction = AsyncAction(
    '_AuthStore.updatePin',
    context: context,
  );

  @override
  Future<void> updatePin({required String oldPin, required String newPin}) {
    return _$updatePinAsyncAction.run(
      () => super.updatePin(oldPin: oldPin, newPin: newPin),
    );
  }

  late final _$sendPasswordResetOtpAsyncAction = AsyncAction(
    '_AuthStore.sendPasswordResetOtp',
    context: context,
  );

  @override
  Future<void> sendPasswordResetOtp({required String email}) {
    return _$sendPasswordResetOtpAsyncAction.run(
      () => super.sendPasswordResetOtp(email: email),
    );
  }

  late final _$resetPasswordWithOtpAsyncAction = AsyncAction(
    '_AuthStore.resetPasswordWithOtp',
    context: context,
  );

  @override
  Future<void> resetPasswordWithOtp({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return _$resetPasswordWithOtpAsyncAction.run(
      () => super.resetPasswordWithOtp(
        email: email,
        otp: otp,
        newPassword: newPassword,
      ),
    );
  }

  late final _$sendPinResetOtpAsyncAction = AsyncAction(
    '_AuthStore.sendPinResetOtp',
    context: context,
  );

  @override
  Future<void> sendPinResetOtp({required String email}) {
    return _$sendPinResetOtpAsyncAction.run(
      () => super.sendPinResetOtp(email: email),
    );
  }

  late final _$forgotPinAsyncAction = AsyncAction(
    '_AuthStore.forgotPin',
    context: context,
  );

  @override
  Future<void> forgotPin({
    required String email,
    required String otp,
    required String newPin,
  }) {
    return _$forgotPinAsyncAction.run(
      () => super.forgotPin(email: email, otp: otp, newPin: newPin),
    );
  }

  late final _$getProfileAsyncAction = AsyncAction(
    '_AuthStore.getProfile',
    context: context,
  );

  @override
  Future<void> getProfile() {
    return _$getProfileAsyncAction.run(() => super.getProfile());
  }

  late final _$updateProfileAsyncAction = AsyncAction(
    '_AuthStore.updateProfile',
    context: context,
  );

  @override
  Future<void> updateProfile({
    String? phone,
    bool? priceUpdates,
    bool? loginEmails,
    List<double>? coordinates,
    String? address,
    String? city,
    String? state,
    String? country,
  }) {
    return _$updateProfileAsyncAction.run(
      () => super.updateProfile(
        phone: phone,
        priceUpdates: priceUpdates,
        loginEmails: loginEmails,
        coordinates: coordinates,
        address: address,
        city: city,
        state: state,
        country: country,
      ),
    );
  }

  late final _$uploadPhotoAsyncAction = AsyncAction(
    '_AuthStore.uploadPhoto',
    context: context,
  );

  @override
  Future<void> uploadPhoto({required String filePath}) {
    return _$uploadPhotoAsyncAction.run(
      () => super.uploadPhoto(filePath: filePath),
    );
  }

  late final _$toggleBiometricAsyncAction = AsyncAction(
    '_AuthStore.toggleBiometric',
    context: context,
  );

  @override
  Future<void> toggleBiometric({required bool enabled}) {
    return _$toggleBiometricAsyncAction.run(
      () => super.toggleBiometric(enabled: enabled),
    );
  }

  late final _$checkAuthStatusAsyncAction = AsyncAction(
    '_AuthStore.checkAuthStatus',
    context: context,
  );

  @override
  Future<bool> checkAuthStatus() {
    return _$checkAuthStatusAsyncAction.run(() => super.checkAuthStatus());
  }

  late final _$getCurrentUserAsyncAction = AsyncAction(
    '_AuthStore.getCurrentUser',
    context: context,
  );

  @override
  Future<void> getCurrentUser() {
    return _$getCurrentUserAsyncAction.run(() => super.getCurrentUser());
  }

  late final _$logoutAsyncAction = AsyncAction(
    '_AuthStore.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_AuthStoreActionController = ActionController(
    name: '_AuthStore',
    context: context,
  );

  @override
  void clearMessages() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
successMessage: ${successMessage},
isAuthenticated: ${isAuthenticated},
requiresOtp: ${requiresOtp},
pendingIdentifier: ${pendingIdentifier},
hasError: ${hasError}
    ''';
  }
}
