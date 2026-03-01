import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';
import 'package:recliq_agent/features/wallet/presentation/mobx/wallet_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/custom_searchable_dropdown.dart';

class AddBankBottomSheet extends StatefulWidget {
  final WalletStore walletStore;
  final VoidCallback? onAccountAdded;

  const AddBankBottomSheet({
    super.key,
    required this.walletStore,
    this.onAccountAdded,
  });

  @override
  State<AddBankBottomSheet> createState() => _AddBankBottomSheetState();
}

class _AddBankBottomSheetState extends State<AddBankBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  Bank? _selectedBank;

  @override
  void initState() {
    super.initState();
    // Clear any existing verification when opening the bottom sheet
    widget.walletStore.clearBankVerification();
    widget.walletStore.loadSupportedBanks();
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    // Clear verification when bottom sheet is closed
    widget.walletStore.clearBankVerification();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppTheme.spacing16,
          right: AppTheme.spacing16,
          top: AppTheme.spacing16,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 80, // Extra space for floating nav
        ),
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
                    Icons.account_balance,
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
                        'Link Bank Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Select bank and enter account number',
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

            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBankDropdown(),
                      const SizedBox(height: AppTheme.spacing16),
                      _buildAccountNumberField(),
                      _buildVerificationSection(),
                      const SizedBox(height: AppTheme.spacing24),
                      _buildActionButton(),
                      const SizedBox(height: AppTheme.spacing48),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankDropdown() {
    return CustomSearchableDropdown<Bank>(
      items: widget.walletStore.supportedBanks,
      selectedItem: _selectedBank,
      hint: 'Select bank',
      label: 'Bank',
      icon: Icons.account_balance_outlined,
      displayText: (bank) => bank.name,
      searchFilter: (bank) => bank.name.toLowerCase(),
      onChanged: (bank) {
        setState(() {
          _selectedBank = bank;
          widget.walletStore.clearBankVerification();
        });
      },
    );
  }

  Widget _buildAccountNumberField() {
    return TextFormField(
      controller: _accountNumberController,
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: const InputDecoration(
        labelText: 'Account Number',
        hintText: 'Enter 10-digit account number',
        prefixIcon: Icon(Icons.numbers, color: AppTheme.textSecondary),
        counterText: '',
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryGreen),
        ),
        labelStyle: TextStyle(color: AppTheme.textSecondary),
        hintStyle: TextStyle(color: AppTheme.textTertiary),
      ),
      style: const TextStyle(color: AppTheme.textPrimary),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter account number';
        }
        if (value.length != 10) {
          return 'Account number must be 10 digits';
        }
        if (!RegExp(r'^\d+$').hasMatch(value)) {
          return 'Account number must contain only digits';
        }
        return null;
      },
      onChanged: (value) {
        // Clear previous verification when user types
        setState(() {
          widget.walletStore.clearBankVerification();
        });
        
        // Auto-verify when 10 digits are entered
        if (value.length == 10 && 
            _selectedBank != null && 
            RegExp(r'^\d+$').hasMatch(value)) {
          _verifyAccountAutomatically();
        }
      },
    );
  }

  Widget _buildVerificationSection() {
    final verification = widget.walletStore.bankVerification;
    if (verification == null) {
      return const SizedBox.shrink();
    }
    
    return Column(
      children: [
        const SizedBox(height: AppTheme.spacing16),
        _buildVerifiedAccountPreview(),
      ],
    );
  }

  Widget _buildVerifiedAccountPreview() {
    final verification = widget.walletStore.bankVerification!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_rounded, color: AppTheme.primaryGreen, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Account Verified',
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            verification.accountName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${verification.bankName} • ${verification.accountNumber}',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    final hasVerification = widget.walletStore.bankVerification != null;
    final canProceed = hasVerification && _selectedBank != null;

    return Observer(
      builder: (_) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.walletStore.isLoading ? null : (canProceed ? () => _handleAction() : null),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
          ),
          child: widget.walletStore.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  hasVerification ? 'Add Bank Account' : 'Enter 10 digits to verify',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }

  Future<void> _verifyAccountAutomatically() async {
    if (_selectedBank == null) return;
    
    await widget.walletStore.verifyBankAccount(
      bankCode: _selectedBank!.code,
      accountNumber: _accountNumberController.text,
    );
    
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handleAction() async {
    final hasVerification = widget.walletStore.bankVerification != null;

    if (hasVerification) {
      // Link the account
      await widget.walletStore.linkBankAccount(
        bankCode: _selectedBank!.code,
        accountNumber: _accountNumberController.text,
      );
      
      if (widget.walletStore.successMessage != null && mounted) {
        // Clear verification state before closing
        widget.walletStore.clearBankVerification();
        Navigator.pop(context);
        widget.onAccountAdded?.call();
      }
    }
  }
}
