import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/wallet/domain/entities/wallet.dart';

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
}
