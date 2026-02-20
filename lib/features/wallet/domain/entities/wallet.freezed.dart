// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WalletData _$WalletDataFromJson(Map<String, dynamic> json) {
  return _WalletData.fromJson(json);
}

/// @nodoc
mixin _$WalletData {
  double get availableBalance => throw _privateConstructorUsedError;
  double get pendingBalance => throw _privateConstructorUsedError;
  double get commissionBalance => throw _privateConstructorUsedError;
  double get minimumFloat => throw _privateConstructorUsedError;
  double get transactionLimit => throw _privateConstructorUsedError;
  bool get isFloatSufficient => throw _privateConstructorUsedError;

  /// Serializes this WalletData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletDataCopyWith<WalletData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletDataCopyWith<$Res> {
  factory $WalletDataCopyWith(
    WalletData value,
    $Res Function(WalletData) then,
  ) = _$WalletDataCopyWithImpl<$Res, WalletData>;
  @useResult
  $Res call({
    double availableBalance,
    double pendingBalance,
    double commissionBalance,
    double minimumFloat,
    double transactionLimit,
    bool isFloatSufficient,
  });
}

/// @nodoc
class _$WalletDataCopyWithImpl<$Res, $Val extends WalletData>
    implements $WalletDataCopyWith<$Res> {
  _$WalletDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableBalance = null,
    Object? pendingBalance = null,
    Object? commissionBalance = null,
    Object? minimumFloat = null,
    Object? transactionLimit = null,
    Object? isFloatSufficient = null,
  }) {
    return _then(
      _value.copyWith(
            availableBalance: null == availableBalance
                ? _value.availableBalance
                : availableBalance // ignore: cast_nullable_to_non_nullable
                      as double,
            pendingBalance: null == pendingBalance
                ? _value.pendingBalance
                : pendingBalance // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionBalance: null == commissionBalance
                ? _value.commissionBalance
                : commissionBalance // ignore: cast_nullable_to_non_nullable
                      as double,
            minimumFloat: null == minimumFloat
                ? _value.minimumFloat
                : minimumFloat // ignore: cast_nullable_to_non_nullable
                      as double,
            transactionLimit: null == transactionLimit
                ? _value.transactionLimit
                : transactionLimit // ignore: cast_nullable_to_non_nullable
                      as double,
            isFloatSufficient: null == isFloatSufficient
                ? _value.isFloatSufficient
                : isFloatSufficient // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalletDataImplCopyWith<$Res>
    implements $WalletDataCopyWith<$Res> {
  factory _$$WalletDataImplCopyWith(
    _$WalletDataImpl value,
    $Res Function(_$WalletDataImpl) then,
  ) = __$$WalletDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double availableBalance,
    double pendingBalance,
    double commissionBalance,
    double minimumFloat,
    double transactionLimit,
    bool isFloatSufficient,
  });
}

/// @nodoc
class __$$WalletDataImplCopyWithImpl<$Res>
    extends _$WalletDataCopyWithImpl<$Res, _$WalletDataImpl>
    implements _$$WalletDataImplCopyWith<$Res> {
  __$$WalletDataImplCopyWithImpl(
    _$WalletDataImpl _value,
    $Res Function(_$WalletDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableBalance = null,
    Object? pendingBalance = null,
    Object? commissionBalance = null,
    Object? minimumFloat = null,
    Object? transactionLimit = null,
    Object? isFloatSufficient = null,
  }) {
    return _then(
      _$WalletDataImpl(
        availableBalance: null == availableBalance
            ? _value.availableBalance
            : availableBalance // ignore: cast_nullable_to_non_nullable
                  as double,
        pendingBalance: null == pendingBalance
            ? _value.pendingBalance
            : pendingBalance // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionBalance: null == commissionBalance
            ? _value.commissionBalance
            : commissionBalance // ignore: cast_nullable_to_non_nullable
                  as double,
        minimumFloat: null == minimumFloat
            ? _value.minimumFloat
            : minimumFloat // ignore: cast_nullable_to_non_nullable
                  as double,
        transactionLimit: null == transactionLimit
            ? _value.transactionLimit
            : transactionLimit // ignore: cast_nullable_to_non_nullable
                  as double,
        isFloatSufficient: null == isFloatSufficient
            ? _value.isFloatSufficient
            : isFloatSufficient // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletDataImpl implements _WalletData {
  const _$WalletDataImpl({
    this.availableBalance = 0.0,
    this.pendingBalance = 0.0,
    this.commissionBalance = 0.0,
    this.minimumFloat = 0.0,
    this.transactionLimit = 0.0,
    this.isFloatSufficient = false,
  });

  factory _$WalletDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletDataImplFromJson(json);

  @override
  @JsonKey()
  final double availableBalance;
  @override
  @JsonKey()
  final double pendingBalance;
  @override
  @JsonKey()
  final double commissionBalance;
  @override
  @JsonKey()
  final double minimumFloat;
  @override
  @JsonKey()
  final double transactionLimit;
  @override
  @JsonKey()
  final bool isFloatSufficient;

  @override
  String toString() {
    return 'WalletData(availableBalance: $availableBalance, pendingBalance: $pendingBalance, commissionBalance: $commissionBalance, minimumFloat: $minimumFloat, transactionLimit: $transactionLimit, isFloatSufficient: $isFloatSufficient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletDataImpl &&
            (identical(other.availableBalance, availableBalance) ||
                other.availableBalance == availableBalance) &&
            (identical(other.pendingBalance, pendingBalance) ||
                other.pendingBalance == pendingBalance) &&
            (identical(other.commissionBalance, commissionBalance) ||
                other.commissionBalance == commissionBalance) &&
            (identical(other.minimumFloat, minimumFloat) ||
                other.minimumFloat == minimumFloat) &&
            (identical(other.transactionLimit, transactionLimit) ||
                other.transactionLimit == transactionLimit) &&
            (identical(other.isFloatSufficient, isFloatSufficient) ||
                other.isFloatSufficient == isFloatSufficient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    availableBalance,
    pendingBalance,
    commissionBalance,
    minimumFloat,
    transactionLimit,
    isFloatSufficient,
  );

  /// Create a copy of WalletData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletDataImplCopyWith<_$WalletDataImpl> get copyWith =>
      __$$WalletDataImplCopyWithImpl<_$WalletDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletDataImplToJson(this);
  }
}

abstract class _WalletData implements WalletData {
  const factory _WalletData({
    final double availableBalance,
    final double pendingBalance,
    final double commissionBalance,
    final double minimumFloat,
    final double transactionLimit,
    final bool isFloatSufficient,
  }) = _$WalletDataImpl;

  factory _WalletData.fromJson(Map<String, dynamic> json) =
      _$WalletDataImpl.fromJson;

  @override
  double get availableBalance;
  @override
  double get pendingBalance;
  @override
  double get commissionBalance;
  @override
  double get minimumFloat;
  @override
  double get transactionLimit;
  @override
  bool get isFloatSufficient;

  /// Create a copy of WalletData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletDataImplCopyWith<_$WalletDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) {
  return _WalletTransaction.fromJson(json);
}

/// @nodoc
mixin _$WalletTransaction {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WalletTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletTransactionCopyWith<WalletTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletTransactionCopyWith<$Res> {
  factory $WalletTransactionCopyWith(
    WalletTransaction value,
    $Res Function(WalletTransaction) then,
  ) = _$WalletTransactionCopyWithImpl<$Res, WalletTransaction>;
  @useResult
  $Res call({
    String id,
    String type,
    double amount,
    String status,
    String description,
    String? reference,
    String createdAt,
  });
}

/// @nodoc
class _$WalletTransactionCopyWithImpl<$Res, $Val extends WalletTransaction>
    implements $WalletTransactionCopyWith<$Res> {
  _$WalletTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? status = null,
    Object? description = null,
    Object? reference = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            reference: freezed == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalletTransactionImplCopyWith<$Res>
    implements $WalletTransactionCopyWith<$Res> {
  factory _$$WalletTransactionImplCopyWith(
    _$WalletTransactionImpl value,
    $Res Function(_$WalletTransactionImpl) then,
  ) = __$$WalletTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    double amount,
    String status,
    String description,
    String? reference,
    String createdAt,
  });
}

/// @nodoc
class __$$WalletTransactionImplCopyWithImpl<$Res>
    extends _$WalletTransactionCopyWithImpl<$Res, _$WalletTransactionImpl>
    implements _$$WalletTransactionImplCopyWith<$Res> {
  __$$WalletTransactionImplCopyWithImpl(
    _$WalletTransactionImpl _value,
    $Res Function(_$WalletTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? status = null,
    Object? description = null,
    Object? reference = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$WalletTransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        reference: freezed == reference
            ? _value.reference
            : reference // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletTransactionImpl implements _WalletTransaction {
  const _$WalletTransactionImpl({
    required this.id,
    required this.type,
    required this.amount,
    required this.status,
    required this.description,
    this.reference,
    required this.createdAt,
  });

  factory _$WalletTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final double amount;
  @override
  final String status;
  @override
  final String description;
  @override
  final String? reference;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'WalletTransaction(id: $id, type: $type, amount: $amount, status: $status, description: $description, reference: $reference, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    amount,
    status,
    description,
    reference,
    createdAt,
  );

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletTransactionImplCopyWith<_$WalletTransactionImpl> get copyWith =>
      __$$WalletTransactionImplCopyWithImpl<_$WalletTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletTransactionImplToJson(this);
  }
}

abstract class _WalletTransaction implements WalletTransaction {
  const factory _WalletTransaction({
    required final String id,
    required final String type,
    required final double amount,
    required final String status,
    required final String description,
    final String? reference,
    required final String createdAt,
  }) = _$WalletTransactionImpl;

  factory _WalletTransaction.fromJson(Map<String, dynamic> json) =
      _$WalletTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  double get amount;
  @override
  String get status;
  @override
  String get description;
  @override
  String? get reference;
  @override
  String get createdAt;

  /// Create a copy of WalletTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletTransactionImplCopyWith<_$WalletTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WithdrawalRequest _$WithdrawalRequestFromJson(Map<String, dynamic> json) {
  return _WithdrawalRequest.fromJson(json);
}

/// @nodoc
mixin _$WithdrawalRequest {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;
  String? get mobileNumber => throw _privateConstructorUsedError;
  double? get fee => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WithdrawalRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WithdrawalRequestCopyWith<WithdrawalRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawalRequestCopyWith<$Res> {
  factory $WithdrawalRequestCopyWith(
    WithdrawalRequest value,
    $Res Function(WithdrawalRequest) then,
  ) = _$WithdrawalRequestCopyWithImpl<$Res, WithdrawalRequest>;
  @useResult
  $Res call({
    String id,
    double amount,
    String method,
    String status,
    String? bankName,
    String? accountNumber,
    String? mobileNumber,
    double? fee,
    String createdAt,
  });
}

/// @nodoc
class _$WithdrawalRequestCopyWithImpl<$Res, $Val extends WithdrawalRequest>
    implements $WithdrawalRequestCopyWith<$Res> {
  _$WithdrawalRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? mobileNumber = freezed,
    Object? fee = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            bankName: freezed == bankName
                ? _value.bankName
                : bankName // ignore: cast_nullable_to_non_nullable
                      as String?,
            accountNumber: freezed == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            mobileNumber: freezed == mobileNumber
                ? _value.mobileNumber
                : mobileNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            fee: freezed == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WithdrawalRequestImplCopyWith<$Res>
    implements $WithdrawalRequestCopyWith<$Res> {
  factory _$$WithdrawalRequestImplCopyWith(
    _$WithdrawalRequestImpl value,
    $Res Function(_$WithdrawalRequestImpl) then,
  ) = __$$WithdrawalRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    double amount,
    String method,
    String status,
    String? bankName,
    String? accountNumber,
    String? mobileNumber,
    double? fee,
    String createdAt,
  });
}

/// @nodoc
class __$$WithdrawalRequestImplCopyWithImpl<$Res>
    extends _$WithdrawalRequestCopyWithImpl<$Res, _$WithdrawalRequestImpl>
    implements _$$WithdrawalRequestImplCopyWith<$Res> {
  __$$WithdrawalRequestImplCopyWithImpl(
    _$WithdrawalRequestImpl _value,
    $Res Function(_$WithdrawalRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? method = null,
    Object? status = null,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? mobileNumber = freezed,
    Object? fee = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$WithdrawalRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        bankName: freezed == bankName
            ? _value.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountNumber: freezed == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        mobileNumber: freezed == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        fee: freezed == fee
            ? _value.fee
            : fee // ignore: cast_nullable_to_non_nullable
                  as double?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawalRequestImpl implements _WithdrawalRequest {
  const _$WithdrawalRequestImpl({
    required this.id,
    required this.amount,
    required this.method,
    required this.status,
    this.bankName,
    this.accountNumber,
    this.mobileNumber,
    this.fee,
    required this.createdAt,
  });

  factory _$WithdrawalRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawalRequestImplFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final String method;
  @override
  final String status;
  @override
  final String? bankName;
  @override
  final String? accountNumber;
  @override
  final String? mobileNumber;
  @override
  final double? fee;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'WithdrawalRequest(id: $id, amount: $amount, method: $method, status: $status, bankName: $bankName, accountNumber: $accountNumber, mobileNumber: $mobileNumber, fee: $fee, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawalRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    method,
    status,
    bankName,
    accountNumber,
    mobileNumber,
    fee,
    createdAt,
  );

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawalRequestImplCopyWith<_$WithdrawalRequestImpl> get copyWith =>
      __$$WithdrawalRequestImplCopyWithImpl<_$WithdrawalRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawalRequestImplToJson(this);
  }
}

abstract class _WithdrawalRequest implements WithdrawalRequest {
  const factory _WithdrawalRequest({
    required final String id,
    required final double amount,
    required final String method,
    required final String status,
    final String? bankName,
    final String? accountNumber,
    final String? mobileNumber,
    final double? fee,
    required final String createdAt,
  }) = _$WithdrawalRequestImpl;

  factory _WithdrawalRequest.fromJson(Map<String, dynamic> json) =
      _$WithdrawalRequestImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  String get method;
  @override
  String get status;
  @override
  String? get bankName;
  @override
  String? get accountNumber;
  @override
  String? get mobileNumber;
  @override
  double? get fee;
  @override
  String get createdAt;

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawalRequestImplCopyWith<_$WithdrawalRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommissionBreakdown _$CommissionBreakdownFromJson(Map<String, dynamic> json) {
  return _CommissionBreakdown.fromJson(json);
}

/// @nodoc
mixin _$CommissionBreakdown {
  double get totalEarned => throw _privateConstructorUsedError;
  double get totalDeducted => throw _privateConstructorUsedError;
  double get netCommission => throw _privateConstructorUsedError;
  double get commissionRate => throw _privateConstructorUsedError;
  List<CommissionEntry> get entries => throw _privateConstructorUsedError;

  /// Serializes this CommissionBreakdown to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommissionBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionBreakdownCopyWith<CommissionBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionBreakdownCopyWith<$Res> {
  factory $CommissionBreakdownCopyWith(
    CommissionBreakdown value,
    $Res Function(CommissionBreakdown) then,
  ) = _$CommissionBreakdownCopyWithImpl<$Res, CommissionBreakdown>;
  @useResult
  $Res call({
    double totalEarned,
    double totalDeducted,
    double netCommission,
    double commissionRate,
    List<CommissionEntry> entries,
  });
}

/// @nodoc
class _$CommissionBreakdownCopyWithImpl<$Res, $Val extends CommissionBreakdown>
    implements $CommissionBreakdownCopyWith<$Res> {
  _$CommissionBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommissionBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalEarned = null,
    Object? totalDeducted = null,
    Object? netCommission = null,
    Object? commissionRate = null,
    Object? entries = null,
  }) {
    return _then(
      _value.copyWith(
            totalEarned: null == totalEarned
                ? _value.totalEarned
                : totalEarned // ignore: cast_nullable_to_non_nullable
                      as double,
            totalDeducted: null == totalDeducted
                ? _value.totalDeducted
                : totalDeducted // ignore: cast_nullable_to_non_nullable
                      as double,
            netCommission: null == netCommission
                ? _value.netCommission
                : netCommission // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionRate: null == commissionRate
                ? _value.commissionRate
                : commissionRate // ignore: cast_nullable_to_non_nullable
                      as double,
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<CommissionEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommissionBreakdownImplCopyWith<$Res>
    implements $CommissionBreakdownCopyWith<$Res> {
  factory _$$CommissionBreakdownImplCopyWith(
    _$CommissionBreakdownImpl value,
    $Res Function(_$CommissionBreakdownImpl) then,
  ) = __$$CommissionBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double totalEarned,
    double totalDeducted,
    double netCommission,
    double commissionRate,
    List<CommissionEntry> entries,
  });
}

/// @nodoc
class __$$CommissionBreakdownImplCopyWithImpl<$Res>
    extends _$CommissionBreakdownCopyWithImpl<$Res, _$CommissionBreakdownImpl>
    implements _$$CommissionBreakdownImplCopyWith<$Res> {
  __$$CommissionBreakdownImplCopyWithImpl(
    _$CommissionBreakdownImpl _value,
    $Res Function(_$CommissionBreakdownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommissionBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalEarned = null,
    Object? totalDeducted = null,
    Object? netCommission = null,
    Object? commissionRate = null,
    Object? entries = null,
  }) {
    return _then(
      _$CommissionBreakdownImpl(
        totalEarned: null == totalEarned
            ? _value.totalEarned
            : totalEarned // ignore: cast_nullable_to_non_nullable
                  as double,
        totalDeducted: null == totalDeducted
            ? _value.totalDeducted
            : totalDeducted // ignore: cast_nullable_to_non_nullable
                  as double,
        netCommission: null == netCommission
            ? _value.netCommission
            : netCommission // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionRate: null == commissionRate
            ? _value.commissionRate
            : commissionRate // ignore: cast_nullable_to_non_nullable
                  as double,
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<CommissionEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommissionBreakdownImpl implements _CommissionBreakdown {
  const _$CommissionBreakdownImpl({
    this.totalEarned = 0.0,
    this.totalDeducted = 0.0,
    this.netCommission = 0.0,
    this.commissionRate = 0.0,
    final List<CommissionEntry> entries = const [],
  }) : _entries = entries;

  factory _$CommissionBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommissionBreakdownImplFromJson(json);

  @override
  @JsonKey()
  final double totalEarned;
  @override
  @JsonKey()
  final double totalDeducted;
  @override
  @JsonKey()
  final double netCommission;
  @override
  @JsonKey()
  final double commissionRate;
  final List<CommissionEntry> _entries;
  @override
  @JsonKey()
  List<CommissionEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  String toString() {
    return 'CommissionBreakdown(totalEarned: $totalEarned, totalDeducted: $totalDeducted, netCommission: $netCommission, commissionRate: $commissionRate, entries: $entries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionBreakdownImpl &&
            (identical(other.totalEarned, totalEarned) ||
                other.totalEarned == totalEarned) &&
            (identical(other.totalDeducted, totalDeducted) ||
                other.totalDeducted == totalDeducted) &&
            (identical(other.netCommission, netCommission) ||
                other.netCommission == netCommission) &&
            (identical(other.commissionRate, commissionRate) ||
                other.commissionRate == commissionRate) &&
            const DeepCollectionEquality().equals(other._entries, _entries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalEarned,
    totalDeducted,
    netCommission,
    commissionRate,
    const DeepCollectionEquality().hash(_entries),
  );

  /// Create a copy of CommissionBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionBreakdownImplCopyWith<_$CommissionBreakdownImpl> get copyWith =>
      __$$CommissionBreakdownImplCopyWithImpl<_$CommissionBreakdownImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommissionBreakdownImplToJson(this);
  }
}

abstract class _CommissionBreakdown implements CommissionBreakdown {
  const factory _CommissionBreakdown({
    final double totalEarned,
    final double totalDeducted,
    final double netCommission,
    final double commissionRate,
    final List<CommissionEntry> entries,
  }) = _$CommissionBreakdownImpl;

  factory _CommissionBreakdown.fromJson(Map<String, dynamic> json) =
      _$CommissionBreakdownImpl.fromJson;

  @override
  double get totalEarned;
  @override
  double get totalDeducted;
  @override
  double get netCommission;
  @override
  double get commissionRate;
  @override
  List<CommissionEntry> get entries;

  /// Create a copy of CommissionBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionBreakdownImplCopyWith<_$CommissionBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommissionEntry _$CommissionEntryFromJson(Map<String, dynamic> json) {
  return _CommissionEntry.fromJson(json);
}

/// @nodoc
mixin _$CommissionEntry {
  String get id => throw _privateConstructorUsedError;
  String get jobId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CommissionEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommissionEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionEntryCopyWith<CommissionEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionEntryCopyWith<$Res> {
  factory $CommissionEntryCopyWith(
    CommissionEntry value,
    $Res Function(CommissionEntry) then,
  ) = _$CommissionEntryCopyWithImpl<$Res, CommissionEntry>;
  @useResult
  $Res call({
    String id,
    String jobId,
    double amount,
    double rate,
    String description,
    String createdAt,
  });
}

/// @nodoc
class _$CommissionEntryCopyWithImpl<$Res, $Val extends CommissionEntry>
    implements $CommissionEntryCopyWith<$Res> {
  _$CommissionEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommissionEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobId = null,
    Object? amount = null,
    Object? rate = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            jobId: null == jobId
                ? _value.jobId
                : jobId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            rate: null == rate
                ? _value.rate
                : rate // ignore: cast_nullable_to_non_nullable
                      as double,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommissionEntryImplCopyWith<$Res>
    implements $CommissionEntryCopyWith<$Res> {
  factory _$$CommissionEntryImplCopyWith(
    _$CommissionEntryImpl value,
    $Res Function(_$CommissionEntryImpl) then,
  ) = __$$CommissionEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String jobId,
    double amount,
    double rate,
    String description,
    String createdAt,
  });
}

/// @nodoc
class __$$CommissionEntryImplCopyWithImpl<$Res>
    extends _$CommissionEntryCopyWithImpl<$Res, _$CommissionEntryImpl>
    implements _$$CommissionEntryImplCopyWith<$Res> {
  __$$CommissionEntryImplCopyWithImpl(
    _$CommissionEntryImpl _value,
    $Res Function(_$CommissionEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommissionEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobId = null,
    Object? amount = null,
    Object? rate = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$CommissionEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        jobId: null == jobId
            ? _value.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        rate: null == rate
            ? _value.rate
            : rate // ignore: cast_nullable_to_non_nullable
                  as double,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommissionEntryImpl implements _CommissionEntry {
  const _$CommissionEntryImpl({
    required this.id,
    required this.jobId,
    required this.amount,
    required this.rate,
    required this.description,
    required this.createdAt,
  });

  factory _$CommissionEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommissionEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String jobId;
  @override
  final double amount;
  @override
  final double rate;
  @override
  final String description;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'CommissionEntry(id: $id, jobId: $jobId, amount: $amount, rate: $rate, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, jobId, amount, rate, description, createdAt);

  /// Create a copy of CommissionEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionEntryImplCopyWith<_$CommissionEntryImpl> get copyWith =>
      __$$CommissionEntryImplCopyWithImpl<_$CommissionEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommissionEntryImplToJson(this);
  }
}

abstract class _CommissionEntry implements CommissionEntry {
  const factory _CommissionEntry({
    required final String id,
    required final String jobId,
    required final double amount,
    required final double rate,
    required final String description,
    required final String createdAt,
  }) = _$CommissionEntryImpl;

  factory _CommissionEntry.fromJson(Map<String, dynamic> json) =
      _$CommissionEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get jobId;
  @override
  double get amount;
  @override
  double get rate;
  @override
  String get description;
  @override
  String get createdAt;

  /// Create a copy of CommissionEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionEntryImplCopyWith<_$CommissionEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
