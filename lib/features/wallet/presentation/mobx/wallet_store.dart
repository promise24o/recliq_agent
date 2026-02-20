import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/wallet/domain/entities/wallet.dart';
import 'package:recliq_agent/features/wallet/domain/repositories/wallet_repository.dart';

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
}
