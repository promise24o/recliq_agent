enum KycStatusEnum {
  pending,
  inProgress,
  pendingAdminApproval,
  verified,
  rejected;

  static KycStatusEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return KycStatusEnum.pending;
      case 'in_progress':
        return KycStatusEnum.inProgress;
      case 'pending_admin_approval':
        return KycStatusEnum.pendingAdminApproval;
      case 'verified':
        return KycStatusEnum.verified;
      case 'rejected':
        return KycStatusEnum.rejected;
      default:
        throw ArgumentError('Invalid KYC status: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case KycStatusEnum.pending:
        return 'Pending Verification';
      case KycStatusEnum.inProgress:
        return 'In Progress';
      case KycStatusEnum.pendingAdminApproval:
        return 'Pending Admin Approval';
      case KycStatusEnum.verified:
        return 'Verified';
      case KycStatusEnum.rejected:
        return 'Rejected';
    }
  }
}

enum KycTier {
  sprout,
  bloom,
  blossom,
  thrive;

  static KycTier fromString(String value) {
    switch (value.toLowerCase()) {
      case 'sprout':
        return KycTier.sprout;
      case 'bloom':
        return KycTier.bloom;
      case 'blossom':
        return KycTier.blossom;
      case 'thrive':
        return KycTier.thrive;
      default:
        throw ArgumentError('Invalid KYC tier: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case KycTier.sprout:
        return 'SPROUT';
      case KycTier.bloom:
        return 'BLOOM';
      case KycTier.blossom:
        return 'BLOSSOM';
      case KycTier.thrive:
        return 'THRIVE';
    }
  }
}

enum KycUserType {
  individual,
  enterprise,
  agent;

  static KycUserType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'individual':
        return KycUserType.individual;
      case 'enterprise':
        return KycUserType.enterprise;
      case 'agent':
        return KycUserType.agent;
      default:
        throw ArgumentError('Invalid KYC user type: $value');
    }
  }

  String toJson() {
    return name;
  }
}

class KycLimits {
  final int dailyWithdrawal;
  final int maxWalletBalance;

  const KycLimits({
    required this.dailyWithdrawal,
    required this.maxWalletBalance,
  });

  factory KycLimits.fromJson(Map<String, dynamic> json) {
    return KycLimits(
      dailyWithdrawal: json['dailyWithdrawal'] as int,
      maxWalletBalance: json['maxWalletBalance'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyWithdrawal': dailyWithdrawal,
      'maxWalletBalance': maxWalletBalance,
    };
  }
}

class KycStatusEntity {
  final String userId;
  final KycUserType userType;
  final KycTier currentTier;
  final KycStatusEnum status;
  final bool emailVerified;
  final bool bvnVerified;
  final bool documentsUploaded;
  final bool selfieUploaded;
  final bool businessDocumentsUploaded;
  final bool businessDetailsSubmitted;
  final List<String> requirements;
  final KycLimits limits;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  const KycStatusEntity({
    required this.userId,
    required this.userType,
    required this.currentTier,
    required this.status,
    required this.emailVerified,
    required this.bvnVerified,
    required this.documentsUploaded,
    required this.selfieUploaded,
    required this.businessDocumentsUploaded,
    required this.businessDetailsSubmitted,
    required this.requirements,
    required this.limits,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KycStatusEntity.fromJson(Map<String, dynamic> json) {
    return KycStatusEntity(
      userId: json['userId'] as String,
      userType: KycUserType.fromString(json['userType'] as String),
      currentTier: KycTier.fromString(json['currentTier'] as String),
      status: KycStatusEnum.fromString(json['status'] as String),
      emailVerified: json['emailVerified'] as bool? ?? false,
      bvnVerified: json['bvnVerified'] as bool? ?? false,
      documentsUploaded: json['documentsUploaded'] as bool? ?? false,
      selfieUploaded: json['selfieUploaded'] as bool? ?? false,
      businessDocumentsUploaded: json['businessDocumentsUploaded'] as bool? ?? false,
      businessDetailsSubmitted: json['businessDetailsSubmitted'] as bool? ?? false,
      requirements: (json['requirements'] as List<dynamic>?)?.cast<String>() ?? (json['nextTierRequirements'] as List<dynamic>?)?.cast<String>() ?? [],
      limits: KycLimits.fromJson(json['limits'] as Map<String, dynamic>),
      rejectionReason: json['rejectionReason'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userType': userType.toJson(),
      'currentTier': currentTier.toJson(),
      'status': status.toJson(),
      'emailVerified': emailVerified,
      'bvnVerified': bvnVerified,
      'documentsUploaded': documentsUploaded,
      'selfieUploaded': selfieUploaded,
      'businessDocumentsUploaded': businessDocumentsUploaded,
      'businessDetailsSubmitted': businessDetailsSubmitted,
      'requirements': requirements,
      'limits': limits.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
