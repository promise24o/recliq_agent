import 'package:flutter/material.dart';
import 'package:recliq_agent/features/wallet/domain/entities/bank.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class BankAccountTile extends StatefulWidget {
  final BankAccount account;
  final VoidCallback onSetDefault;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  const BankAccountTile({
    super.key,
    required this.account,
    required this.onSetDefault,
    required this.onRemove,
    this.onTap,
  });

  @override
  State<BankAccountTile> createState() => _BankAccountTileState();
}

class _BankAccountTileState extends State<BankAccountTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDefault = widget.account.isDefault;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            widget.onTap?.call();
          },
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          child: Transform.scale(
            scale: 1.0 - (_animation.value * 0.02),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: isDefault
                    ? Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3))
                    : null,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Bank icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _getBankColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getBankIcon(),
                          color: _getBankColor(),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Bank info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.account.bankName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                if (isDefault) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Default',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.primaryGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.account.accountName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _maskAccountNumber(widget.account.accountNumber),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textTertiary,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Chevron
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.chevron_right,
                          color: AppTheme.textTertiary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Action buttons - only show when expanded
                  if (_isExpanded)
                    _DetailsSection(
                      account: widget.account,
                      isDefault: isDefault,
                      onSetDefault: widget.onSetDefault,
                      onRemove: widget.onRemove,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getBankColor() {
    // Generate consistent color based on bank name
    final hash = widget.account.bankName.hashCode;
    final colors = [
      AppTheme.primaryGreen,
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.teal,
    ];
    return colors[hash.abs() % colors.length];
  }

  IconData _getBankIcon() {
    // Return different icons based on bank name
    final name = widget.account.bankName.toLowerCase();
    if (name.contains('access')) return Icons.account_balance;
    if (name.contains('gtbank') || name.contains('guaranty')) return Icons.security;
    if (name.contains('first')) return Icons.looks_one;
    if (name.contains('zenith')) return Icons.trending_up;
    if (name.contains('uba') || name.contains('united')) return Icons.public;
    if (name.contains('eco')) return Icons.eco;
    return Icons.account_balance_wallet;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    final masked = '*' * (accountNumber.length - 4);
    return masked + accountNumber.substring(accountNumber.length - 4);
  }
}

class _DetailsSection extends StatelessWidget {
  final BankAccount account;
  final bool isDefault;
  final VoidCallback onSetDefault;
  final VoidCallback onRemove;

  const _DetailsSection({
    required this.account,
    required this.isDefault,
    required this.onSetDefault,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.borderSoft),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              _row('Type', account.type),
              const SizedBox(width: 24),
              _row('Status', account.isActive ? 'Active' : 'Inactive'),
            ],
          ),
          const SizedBox(height: 8),
          _row('Created', _formatDate(account.createdAt)),
          const SizedBox(height: 16),
          
          // Action buttons
          Row(
            children: [
              if (!isDefault)
                Flexible(
                  child: _ActionButton(
                    label: 'Set as Default',
                    icon: Icons.star_outline,
                    color: AppTheme.primaryGreen,
                    onTap: onSetDefault,
                  ),
                ),
              if (!isDefault) const SizedBox(width: 12),
              Flexible(
                child: _ActionButton(
                  label: 'Remove',
                  icon: Icons.delete_outline,
                  color: AppTheme.errorColor,
                  onTap: onRemove,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
