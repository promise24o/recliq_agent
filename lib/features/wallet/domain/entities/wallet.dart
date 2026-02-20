import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

@freezed
class WalletData with _$WalletData {
  const factory WalletData({
    @Default(0.0) double availableBalance,
    @Default(0.0) double pendingBalance,
    @Default(0.0) double commissionBalance,
    @Default(0.0) double minimumFloat,
    @Default(0.0) double transactionLimit,
    @Default(false) bool isFloatSufficient,
  }) = _WalletData;

  factory WalletData.fromJson(Map<String, dynamic> json) =>
      _$WalletDataFromJson(json);
}

@freezed
class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required String type,
    required double amount,
    required String status,
    required String description,
    String? reference,
    required String createdAt,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}

@freezed
class WithdrawalRequest with _$WithdrawalRequest {
  const factory WithdrawalRequest({
    required String id,
    required double amount,
    required String method,
    required String status,
    String? bankName,
    String? accountNumber,
    String? mobileNumber,
    double? fee,
    required String createdAt,
  }) = _WithdrawalRequest;

  factory WithdrawalRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalRequestFromJson(json);
}

@freezed
class CommissionBreakdown with _$CommissionBreakdown {
  const factory CommissionBreakdown({
    @Default(0.0) double totalEarned,
    @Default(0.0) double totalDeducted,
    @Default(0.0) double netCommission,
    @Default(0.0) double commissionRate,
    @Default([]) List<CommissionEntry> entries,
  }) = _CommissionBreakdown;

  factory CommissionBreakdown.fromJson(Map<String, dynamic> json) =>
      _$CommissionBreakdownFromJson(json);
}

@freezed
class CommissionEntry with _$CommissionEntry {
  const factory CommissionEntry({
    required String id,
    required String jobId,
    required double amount,
    required double rate,
    required String description,
    required String createdAt,
  }) = _CommissionEntry;

  factory CommissionEntry.fromJson(Map<String, dynamic> json) =>
      _$CommissionEntryFromJson(json);
}
