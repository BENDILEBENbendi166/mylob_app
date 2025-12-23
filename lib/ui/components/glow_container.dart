import 'package:flutter/material.dart';
import 'package:mylob_app/ui/colors.dart';
import 'package:mylob_app/ui/shadows.dart';
import 'package:mylob_app/ui/spacing.dart';

/// GlowContainer
/// A container with customizable glow effect
class GlowContainer extends StatelessWidget {
  final Widget child;
  final Color? glowColor;
  final double? glowOpacity;
  final double? glowBlurRadius;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Gradient? gradient;

  const GlowContainer({
    super.key,
    required this.child,
    this.glowColor,
    this.glowOpacity = 0.3,
    this.glowBlurRadius = 16.0,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor = glowColor ?? AppColors.primary;
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(AppSpacing.radiusMd);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        boxShadow: AppShadows.glow(
          color: effectiveGlowColor,
          opacity: glowOpacity!,
          blurRadius: glowBlurRadius!,
        ),
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: gradient == null ? (backgroundColor ?? Colors.white) : null,
          gradient: gradient,
          borderRadius: effectiveBorderRadius,
        ),
        child: child,
      ),
    );
  }
}

/// Predefined glow containers
class PrimaryGlowContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const PrimaryGlowContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      glowColor: AppColors.primary,
      backgroundColor: AppColors.primary,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      margin: margin,
      child: child,
    );
  }
}

class SuccessGlowContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SuccessGlowContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      glowColor: AppColors.success,
      backgroundColor: AppColors.success,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      margin: margin,
      child: child,
    );
  }
}

class SecondaryGlowContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SecondaryGlowContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      glowColor: AppColors.secondary,
      backgroundColor: AppColors.secondary,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      margin: margin,
      child: child,
    );
  }
}
