class Bank {
  final String name;
  final String code;

  const Bank({
    required this.name,
    required this.code,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Bank && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;

  @override
  String toString() => 'Bank(name: $name, code: $code)';
}

class BankAccount {
  final String id;
  final String bankName;
  final String bankCode;
  final String accountNumber;
  final String accountName;
  final String type;
  final bool isDefault;
  final bool isActive;
  final DateTime createdAt;

  const BankAccount({
    required this.id,
    required this.bankName,
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
    required this.type,
    this.isDefault = false,
    this.isActive = true,
    required this.createdAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['id'] as String,
      bankName: json['bankName'] as String,
      bankCode: json['bankCode'] as String,
      accountNumber: json['accountNumber'] as String,
      accountName: json['accountName'] as String,
      type: json['type'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class BankVerification {
  final bool status;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String bankCode;

  const BankVerification({
    required this.status,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
  });

  factory BankVerification.fromJson(Map<String, dynamic> json) {
    return BankVerification(
      status: json['status'] as bool,
      accountName: json['accountName'] as String,
      accountNumber: json['accountNumber'] as String,
      bankName: json['bankName'] as String,
      bankCode: json['bankCode'] as String,
    );
  }
}

class BankAccountsResponse {
  final List<BankAccount> bankAccounts;
  final int total;

  const BankAccountsResponse({
    required this.bankAccounts,
    required this.total,
  });

  factory BankAccountsResponse.fromJson(Map<String, dynamic> json) {
    final accountsList = (json['bankAccounts'] as List)
        .map((account) => BankAccount.fromJson(account as Map<String, dynamic>))
        .toList();
    
    return BankAccountsResponse(
      bankAccounts: accountsList,
      total: json['total'] as int,
    );
  }
}

class BanksResponse {
  final List<Bank> banks;

  const BanksResponse({
    required this.banks,
  });

  factory BanksResponse.fromJson(Map<String, dynamic> json) {
    final banksList = (json['banks'] as List)
        .map((bank) => Bank.fromJson(bank as Map<String, dynamic>))
        .toList();
    
    return BanksResponse(banks: banksList);
  }
}
