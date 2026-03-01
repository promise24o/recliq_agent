import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/wallet/domain/entities/wallet.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';
import 'package:recliq_agent/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:recliq_agent/shared/services/cache_service.dart';

part 'wallet_store.g.dart';

@injectable
class WalletStore = _WalletStore with _$WalletStore;

abstract class _WalletStore with Store {
  final WalletRepository _repository;

  _WalletStore(this._repository);

  @observable
  WalletData? walletData;

  @observable
  ObservableList<WalletTransaction> transactions = ObservableList<WalletTransaction>();

  @observable
  CommissionBreakdown? commissionBreakdown;

  @observable
  ObservableList<WithdrawalRequest> withdrawals = ObservableList<WithdrawalRequest>();

  @observable
  ObservableList<Bank> supportedBanks = ObservableList<Bank>();

  @observable
  ObservableList<BankAccount> bankAccounts = ObservableList<BankAccount>();

  @observable
  BankVerification? bankVerification;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  @action
  void clearBankVerification() {
    bankVerification = null;
  }

  @action
  Future<void> clearBanksCache() async {
    await CacheService.clearBanksCache();
  }

  @action
  Future<bool> removeBankAccount({required String bankAccountId}) async {
    isLoading = true;
    errorMessage = null;
    final result = await _repository.removeBankAccount(bankAccountId: bankAccountId);
    bool success = false;
    result.fold(
      (failure) {
        errorMessage = failure.message;
        success = false;
      },
      (_) {
        successMessage = 'Bank account removed successfully';
        success = true;
      },
    );
    
    if (success) {
      await loadBankAccounts(); // Refresh the list
    }
    
    isLoading = false;
    return success;
  }

  @action
  Future<void> loadWalletData() async {
    isLoading = true;
    errorMessage = null;
    final result = await _repository.getWalletData();
    result.fold(
      (failure) => errorMessage = failure.message,
      (data) => walletData = data,
    );
    isLoading = false;
  }

  @action
  Future<void> loadTransactions() async {
    final result = await _repository.getTransactionHistory();
    result.fold(
      (failure) => errorMessage = failure.message,
      (txns) => transactions = ObservableList.of(txns),
    );
  }

  @action
  Future<void> loadCommission() async {
    final result = await _repository.getCommissionBreakdown();
    result.fold(
      (failure) => errorMessage = failure.message,
      (data) => commissionBreakdown = data,
    );
  }

  @action
  Future<void> loadWithdrawals() async {
    final result = await _repository.getWithdrawalHistory();
    result.fold(
      (failure) => errorMessage = failure.message,
      (data) => withdrawals = ObservableList.of(data),
    );
  }

  @action
  Future<void> loadAll() async {
    isLoading = true;
    await Future.wait([
      loadWalletData(),
      loadTransactions(),
      loadCommission(),
      loadWithdrawals(),
    ]);
    isLoading = false;
  }

  @action
  Future<bool> withdrawToBank({
    required double amount,
    required String bankName,
    required String accountNumber,
    required String otp,
  }) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.withdrawToBank(
      amount: amount,
      bankName: bankName,
      accountNumber: accountNumber,
      otp: otp,
    );
    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (withdrawal) {
        successMessage = 'Withdrawal request submitted';
        withdrawals.insert(0, withdrawal);
        success = true;
        loadWalletData();
      },
    );
    isLoading = false;
    return success;
  }

  @action
  Future<bool> withdrawToMobile({
    required double amount,
    required String mobileNumber,
    required String otp,
  }) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.withdrawToMobile(
      amount: amount,
      mobileNumber: mobileNumber,
      otp: otp,
    );
    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (withdrawal) {
        successMessage = 'Withdrawal request submitted';
        withdrawals.insert(0, withdrawal);
        success = true;
        loadWalletData();
      },
    );
    isLoading = false;
    return success;
  }

  // Bank Account Management Methods
  @action
  Future<void> loadSupportedBanks({bool forceRefresh = false}) async {
    // Try to load from cache first (unless force refresh)
    if (!forceRefresh) {
      final hasValidCache = await CacheService.hasValidBanksCache();
      if (hasValidCache) {
        final cachedBanks = await CacheService.getCachedBanks();
        if (cachedBanks != null) {
          supportedBanks = ObservableList.of(cachedBanks);
          return;
        }
      }
    }

    // Load from API
    isLoading = true;
    errorMessage = null;
    final result = await _repository.getSupportedBanks();
    result.fold(
      (failure) => errorMessage = failure.message,
      (response) {
        supportedBanks = ObservableList.of(response.banks);
        // Cache the banks for future use
        CacheService.cacheBanks(response.banks);
      },
    );
    isLoading = false;
  }

  @action
  Future<bool> verifyBankAccount({
    required String bankCode,
    required String accountNumber,
  }) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.verifyBankAccount(
      bankCode: bankCode,
      accountNumber: accountNumber,
    );
    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (verification) {
        bankVerification = verification;
        success = verification.status;
        if (success) {
          successMessage = 'Account verified successfully';
        }
      },
    );
    isLoading = false;
    return success;
  }

  @action
  Future<bool> linkBankAccount({
    required String bankCode,
    required String accountNumber,
  }) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.linkBankAccount(
      bankCode: bankCode,
      accountNumber: accountNumber,
    );
    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (account) {
        successMessage = 'Bank account linked successfully';
        bankAccounts.insert(0, account);
        success = true;
      },
    );
    isLoading = false;
    return success;
  }

  @action
  Future<void> loadBankAccounts() async {
    isLoading = true;
    errorMessage = null;
    final result = await _repository.getBankAccounts();
    result.fold(
      (failure) => errorMessage = failure.message,
      (response) => bankAccounts = ObservableList.of(response.bankAccounts),
    );
    isLoading = false;
  }

  @action
  Future<bool> setDefaultBankAccount({
    required String bankAccountId,
  }) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.setDefaultBankAccount(
      bankAccountId: bankAccountId,
    );
    bool success = false;
    result.fold(
      (failure) => errorMessage = failure.message,
      (account) {
        successMessage = 'Default bank account updated';
        success = true;
      },
    );
    
    if (success) {
      await loadBankAccounts();
    }
    
    isLoading = false;
    return success;
  }

  @action
  Future<void> loadBankData() async {
    isLoading = true;
    await Future.wait([
      loadSupportedBanks(),
      loadBankAccounts(),
    ]);
    isLoading = false;
  }
}
