import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blurAmount;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius = AppTheme.radius16,
    this.blurAmount = 10.0,
    this.backgroundColor,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurAmount,
              sigmaY: blurAmount,
            ),
            child: Container(
              padding: padding ??
                  const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: backgroundColor ??
                    AppTheme.cardBackground.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(borderRadius),
                border: border ??
                    Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
