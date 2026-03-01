import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/wallet/domain/entities/wallet.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletData>> getWalletData();
  Future<Either<Failure, List<WalletTransaction>>> getTransactionHistory();
  Future<Either<Failure, CommissionBreakdown>> getCommissionBreakdown();
  Future<Either<Failure, List<WithdrawalRequest>>> getWithdrawalHistory();
  Future<Either<Failure, WithdrawalRequest>> withdrawToBank({
    required double amount,
    required String bankName,
    required String accountNumber,
    required String otp,
  });
  Future<Either<Failure, WithdrawalRequest>> withdrawToMobile({
    required double amount,
    required String mobileNumber,
    required String otp,
  });

  // Bank Account Management Methods
  Future<Either<Failure, BanksResponse>> getSupportedBanks();
  Future<Either<Failure, BankVerification>> verifyBankAccount({
    required String bankCode,
    required String accountNumber,
  });
  Future<Either<Failure, BankAccount>> linkBankAccount({
    required String bankCode,
    required String accountNumber,
  });
  Future<Either<Failure, BankAccountsResponse>> getBankAccounts();
  Future<Either<Failure, BankAccount>> setDefaultBankAccount({
    required String bankAccountId,
  });
  Future<Either<Failure, void>> removeBankAccount({
    required String bankAccountId,
  });
}
