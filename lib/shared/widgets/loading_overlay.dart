import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isVisible;
  final String? message;
  final Widget? child;

  const LoadingOverlay({
    super.key,
    required this.isVisible,
    this.message,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        if (isVisible)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const _PulseLoadingContent(),
              ),
            ),
          ),
      ],
    );
  }
}

class _PulseLoadingContent extends StatefulWidget {
  const _PulseLoadingContent();

  @override
  State<_PulseLoadingContent> createState() => _PulseLoadingContentState();
}

class _PulseLoadingContentState extends State<_PulseLoadingContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.92, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacity = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.scale(
              scale: _scale.value,
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.35),
                      blurRadius: 26,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/images/launcher-icon.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppTheme.borderSoft),
                        ),
                        child: const Icon(
                          Icons.recycling_rounded,
                          size: 42,
                          color: AppTheme.primaryGreen,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenLoadingOverlay extends StatelessWidget {
  final bool isVisible;
  final String? message;

  const FullScreenLoadingOverlay({
    super.key,
    required this.isVisible,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isVisible: isVisible,
      message: message,
      child: const SizedBox(),
    );
  }
}
