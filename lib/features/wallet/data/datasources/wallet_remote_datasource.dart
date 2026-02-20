import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/wallet/domain/entities/wallet.dart';

abstract class WalletRemoteDataSource {
  Future<WalletData> getWalletData();
  Future<List<WalletTransaction>> getTransactionHistory();
  Future<CommissionBreakdown> getCommissionBreakdown();
  Future<List<WithdrawalRequest>> getWithdrawalHistory();
  Future<WithdrawalRequest> withdrawToBank({
    required double amount,
    required String bankName,
    required String accountNumber,
    required String otp,
  });
  Future<WithdrawalRequest> withdrawToMobile({
    required double amount,
    required String mobileNumber,
    required String otp,
  });
}

@LazySingleton(as: WalletRemoteDataSource)
class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final DioClient _dioClient;

  WalletRemoteDataSourceImpl(this._dioClient);

  @override
  Future<WalletData> getWalletData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const WalletData(
      availableBalance: 125000.0,
      pendingBalance: 15000.0,
      commissionBalance: 67500.0,
      minimumFloat: 10000.0,
      transactionLimit: 500000.0,
      isFloatSufficient: true,
    );
  }

  @override
  Future<List<WalletTransaction>> getTransactionHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      WalletTransaction(
        id: '1',
        type: 'credit',
        amount: 3750.0,
        status: 'completed',
        description: 'Pickup - PET Bottles (25kg)',
        reference: 'TXN-001',
        createdAt: '2025-02-20T10:30:00Z',
      ),
      WalletTransaction(
        id: '2',
        type: 'debit',
        amount: 562.5,
        status: 'completed',
        description: 'Commission deduction (15%)',
        reference: 'COM-001',
        createdAt: '2025-02-20T10:30:00Z',
      ),
      WalletTransaction(
        id: '3',
        type: 'credit',
        amount: 4500.0,
        status: 'completed',
        description: 'Pickup - Aluminum Cans (15kg)',
        reference: 'TXN-002',
        createdAt: '2025-02-20T09:15:00Z',
      ),
      WalletTransaction(
        id: '4',
        type: 'debit',
        amount: 50000.0,
        status: 'completed',
        description: 'Withdrawal to GTBank',
        reference: 'WDR-001',
        createdAt: '2025-02-19T16:00:00Z',
      ),
    ];
  }

  @override
  Future<CommissionBreakdown> getCommissionBreakdown() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const CommissionBreakdown(
      totalEarned: 450000.0,
      totalDeducted: 67500.0,
      netCommission: 382500.0,
      commissionRate: 15.0,
      entries: [
        CommissionEntry(
          id: '1',
          jobId: 'JOB-001',
          amount: 562.5,
          rate: 15.0,
          description: 'PET Bottles pickup',
          createdAt: '2025-02-20T10:30:00Z',
        ),
        CommissionEntry(
          id: '2',
          jobId: 'JOB-002',
          amount: 675.0,
          rate: 15.0,
          description: 'Aluminum Cans pickup',
          createdAt: '2025-02-20T09:15:00Z',
        ),
      ],
    );
  }

  @override
  Future<List<WithdrawalRequest>> getWithdrawalHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      WithdrawalRequest(
        id: '1',
        amount: 50000.0,
        method: 'bank',
        status: 'completed',
        bankName: 'GTBank',
        accountNumber: '0123456789',
        fee: 100.0,
        createdAt: '2025-02-19T16:00:00Z',
      ),
      WithdrawalRequest(
        id: '2',
        amount: 20000.0,
        method: 'mobile',
        status: 'pending',
        mobileNumber: '+2348012345678',
        fee: 50.0,
        createdAt: '2025-02-20T08:00:00Z',
      ),
    ];
  }

  @override
  Future<WithdrawalRequest> withdrawToBank({
    required double amount,
    required String bankName,
    required String accountNumber,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return WithdrawalRequest(
      id: 'new-1',
      amount: amount,
      method: 'bank',
      status: 'pending',
      bankName: bankName,
      accountNumber: accountNumber,
      fee: 100.0,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<WithdrawalRequest> withdrawToMobile({
    required double amount,
    required String mobileNumber,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return WithdrawalRequest(
      id: 'new-2',
      amount: amount,
      method: 'mobile',
      status: 'pending',
      mobileNumber: mobileNumber,
      fee: 50.0,
      createdAt: DateTime.now().toIso8601String(),
    );
  }
}
