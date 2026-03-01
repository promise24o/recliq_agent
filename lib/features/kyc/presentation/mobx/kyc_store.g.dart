// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$KycStore on _KycStore, Store {
  Computed<bool>? _$canVerifyBvnComputed;

  @override
  bool get canVerifyBvn => (_$canVerifyBvnComputed ??= Computed<bool>(
    () => super.canVerifyBvn,
    name: '_KycStore.canVerifyBvn',
  )).value;
  Computed<bool>? _$canUploadDocumentComputed;

  @override
  bool get canUploadDocument => (_$canUploadDocumentComputed ??= Computed<bool>(
    () => super.canUploadDocument,
    name: '_KycStore.canUploadDocument',
  )).value;
  Computed<bool>? _$canUploadSelfieComputed;

  @override
  bool get canUploadSelfie => (_$canUploadSelfieComputed ??= Computed<bool>(
    () => super.canUploadSelfie,
    name: '_KycStore.canUploadSelfie',
  )).value;
  Computed<bool>? _$isKycCompleteComputed;

  @override
  bool get isKycComplete => (_$isKycCompleteComputed ??= Computed<bool>(
    () => super.isKycComplete,
    name: '_KycStore.isKycComplete',
  )).value;
  Computed<bool>? _$isKycPendingComputed;

  @override
  bool get isKycPending => (_$isKycPendingComputed ??= Computed<bool>(
    () => super.isKycPending,
    name: '_KycStore.isKycPending',
  )).value;
  Computed<bool>? _$isKycRejectedComputed;

  @override
  bool get isKycRejected => (_$isKycRejectedComputed ??= Computed<bool>(
    () => super.isKycRejected,
    name: '_KycStore.isKycRejected',
  )).value;

  late final _$isLoadingAtom = Atom(
    name: '_KycStore.isLoading',
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

  late final _$isInitializingAtom = Atom(
    name: '_KycStore.isInitializing',
    context: context,
  );

  @override
  bool get isInitializing {
    _$isInitializingAtom.reportRead();
    return super.isInitializing;
  }

  @override
  set isInitializing(bool value) {
    _$isInitializingAtom.reportWrite(value, super.isInitializing, () {
      super.isInitializing = value;
    });
  }

  late final _$isVerifyingBvnAtom = Atom(
    name: '_KycStore.isVerifyingBvn',
    context: context,
  );

  @override
  bool get isVerifyingBvn {
    _$isVerifyingBvnAtom.reportRead();
    return super.isVerifyingBvn;
  }

  @override
  set isVerifyingBvn(bool value) {
    _$isVerifyingBvnAtom.reportWrite(value, super.isVerifyingBvn, () {
      super.isVerifyingBvn = value;
    });
  }

  late final _$isUploadingDocumentAtom = Atom(
    name: '_KycStore.isUploadingDocument',
    context: context,
  );

  @override
  bool get isUploadingDocument {
    _$isUploadingDocumentAtom.reportRead();
    return super.isUploadingDocument;
  }

  @override
  set isUploadingDocument(bool value) {
    _$isUploadingDocumentAtom.reportWrite(value, super.isUploadingDocument, () {
      super.isUploadingDocument = value;
    });
  }

  late final _$isUploadingSelfieAtom = Atom(
    name: '_KycStore.isUploadingSelfie',
    context: context,
  );

  @override
  bool get isUploadingSelfie {
    _$isUploadingSelfieAtom.reportRead();
    return super.isUploadingSelfie;
  }

  @override
  set isUploadingSelfie(bool value) {
    _$isUploadingSelfieAtom.reportWrite(value, super.isUploadingSelfie, () {
      super.isUploadingSelfie = value;
    });
  }

  late final _$isBanksLoadingAtom = Atom(
    name: '_KycStore.isBanksLoading',
    context: context,
  );

  @override
  bool get isBanksLoading {
    _$isBanksLoadingAtom.reportRead();
    return super.isBanksLoading;
  }

  @override
  set isBanksLoading(bool value) {
    _$isBanksLoadingAtom.reportWrite(value, super.isBanksLoading, () {
      super.isBanksLoading = value;
    });
  }

  late final _$isResolvingAccountAtom = Atom(
    name: '_KycStore.isResolvingAccount',
    context: context,
  );

  @override
  bool get isResolvingAccount {
    _$isResolvingAccountAtom.reportRead();
    return super.isResolvingAccount;
  }

  @override
  set isResolvingAccount(bool value) {
    _$isResolvingAccountAtom.reportWrite(value, super.isResolvingAccount, () {
      super.isResolvingAccount = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_KycStore.errorMessage',
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
    name: '_KycStore.successMessage',
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

  late final _$kycStatusAtom = Atom(
    name: '_KycStore.kycStatus',
    context: context,
  );

  @override
  KycStatusEntity? get kycStatus {
    _$kycStatusAtom.reportRead();
    return super.kycStatus;
  }

  @override
  set kycStatus(KycStatusEntity? value) {
    _$kycStatusAtom.reportWrite(value, super.kycStatus, () {
      super.kycStatus = value;
    });
  }

  late final _$banksAtom = Atom(name: '_KycStore.banks', context: context);

  @override
  List<Bank> get banks {
    _$banksAtom.reportRead();
    return super.banks;
  }

  @override
  set banks(List<Bank> value) {
    _$banksAtom.reportWrite(value, super.banks, () {
      super.banks = value;
    });
  }

  late final _$resolvedAccountNameAtom = Atom(
    name: '_KycStore.resolvedAccountName',
    context: context,
  );

  @override
  String? get resolvedAccountName {
    _$resolvedAccountNameAtom.reportRead();
    return super.resolvedAccountName;
  }

  @override
  set resolvedAccountName(String? value) {
    _$resolvedAccountNameAtom.reportWrite(value, super.resolvedAccountName, () {
      super.resolvedAccountName = value;
    });
  }

  late final _$selectedBankCodeAtom = Atom(
    name: '_KycStore.selectedBankCode',
    context: context,
  );

  @override
  String? get selectedBankCode {
    _$selectedBankCodeAtom.reportRead();
    return super.selectedBankCode;
  }

  @override
  set selectedBankCode(String? value) {
    _$selectedBankCodeAtom.reportWrite(value, super.selectedBankCode, () {
      super.selectedBankCode = value;
    });
  }

  late final _$initializeKycAsyncAction = AsyncAction(
    '_KycStore.initializeKyc',
    context: context,
  );

  @override
  Future<void> initializeKyc(String userId, KycUserType userType) {
    return _$initializeKycAsyncAction.run(
      () => super.initializeKyc(userId, userType),
    );
  }

  late final _$loadKycStatusAsyncAction = AsyncAction(
    '_KycStore.loadKycStatus',
    context: context,
  );

  @override
  Future<void> loadKycStatus(String userId) {
    return _$loadKycStatusAsyncAction.run(() => super.loadKycStatus(userId));
  }

  late final _$loadBanksAsyncAction = AsyncAction(
    '_KycStore.loadBanks',
    context: context,
  );

  @override
  Future<void> loadBanks({bool forceRefresh = false}) {
    return _$loadBanksAsyncAction.run(
      () => super.loadBanks(forceRefresh: forceRefresh),
    );
  }

  late final _$resolveBankAccountAsyncAction = AsyncAction(
    '_KycStore.resolveBankAccount',
    context: context,
  );

  @override
  Future<void> resolveBankAccount(String accountNumber, String bankCode) {
    return _$resolveBankAccountAsyncAction.run(
      () => super.resolveBankAccount(accountNumber, bankCode),
    );
  }

  late final _$verifyBvnAsyncAction = AsyncAction(
    '_KycStore.verifyBvn',
    context: context,
  );

  @override
  Future<void> verifyBvn({
    required String userId,
    required String bvn,
    required String accountNumber,
    required String bankCode,
    required String userName,
  }) {
    return _$verifyBvnAsyncAction.run(
      () => super.verifyBvn(
        userId: userId,
        bvn: bvn,
        accountNumber: accountNumber,
        bankCode: bankCode,
        userName: userName,
      ),
    );
  }

  late final _$uploadDocumentAsyncAction = AsyncAction(
    '_KycStore.uploadDocument',
    context: context,
  );

  @override
  Future<void> uploadDocument(
    String userId,
    String documentType,
    File document,
  ) {
    return _$uploadDocumentAsyncAction.run(
      () => super.uploadDocument(userId, documentType, document),
    );
  }

  late final _$uploadSelfieAsyncAction = AsyncAction(
    '_KycStore.uploadSelfie',
    context: context,
  );

  @override
  Future<void> uploadSelfie(String userId, File selfie) {
    return _$uploadSelfieAsyncAction.run(
      () => super.uploadSelfie(userId, selfie),
    );
  }

  late final _$_KycStoreActionController = ActionController(
    name: '_KycStore',
    context: context,
  );

  @override
  void setSelectedBank(String? bankCode) {
    final _$actionInfo = _$_KycStoreActionController.startAction(
      name: '_KycStore.setSelectedBank',
    );
    try {
      return super.setSelectedBank(bankCode);
    } finally {
      _$_KycStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_KycStoreActionController.startAction(
      name: '_KycStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_KycStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isInitializing: ${isInitializing},
isVerifyingBvn: ${isVerifyingBvn},
isUploadingDocument: ${isUploadingDocument},
isUploadingSelfie: ${isUploadingSelfie},
isBanksLoading: ${isBanksLoading},
isResolvingAccount: ${isResolvingAccount},
errorMessage: ${errorMessage},
successMessage: ${successMessage},
kycStatus: ${kycStatus},
banks: ${banks},
resolvedAccountName: ${resolvedAccountName},
selectedBankCode: ${selectedBankCode},
canVerifyBvn: ${canVerifyBvn},
canUploadDocument: ${canUploadDocument},
canUploadSelfie: ${canUploadSelfie},
isKycComplete: ${isKycComplete},
isKycPending: ${isKycPending},
isKycRejected: ${isKycRejected}
    ''';
  }
}
