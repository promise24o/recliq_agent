import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recliq_agent/features/wallet/presentation/mobx/wallet_store.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class BankAccountsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final WalletStore walletStore;
  final VoidCallback onAddAccount;

  const BankAccountsAppBar({
    super.key,
    required this.walletStore,
    required this.onAddAccount,
  });

  @override
  Widget build(BuildContext context) {
    return RecliqAppBar(
      title: 'Bank Accounts',
      showNotifications: false,
      showBackButton: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
