// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletDataImpl _$$WalletDataImplFromJson(Map<String, dynamic> json) =>
    _$WalletDataImpl(
      availableBalance: (json['availableBalance'] as num?)?.toDouble() ?? 0.0,
      pendingBalance: (json['pendingBalance'] as num?)?.toDouble() ?? 0.0,
      commissionBalance: (json['commissionBalance'] as num?)?.toDouble() ?? 0.0,
      minimumFloat: (json['minimumFloat'] as num?)?.toDouble() ?? 0.0,
      transactionLimit: (json['transactionLimit'] as num?)?.toDouble() ?? 0.0,
      isFloatSufficient: json['isFloatSufficient'] as bool? ?? false,
    );

Map<String, dynamic> _$$WalletDataImplToJson(_$WalletDataImpl instance) =>
    <String, dynamic>{
      'availableBalance': instance.availableBalance,
      'pendingBalance': instance.pendingBalance,
      'commissionBalance': instance.commissionBalance,
      'minimumFloat': instance.minimumFloat,
      'transactionLimit': instance.transactionLimit,
      'isFloatSufficient': instance.isFloatSufficient,
    };

_$WalletTransactionImpl _$$WalletTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$WalletTransactionImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String,
  description: json['description'] as String,
  reference: json['reference'] as String?,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$$WalletTransactionImplToJson(
  _$WalletTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'amount': instance.amount,
  'status': instance.status,
  'description': instance.description,
  'reference': instance.reference,
  'createdAt': instance.createdAt,
};

_$WithdrawalRequestImpl _$$WithdrawalRequestImplFromJson(
  Map<String, dynamic> json,
) => _$WithdrawalRequestImpl(
  id: json['id'] as String,
  amount: (json['amount'] as num).toDouble(),
  method: json['method'] as String,
  status: json['status'] as String,
  bankName: json['bankName'] as String?,
  accountNumber: json['accountNumber'] as String?,
  mobileNumber: json['mobileNumber'] as String?,
  fee: (json['fee'] as num?)?.toDouble(),
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$$WithdrawalRequestImplToJson(
  _$WithdrawalRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'method': instance.method,
  'status': instance.status,
  'bankName': instance.bankName,
  'accountNumber': instance.accountNumber,
  'mobileNumber': instance.mobileNumber,
  'fee': instance.fee,
  'createdAt': instance.createdAt,
};

_$CommissionBreakdownImpl _$$CommissionBreakdownImplFromJson(
  Map<String, dynamic> json,
) => _$CommissionBreakdownImpl(
  totalEarned: (json['totalEarned'] as num?)?.toDouble() ?? 0.0,
  totalDeducted: (json['totalDeducted'] as num?)?.toDouble() ?? 0.0,
  netCommission: (json['netCommission'] as num?)?.toDouble() ?? 0.0,
  commissionRate: (json['commissionRate'] as num?)?.toDouble() ?? 0.0,
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map((e) => CommissionEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$CommissionBreakdownImplToJson(
  _$CommissionBreakdownImpl instance,
) => <String, dynamic>{
  'totalEarned': instance.totalEarned,
  'totalDeducted': instance.totalDeducted,
  'netCommission': instance.netCommission,
  'commissionRate': instance.commissionRate,
  'entries': instance.entries,
};

_$CommissionEntryImpl _$$CommissionEntryImplFromJson(
  Map<String, dynamic> json,
) => _$CommissionEntryImpl(
  id: json['id'] as String,
  jobId: json['jobId'] as String,
  amount: (json['amount'] as num).toDouble(),
  rate: (json['rate'] as num).toDouble(),
  description: json['description'] as String,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$$CommissionEntryImplToJson(
  _$CommissionEntryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'jobId': instance.jobId,
  'amount': instance.amount,
  'rate': instance.rate,
  'description': instance.description,
  'createdAt': instance.createdAt,
};
