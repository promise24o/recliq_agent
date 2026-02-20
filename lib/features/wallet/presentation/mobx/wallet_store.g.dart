// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalletStore on _WalletStore, Store {
  late final _$walletDataAtom = Atom(
    name: '_WalletStore.walletData',
    context: context,
  );

  @override
  WalletData? get walletData {
    _$walletDataAtom.reportRead();
    return super.walletData;
  }

  @override
  set walletData(WalletData? value) {
    _$walletDataAtom.reportWrite(value, super.walletData, () {
      super.walletData = value;
    });
  }

  late final _$transactionsAtom = Atom(
    name: '_WalletStore.transactions',
    context: context,
  );

  @override
  ObservableList<WalletTransaction> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(ObservableList<WalletTransaction> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  late final _$commissionBreakdownAtom = Atom(
    name: '_WalletStore.commissionBreakdown',
    context: context,
  );

  @override
  CommissionBreakdown? get commissionBreakdown {
    _$commissionBreakdownAtom.reportRead();
    return super.commissionBreakdown;
  }

  @override
  set commissionBreakdown(CommissionBreakdown? value) {
    _$commissionBreakdownAtom.reportWrite(value, super.commissionBreakdown, () {
      super.commissionBreakdown = value;
    });
  }

  late final _$withdrawalsAtom = Atom(
    name: '_WalletStore.withdrawals',
    context: context,
  );

  @override
  ObservableList<WithdrawalRequest> get withdrawals {
    _$withdrawalsAtom.reportRead();
    return super.withdrawals;
  }

  @override
  set withdrawals(ObservableList<WithdrawalRequest> value) {
    _$withdrawalsAtom.reportWrite(value, super.withdrawals, () {
      super.withdrawals = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_WalletStore.isLoading',
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
    name: '_WalletStore.errorMessage',
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
    name: '_WalletStore.successMessage',
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

  late final _$loadWalletDataAsyncAction = AsyncAction(
    '_WalletStore.loadWalletData',
    context: context,
  );

  @override
  Future<void> loadWalletData() {
    return _$loadWalletDataAsyncAction.run(() => super.loadWalletData());
  }

  late final _$loadTransactionsAsyncAction = AsyncAction(
    '_WalletStore.loadTransactions',
    context: context,
  );

  @override
  Future<void> loadTransactions() {
    return _$loadTransactionsAsyncAction.run(() => super.loadTransactions());
  }

  late final _$loadCommissionAsyncAction = AsyncAction(
    '_WalletStore.loadCommission',
    context: context,
  );

  @override
  Future<void> loadCommission() {
    return _$loadCommissionAsyncAction.run(() => super.loadCommission());
  }

  late final _$loadWithdrawalsAsyncAction = AsyncAction(
    '_WalletStore.loadWithdrawals',
    context: context,
  );

  @override
  Future<void> loadWithdrawals() {
    return _$loadWithdrawalsAsyncAction.run(() => super.loadWithdrawals());
  }

  late final _$loadAllAsyncAction = AsyncAction(
    '_WalletStore.loadAll',
    context: context,
  );

  @override
  Future<void> loadAll() {
    return _$loadAllAsyncAction.run(() => super.loadAll());
  }

  late final _$withdrawToBankAsyncAction = AsyncAction(
    '_WalletStore.withdrawToBank',
    context: context,
  );

  @override
  Future<bool> withdrawToBank({
    required double amount,
    required String bankName,
    required String accountNumber,
    required String otp,
  }) {
    return _$withdrawToBankAsyncAction.run(
      () => super.withdrawToBank(
        amount: amount,
        bankName: bankName,
        accountNumber: accountNumber,
        otp: otp,
      ),
    );
  }

  late final _$withdrawToMobileAsyncAction = AsyncAction(
    '_WalletStore.withdrawToMobile',
    context: context,
  );

  @override
  Future<bool> withdrawToMobile({
    required double amount,
    required String mobileNumber,
    required String otp,
  }) {
    return _$withdrawToMobileAsyncAction.run(
      () => super.withdrawToMobile(
        amount: amount,
        mobileNumber: mobileNumber,
        otp: otp,
      ),
    );
  }

  late final _$_WalletStoreActionController = ActionController(
    name: '_WalletStore',
    context: context,
  );

  @override
  void clearMessages() {
    final _$actionInfo = _$_WalletStoreActionController.startAction(
      name: '_WalletStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_WalletStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
walletData: ${walletData},
transactions: ${transactions},
commissionBreakdown: ${commissionBreakdown},
withdrawals: ${withdrawals},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
successMessage: ${successMessage}
    ''';
  }
}
