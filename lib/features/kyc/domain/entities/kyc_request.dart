import 'kyc_status.dart';

class InitializeKycRequest {
  final String userId;
  final KycUserType userType;

  const InitializeKycRequest({
    required this.userId,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userType': userType.toJson(),
    };
  }
}

class VerifyBvnRequest {
  final String userId;
  final String bvn;
  final String accountNumber;
  final String bankCode;
  final String userName;

  const VerifyBvnRequest({
    required this.userId,
    required this.bvn,
    required this.accountNumber,
    required this.bankCode,
    required this.userName,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bvn': bvn,
      'accountNumber': accountNumber,
      'bankCode': bankCode,
      'userName': userName,
    };
  }
}

class ResolveAccountRequest {
  final String accountNumber;
  final String bankCode;

  const ResolveAccountRequest({
    required this.accountNumber,
    required this.bankCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
      'bankCode': bankCode,
    };
  }
}

class UploadDocumentRequest {
  final String userId;
  final String documentType;

  const UploadDocumentRequest({
    required this.userId,
    required this.documentType,
  });
}

class UploadSelfieRequest {
  final String userId;

  const UploadSelfieRequest({
    required this.userId,
  });
}
