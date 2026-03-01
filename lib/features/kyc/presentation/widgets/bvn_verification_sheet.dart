import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/custom_searchable_dropdown.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../../domain/entities/bank.dart';
import '../mobx/kyc_store.dart';

class BvnVerificationSheet extends StatefulWidget {
  final KycStore kycStore;
  final String userId;
  final List<Bank> banks;

  const BvnVerificationSheet({
    super.key,
    required this.kycStore,
    required this.userId,
    required this.banks,
  });

  @override
  State<BvnVerificationSheet> createState() => _BvnVerificationSheetState();
}

class _BvnVerificationSheetState extends State<BvnVerificationSheet> {
  final _formKey = GlobalKey<FormState>();
  final _bvnController = TextEditingController();
  final _accountNumberController = TextEditingController();
  Bank? _selectedBank;
  String? _accountName;
  bool _isResolvingAccount = false;

  @override
  void dispose() {
    _bvnController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => LoadingOverlay(
        isVisible: _isResolvingAccount || widget.kycStore.isVerifyingBvn,
        message: _isResolvingAccount ? 'Resolving Account...' : 'Verifying BVN...',
        child: Container(
          decoration: const BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: AppTheme.spacing16,
              right: AppTheme.spacing16,
              top: AppTheme.spacing16,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100, // Extra space for floating navbar
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.dividerColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacing8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppTheme.radius8),
                        ),
                        child: const Icon(
                          Icons.verified_user_outlined,
                          color: AppTheme.primaryGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BVN Verification',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            Text(
                              'Verify your Bank Verification Number',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: AppTheme.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Info card
                  _buildInfoCard(),
                  const SizedBox(height: AppTheme.spacing24),

                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bank selection
                        CustomSearchableDropdown<Bank>(
                          items: widget.banks,
                          selectedItem: _selectedBank,
                          hint: 'Select bank',
                          label: 'Bank',
                          icon: Icons.account_balance_outlined,
                          displayText: (bank) => bank.name,
                          searchFilter: (bank) => bank.name.toLowerCase(),
                          onChanged: (bank) {
                            setState(() {
                              _selectedBank = bank;
                              _accountName = null;
                            });
                          },
                        ),
                        const SizedBox(height: AppTheme.spacing16),

                        // Account number
                        _buildAccountNumberField(),
                        const SizedBox(height: AppTheme.spacing16),

                        // Account name display
                        if (_accountName != null) ...[
                          _buildAccountNameDisplay(),
                          const SizedBox(height: AppTheme.spacing16),
                        ],

                        // BVN field
                        _buildBvnField(),
                        const SizedBox(height: AppTheme.spacing24),

                        // Verify button
                        _buildVerifyButton(),
                        const SizedBox(height: AppTheme.spacing16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppTheme.primaryGreen,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              const Text(
                'Important',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          const Text(
            'Your bank account name must match your registered name and the account must be linked to your BVN.',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Number',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        TextFormField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: InputDecoration(
            hintText: 'Enter your 10-digit account number',
            hintStyle: const TextStyle(color: AppTheme.textTertiary),
            filled: true,
            fillColor: AppTheme.surfaceColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: AppTheme.borderSoft),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: AppTheme.borderSoft),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: AppTheme.primaryGreen),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing16,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your account number';
            }
            if (value.length != 10) {
              return 'Account number must be 10 digits';
            }
            return null;
          },
          onChanged: (value) {
            if (value.length == 10 && _selectedBank != null) {
              _resolveAccount();
            }
          },
        ),
      ],
    );
  }

  Widget _buildAccountNameDisplay() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppTheme.primaryGreen,
            size: 20,
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Name',
                  style: TextStyle(
                    color: AppTheme.textTertiary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  _accountName!,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBvnField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BVN (Bank Verification Number)',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        TextFormField(
          controller: _bvnController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          decoration: InputDecoration(
            hintText: 'Enter your 11-digit BVN',
            hintStyle: const TextStyle(color: AppTheme.textTertiary),
            filled: true,
            fillColor: AppTheme.surfaceColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: AppTheme.borderSoft),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: AppTheme.borderSoft),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: AppTheme.primaryGreen),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing16,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your BVN';
            }
            if (value.length != 11) {
              return 'BVN must be 11 digits';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.kycStore.isVerifyingBvn ? null : _handleVerification,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius12),
          ),
        ),
        child: widget.kycStore.isVerifyingBvn
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Verify BVN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _resolveAccount() async {
    if (_isResolvingAccount || _selectedBank == null) return;

    setState(() {
      _isResolvingAccount = true;
      _accountName = null;
    });

    try {
      await widget.kycStore.resolveBankAccount(
        _accountNumberController.text,
        _selectedBank!.code,
      );
      setState(() {
        _accountName = widget.kycStore.resolvedAccountName;
        _isResolvingAccount = false;
      });
    } catch (e) {
      setState(() {
        _isResolvingAccount = false;
      });
    }
  }

  Future<void> _handleVerification() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_accountName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for Bank Account Verification'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // TODO: Get user name from auth store
    final userName = 'User Name'; // Replace with actual user name

    try {
      await widget.kycStore.verifyBvn(
        userId: widget.userId,
        bvn: _bvnController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
        bankCode: _selectedBank!.code,
        userName: userName,
      );

      if (mounted) {
        if (widget.kycStore.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.kycStore.successMessage!),
              backgroundColor: AppTheme.primaryGreen,
            ),
          );
          Navigator.pop(context);
        } else if (widget.kycStore.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.kycStore.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        // Show the exact error message from the exception
        String errorMessage = 'An error occurred during BVN verification';
        
        // Try to extract the message from DioException
        if (e.toString().contains('Name mismatch detected')) {
          errorMessage = 'Name mismatch detected. Please ensure your bank account name matches your registered name.';
        } else if (e.toString().contains('message":')) {
          // Extract JSON message from error string
          final match = RegExp(r'"message":"([^"]+)"').firstMatch(e.toString());
          if (match != null) {
            errorMessage = match.group(1) ?? errorMessage;
          }
        } else if (e.toString().isNotEmpty) {
          errorMessage = e.toString();
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5), // Longer duration for error messages
          ),
        );
      }
    }
  }
}
