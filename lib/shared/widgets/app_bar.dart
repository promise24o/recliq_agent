import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class RecliqAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showNotifications;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  const RecliqAppBar({
    super.key,
    required this.title,
    this.showNotifications = true,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
    this.leading,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 50),
        child: Container(
          height: preferredSize.height + topPadding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 1, 4, 13).withOpacity(0.15),
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(-5, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
              ),
              child: Row(
                children: [
                  _buildLeading(context),
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  _buildActions(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (leading != null) return leading!;

    if (showBackButton) {
      return GestureDetector(
        onTap: onBackPressed ?? () => Navigator.of(context).pop(),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
    }

    return const SizedBox(width: 40);
  }

  Widget _buildActions(BuildContext context) {
    final List<Widget> actionWidgets = [];

    if (showNotifications) {
      actionWidgets.add(_buildNotificationButton(context));
    }

    if (actions != null) {
      actionWidgets.addAll(actions!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actionWidgets,
    );
  }

  Widget _buildNotificationButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 22,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showNotifications;

  const DashboardAppBar({
    super.key,
    this.title = 'Dashboard',
    this.showNotifications = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return RecliqAppBar(
      title: title,
      showNotifications: showNotifications,
    );
  }
}

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showNotifications;
  final VoidCallback? onBackPressed;

  const PageAppBar({
    super.key,
    required this.title,
    this.showNotifications = false,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return RecliqAppBar(
      title: title,
      showNotifications: showNotifications,
      showBackButton: true,
      onBackPressed: onBackPressed,
    );
  }
}

class SettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const SettingsAppBar({
    super.key,
    required this.title,
    this.actions = const [],
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return RecliqAppBar(
      title: title,
      showNotifications: false,
      showBackButton: true,
      actions: actions,
    );
  }
}