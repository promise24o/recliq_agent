import 'dart:convert';
import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/kyc_status.dart';
import '../../domain/entities/bank.dart';
import '../../domain/entities/kyc_request.dart';
import '../../domain/repositories/kyc_repository.dart';

part 'kyc_store.g.dart';

class KycStore = _KycStore with _$KycStore;

abstract class _KycStore with Store {
  final KycRepository _kycRepository = getIt<KycRepository>();

  @observable
  bool isLoading = true;

  @observable
  bool isInitializing = false;

  @observable
  bool isVerifyingBvn = false;

  @observable
  bool isUploadingDocument = false;

  @observable
  bool isUploadingSelfie = false;

  @observable
  bool isBanksLoading = false;

  @observable
  bool isResolvingAccount = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  KycStatusEntity? kycStatus;

  @observable
  List<Bank> banks = [];

  @observable
  String? resolvedAccountName;

  @observable
  String? selectedBankCode;

  @computed
  bool get canVerifyBvn => 
      kycStatus != null && 
      !kycStatus!.bvnVerified && 
      selectedBankCode != null &&
      resolvedAccountName != null;

  @computed
  bool get canUploadDocument => 
      kycStatus != null && 
      !kycStatus!.documentsUploaded;

  @computed
  bool get canUploadSelfie => 
      kycStatus != null && 
      !kycStatus!.selfieUploaded;

  @computed
  bool get isKycComplete => 
      kycStatus?.status == KycStatusEnum.verified;

  @computed
  bool get isKycPending => 
      kycStatus?.status == KycStatusEnum.pending ||
      kycStatus?.status == KycStatusEnum.inProgress;

  @computed
  bool get isKycRejected => 
      kycStatus?.status == KycStatusEnum.rejected;

  @action
  Future<void> initializeKyc(String userId, KycUserType userType) async {
    isInitializing = true;
    errorMessage = null;
    successMessage = null;

    try {
      final result = await _kycRepository.initializeKyc(
        userId: userId,
        userType: userType,
      );

      result.fold(
        (error) {
          errorMessage = _getHumanizedErrorMessage(error);
        },
        (status) {
          kycStatus = status;
          successMessage = 'KYC initialized successfully';
        },
      );
    } catch (e) {
      errorMessage = 'Failed to initialize KYC: ${e.toString()}';
    } finally {
      isInitializing = false;
    }
  }

  @action
  Future<void> loadKycStatus(String userId) async {
    isLoading = true;
    errorMessage = null;

    try {
      final result = await _kycRepository.getKycStatus(userId);

      result.fold(
        (error) {
          errorMessage = _getHumanizedErrorMessage(error);
        },
        (status) {
          kycStatus = status;
        },
      );
    } catch (e) {
      errorMessage = 'Failed to load KYC status: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadBanks({bool forceRefresh = false}) async {
    isBanksLoading = true;
    errorMessage = null;

    try {
      // Try to load from cache first
      if (!forceRefresh) {
        final cachedBanks = await _getCachedBanks();
        if (cachedBanks.isNotEmpty) {
          banks = cachedBanks;
          isBanksLoading = false;
          return;
        }
      }

      // Fetch from API
      final result = await _kycRepository.getBanks();

      result.fold(
        (error) {
          errorMessage = _getHumanizedErrorMessage(error);
        },
        (bankList) {
          banks = bankList;
          _cacheBanks(bankList); // Cache the banks
        },
      );
    } catch (e) {
      errorMessage = 'Failed to load banks: ${e.toString()}';
    } finally {
      isBanksLoading = false;
    }
  }

  Future<List<Bank>> _getCachedBanks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final banksJson = prefs.getString('cached_banks');
      final cacheTime = prefs.getInt('banks_cache_time');
      
      if (banksJson != null && cacheTime != null) {
        final cacheAge = DateTime.now().millisecondsSinceEpoch - cacheTime;
        // Cache is valid for 7 days (7 * 24 * 60 * 60 * 1000 ms)
        if (cacheAge < 7 * 24 * 60 * 60 * 1000) {
          // Parse cached banks
          final List<dynamic> banksList = jsonDecode(banksJson);
          return banksList.map((bankJson) => Bank.fromJson(bankJson as Map<String, dynamic>)).toList();
        }
      }
    } catch (e) {
      // If cache reading fails, continue with API call
    }
    return [];
  }

  Future<void> _cacheBanks(List<Bank> banks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Serialize banks to JSON
      final banksJson = jsonEncode(banks.map((bank) => bank.toJson()).toList());
      await prefs.setString('cached_banks', banksJson);
      await prefs.setInt('banks_cache_time', DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Ignore caching errors
    }
  }

  @action
  Future<void> resolveBankAccount(String accountNumber, String bankCode) async {
    isResolvingAccount = true;
    errorMessage = null;
    resolvedAccountName = null;

    try {
      final result = await _kycRepository.resolveBankAccount(
        accountNumber: accountNumber,
        bankCode: bankCode,
      );

      result.fold(
        (error) {
          errorMessage = _getHumanizedErrorMessage(error);
        },
        (accountName) {
          resolvedAccountName = accountName;
        },
      );
    } catch (e) {
      errorMessage = 'Failed to resolve account: ${e.toString()}';
    } finally {
      isResolvingAccount = false;
    }
  }

  @action
  Future<void> verifyBvn({
    required String userId,
    required String bvn,
    required String accountNumber,
    required String bankCode,
    required String userName,
  }) async {
    isVerifyingBvn = true;
    errorMessage = null;
    successMessage = null;

    try {
      final request = VerifyBvnRequest(
        userId: userId,
        bvn: bvn,
        accountNumber: accountNumber,
        bankCode: bankCode,
        userName: userName,
      );

      final result = await _kycRepository.verifyBvn(request);

      result.fold(
        (error) {
          // For BVN verification, show the exact error message instead of humanized version
          // This preserves specific API messages like "Name mismatch detected"
          if (error.contains('Name mismatch detected') || 
              error.contains('message":') ||
              error.contains('statusCode":400')) {
            // Extract the exact message from JSON error response
            final match = RegExp(r'"message":"([^"]+)"').firstMatch(error);
            if (match != null) {
              errorMessage = match.group(1);
            } else {
              errorMessage = error;
            }
          } else {
            errorMessage = _getHumanizedErrorMessage(error);
          }
        },
        (response) {
          successMessage = response['message'] ?? 'BVN verification successful';
          // Reload KYC status to get updated limits
          loadKycStatus(userId);
        },
      );
    } catch (e) {
      // For BVN verification, try to extract the exact error message
      if (e.toString().contains('Name mismatch detected') || 
          e.toString().contains('message":')) {
        final match = RegExp(r'"message":"([^"]+)"').firstMatch(e.toString());
        if (match != null) {
          errorMessage = match.group(1);
        } else {
          errorMessage = e.toString();
        }
      } else {
        errorMessage = 'Failed to verify BVN: ${e.toString()}';
      }
    } finally {
      isVerifyingBvn = false;
    }
  }

  @action
  Future<void> uploadDocument(String userId, String documentType, File document) async {
    isUploadingDocument = true;
    errorMessage = null;
    successMessage = null;

    try {
      final request = UploadDocumentRequest(
        userId: userId,
        documentType: documentType,
      );

      final result = await _kycRepository.uploadDocument(
        request: request,
        document: document,
      );

      result.fold(
        (error) {
          errorMessage = _getHumanizedErrorMessage(error);
        },
        (response) {
          successMessage = response['message'] ?? 'Document uploaded successfully';
          // Reload KYC status to get updated document status
          loadKycStatus(userId);
        },
      );
    } catch (e) {
      errorMessage = 'Failed to upload document: ${e.toString()}';
    } finally {
      isUploadingDocument = false;
    }
  }

  @action
  Future<void> uploadSelfie(String userId, File selfie) async {
    isUploadingSelfie = true;
    errorMessage = null;
    successMessage = null;

    try {
      final request = UploadSelfieRequest(userId: userId);

      final result = await _kycRepository.uploadSelfie(
        request: request,
        selfie: selfie,
      );

      result.fold(
        (error) {
          errorMessage = _getHumanizedErrorMessage(error);
        },
        (response) {
          successMessage = response['message'] ?? 'Selfie uploaded successfully';
          // Reload KYC status to get updated selfie status
          loadKycStatus(userId);
        },
      );
    } catch (e) {
      errorMessage = 'Failed to upload selfie: ${e.toString()}';
    } finally {
      isUploadingSelfie = false;
    }
  }

  @action
  void setSelectedBank(String? bankCode) {
    selectedBankCode = bankCode;
    resolvedAccountName = null;
  }

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  String _getHumanizedErrorMessage(String technicalError) {
    if (technicalError.contains('404') || technicalError.contains('not found')) {
      return 'KYC service not found. Please try again later.';
    } else if (technicalError.contains('400') || technicalError.contains('Invalid request')) {
      return 'Invalid information provided. Please check your details and try again.';
    } else if (technicalError.contains('401') || technicalError.contains('Unauthorized')) {
      return 'Your session has expired. Please log in again.';
    } else if (technicalError.contains('500') || technicalError.contains('Server error')) {
      return 'Our servers are having trouble. Please try again in a moment.';
    } else if (technicalError.contains('Network error')) {
      return 'Unable to connect. Please check your internet connection.';
    } else if (technicalError.contains('BVN')) {
      return 'BVN verification failed. Please check your BVN and try again.';
    } else if (technicalError.contains('account')) {
      return 'Account verification failed. Please check your account details.';
    } else if (technicalError.contains('document')) {
      return 'Document upload failed. Please check the file and try again.';
    } else if (technicalError.contains('selfie')) {
      return 'Selfie upload failed. Please check the image and try again.';
    } else {
      return 'Something unexpected happened. Please try again.';
    }
  }
}
