import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:recliq_agent/features/wallet/domain/entities/wallet.dart';
import 'package:recliq_agent/features/wallet/domain/repositories/wallet_repository.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;

  WalletRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, WalletData>> getWalletData() async {
    try {
      final result = await _remoteDataSource.getWalletData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WalletTransaction>>> getTransactionHistory() async {
    try {
      final result = await _remoteDataSource.getTransactionHistory();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommissionBreakdown>> getCommissionBreakdown() async {
    try {
      final result = await _remoteDataSource.getCommissionBreakdown();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WithdrawalRequest>>> getWithdrawalHistory() async {
    try {
      final result = await _remoteDataSource.getWithdrawalHistory();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WithdrawalRequest>> withdrawToBank({
    required double amount,
    required String bankName,
    required String accountNumber,
    required String otp,
  }) async {
    try {
      final result = await _remoteDataSource.withdrawToBank(
        amount: amount,
        bankName: bankName,
        accountNumber: accountNumber,
        otp: otp,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WithdrawalRequest>> withdrawToMobile({
    required double amount,
    required String mobileNumber,
    required String otp,
  }) async {
    try {
      final result = await _remoteDataSource.withdrawToMobile(
        amount: amount,
        mobileNumber: mobileNumber,
        otp: otp,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
